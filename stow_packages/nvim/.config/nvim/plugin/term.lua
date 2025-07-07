-- terminal plugin for neovim
-- supports floating, horizontal split, and vertical split terminals

-- pressing `ESC` twice will go to normal mode in terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- main module table that will be returned
local M = {}

-- state management for different terminal types
-- stores buffer and window ids for each terminal type
-- -1 indicates invalid/uninitialized state
local state = {
  floating = {
    buf = -1, -- buffer id for floating terminal
    win = -1, -- window id for floating terminal
  },
  horizontal = {
    buf = -1, -- buffer id for horizontal split terminal
    win = -1, -- window id for horizontal split terminal
  },
  vertical = {
    buf = -1, -- buffer id for vertical split terminal
    win = -1, -- window id for vertical split terminal
  },
}

-- default configuration
-- these values can be overridden by user via setup() function
local default_config = {
  floating = {
    -- percentage of screen width
    width = 0.8,
    -- percentage of screen height
    height = 0.8,
    -- border name from vim `winborder`
    border = "rounded",
    title = " terminal (float) ",
    title_pos = "center",
  },
  horizontal = {
    height = 0.45,
    -- position: "top" or "bottom"
    position = "bottom",
  },
  vertical = {
    width = 0.4,
    -- position: "left" or "right"
    position = "right",
  },
}

-- merge user config with defaults
-- starts with default config, user config will override defaults
local config = vim.tbl_deep_extend("force", default_config, {})

-- helper function to calculate dimensions
-- converts percentage values to actual pixel/character dimensions
-- @param type_config: config table for specific terminal type
-- @param is_width: boolean, true for width calculation, false for height
local function get_dimensions(type_config, is_width)
  local total = is_width and vim.o.columns or vim.o.lines
  local percentage = is_width and type_config.width or type_config.height

  return math.floor(total * percentage)
end

-- create floating window
-- creates a centered floating window with specified dimensions
-- @param opts: table with optional width, height, and buf parameters
local function create_floating_window(opts)
  opts = opts or {}

  -- calculate window dimensions based on config percentages
  local width = opts.width or get_dimensions(config.floating, true)
  local height = opts.height or get_dimensions(config.floating, false)

  -- calculate position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- create or reuse buffer
  local buf = nil

  if vim.api.nvim_buf_is_valid(opts.buf) then
    -- reuse existing buffer
    buf = opts.buf
  else
    -- create new scratch buffer
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- window configuration
  local win_config = {
    -- relative to the entire editor
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    -- no line numbers, status line, etc.
    style = "minimal",
    border = config.floating.border,
    title = config.floating.title,
    title_pos = config.floating.title_pos,
  }

  -- create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- create split terminal
-- creates either horizontal or vertical split based on split_type
-- @param opts: table with optional width/height and buf parameters
-- @param split_type: string, either "horizontal" or "vertical"
local function create_split(opts, split_type)
  opts = opts or {}

  local width
  local height

  -- calculate dimensions based on split type
  if split_type == "vertical" then
    width = opts.width or get_dimensions(config.vertical, true)
  else
    height = opts.height or get_dimensions(config.horizontal, false)
  end

  -- create or reuse buffer
  local buf = nil

  if vim.api.nvim_buf_is_valid(opts.buf) then
    -- reuse existing buffer
    buf = opts.buf
  else
    -- create new scratch buffer
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- create split based on position
  if split_type == "vertical" then
    if config.vertical.position == "left" then
      -- create vertical split on left
      vim.cmd("topleft vsplit")
    else
      -- create vertical split on right
      vim.cmd("botright vsplit")
    end

    -- resize to desired width
    vim.cmd("vertical resize " .. width)
  else
    if config.horizontal.position == "top" then
      -- create horizontal split on top
      vim.cmd("topleft split")
    else
      -- create horizontal split on bottom
      vim.cmd("botright split")
    end

    -- resize to desired height
    vim.cmd("resize " .. height)
  end

  -- set buffer in the new window
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  return { buf = buf, win = win }
end

-- get current buffer's directory
-- returns the directory of the currently active buffer
-- falls back to current working directory if buffer has no file
local function get_current_buffer_dir()
  local current_buf = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(current_buf)

  if buf_name and buf_name ~= "" then
    -- get directory of current file
    -- local dir = vim.fn.expand("%:p:h")
    local dir = buf_name:match("^(.*)/[^/]+$")

    -- check if directory exists
    if vim.fn.isdirectory(dir) == 1 then
      -- return
      return dir
    end
  end

  -- fallback to current working directory
  return vim.fn.getcwd()
end

-- terminal toggle
-- main function to toggle terminal visibility
-- creates new terminal if doesn't exist, toggles visibility if exists
-- @param terminal_type: string, one of "floating", "horizontal", "vertical"
local function toggle_terminal(terminal_type)
  local terminal_state = state[terminal_type]

  -- get the directory of the last active buffer
  -- must get it before a new buffer is created
  local target_dir = get_current_buffer_dir()

  -- check if terminal window exists and is valid
  -- if window doesn't exist or was closed, need to create/show it
  if not vim.api.nvim_win_is_valid(terminal_state.win) then
    local result

    -- create new terminal window based on the specified type
    -- each type has different positioning and sizing behavior
    if terminal_type == "floating" then
      result = create_floating_window({ buf = terminal_state.buf })
    elseif terminal_type == "horizontal" then
      result = create_split({ buf = terminal_state.buf }, "horizontal")
    elseif terminal_type == "vertical" then
      result = create_split({ buf = terminal_state.buf }, "vertical")
    end

    -- if window creation was successful
    if result then
      -- update state with new buffer and window ids
      -- this keeps track of the terminal for future toggles
      state[terminal_type] = result

      -- check if buffer needs to be initialized as a terminal
      -- buftype will be "terminal" if it's already a terminal buffer
      if vim.bo[result.buf].buftype ~= "terminal" then
        -- execute commands in the context of the new buffer
        -- this ensures lcd and terminal commands affect the right buffer
        vim.api.nvim_buf_call(result.buf, function()
          -- change local directory to target directory
          -- lcd affects only the current buffer/window
          vim.cmd("lcd " .. vim.fn.fnameescape(target_dir))
          -- start terminal in the buffer
          vim.cmd("terminal")
        end)
      end
    end

    -- enter insert mode in the terminal
    -- this puts cursor in terminal input mode for immediate typing
    vim.cmd("startinsert")
  else
    -- hide/close existing terminal
    -- will not kill it
    if terminal_type == "floating" then
      vim.api.nvim_win_hide(terminal_state.win)
    else
      vim.api.nvim_win_close(terminal_state.win, false)
    end
  end
end

-- setup function to configure the plugin
-- allows users to override default configuration
-- @param opts: table with configuration options
function M.setup(opts)
  config = vim.tbl_deep_extend("force", default_config, opts or {})
end

-- export toggle functions
-- public api functions for toggling different terminal types
M.toggle_floating = function() toggle_terminal("floating") end
M.toggle_horizontal = function() toggle_terminal("horizontal") end
M.toggle_vertical = function() toggle_terminal("vertical") end

-- TODO: convert to toggle_all, so that it can also show all terminals
-- hide all open terminals
-- closes all terminal windows but keeps buffers alive
M.hide_all = function()
  for terminal_type, terminal_state in pairs(state) do
    if vim.api.nvim_win_is_valid(terminal_state.win) then
      if terminal_type == "floating" then
        vim.api.nvim_win_hide(terminal_state.win)
      else
        vim.api.nvim_win_close(terminal_state.win, false)
      end
    end
  end
end

-- kill all terminal buffers and close windows
-- completely destroys all terminal buffers and resets state
M.kill_all = function()
  for terminal_type, terminal_state in pairs(state) do
    -- close window if valid
    if vim.api.nvim_win_is_valid(terminal_state.win) then
      if terminal_type == "floating" then
        vim.api.nvim_win_hide(terminal_state.win)
      else
        vim.api.nvim_win_close(terminal_state.win, false)
      end
    end

    -- kill buffer if valid
    if vim.api.nvim_buf_is_valid(terminal_state.buf) then
      vim.api.nvim_buf_delete(terminal_state.buf, { force = true })
    end

    -- reset state
    state[terminal_type] = {
      buf = -1,
      win = -1,
    }
  end
end

-- create user command to toggle based on argument
vim.api.nvim_create_user_command("SelfTerm", function(opts)
  local term_type = opts.args or "floating"

  if term_type == "float" then
    M.toggle_floating()
  elseif term_type == "horizontal" then
    M.toggle_horizontal()
  elseif term_type == "vertical" then
    M.toggle_vertical()
  elseif term_type == "hide_all" then
    M.hide_all()
  elseif term_type == "kill_all" then
    M.kill_all()
  else
    vim.notify("Invalid terminal type: " .. term_type, vim.log.levels.ERROR)
  end
end, {
  nargs = "?", -- optional argument
  complete = function()
    -- provide completion options for the command
    return {
      "float",
      "horizontal",
      "vertical",
      "hide_all",
      "kill_all",
    }
  end,
  desc = "Toggle terminal with specified type or perform hide/kill actions",
})

return M
