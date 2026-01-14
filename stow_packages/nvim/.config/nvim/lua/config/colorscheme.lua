local available, plugin = pcall(require, "base16-colorscheme")

if not available then return end

plugin.with_config({
  telescope = false,
  indentblankline = false,
  notify = true,
  ts_rainbow = true,
  cmp = false,
  illuminate = true,
  dapui = true,
})

local function change_colorscheme(colorscheme)
  vim.cmd.colorscheme(colorscheme or "default")
end

local default_colorscheme = "base16-gruvbox-dark"
local colorscheme = default_colorscheme
local filename = vim.fn.expand('~') .. "/.config/nvim/lua/config/colorscheme_name.lua"

local file_exists = false
local colorscheme_found = false

-- check if file exists and try to load it
local file = io.open(filename, "r")
if file then
  file:close()
  file_exists = true

  -- load the file as a chunk
  local chunk, _ = loadfile(filename)
  if chunk then
    -- execute the file to set up its environment
    local env = {}
    setfenv(chunk, env)
    pcall(chunk)

    -- check if colorscheme variable exists
    if env.colorscheme ~= nil then
      colorscheme = env.colorscheme
      colorscheme_found = true
    end
  end
end

-- if file doesn't exist or color not found, use default and write file
if not file_exists or not colorscheme_found then
  -- write the default color to the file
  file = io.open(filename, "w")

  if file then
    file:write('colorscheme = "' .. default_colorscheme .. '"\n')
    file:close()
  end
end

if colorscheme == "matugen" then
  local colors = require("colors.matugen")

  plugin.setup(colors)
else
  change_colorscheme(colorscheme)
end
