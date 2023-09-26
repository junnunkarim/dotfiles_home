local available, cmp = pcall(require, "cmp")
if not available then
  return
end

local cmp_window = require("cmp.utils.window")
local luasnip_present, luasnip = pcall(require, "luasnip")

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 25


local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local get_ws = function (max, len)
  return (" "):rep(max - len)
end

--vim.o.completeopt = "menu,menuone,noselect"

local function border(hl_name)
  --[[
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
  return {
    { "🭽", hl_name },
    { "▔", hl_name },
    { "🭾", hl_name },
    { "▕", hl_name },
    { "🭿", hl_name },
    { "▁", hl_name },
    { "🭼", hl_name },
    { "▏", hl_name },
  }
  ]]--
  return {
    { "▔", hl_name },
    { "▔", hl_name },
    { "▔", hl_name },
    { "", hl_name },
    { "▁", hl_name },
    { "▁", hl_name },
    { "▁", hl_name },
    { "", hl_name },
  }
end

local icons = {
  Text = "  ",
  Method = " 󰆧 ",
  Function = " 󰊕 ",
  Constructor = "  ",
  Field = " 󰇽 ",
  Variable = " 󰂡 ",
  Class = " 󰠱 ",
  Interface = "  ",
  Module = "  ",
  Property = " 󰜢 ",
  Unit = "  ",
  Value = " 󰎠 ",
  Enum = "  ",
  Keyword = " 󰌋 ",
  Snippet = "  ",
  Color = " 󰏘 ",
  File = " 󰈙 ",
  Reference = "  ",
  Folder = " 󰉋 ",
  EnumMember = "  ",
  Constant = " 󰏿 ",
  Struct = "  ",
  Event = "  ",
  Operator = " 󰆕 ",
  TypeParameter = " 󰅲 ",
}

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false

  return info
end

local options = {
  completion = {
    completeopt = 'menu,menuone,preview,noinsert,noselect',
  },
  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = "Normal:CmpPmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      --winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
      --scrollbar = true,
    },
    documentation = {
      border = border "CmpDocBorder",
      winhighlight = "Normal:CmpDoc",
    },
  },
  snippet = {
    expand = function(args)
      if luasnip_present then
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end
    end,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    expandable_indicator = true,
    format = function(_, vim_item)
      local kind = {}
      local document = vim_item.abbr

      kind.kind = (icons[vim_item.kind] or "  ")
      kind.menu = " (" .. (vim_item.kind or "  ") .. ") "
      --kind.abbr = vim_item.abbr

      if #document > MAX_LABEL_WIDTH then
        kind.abbr = vim.fn.strcharpart(document, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
      else
        kind.abbr = document .. get_ws(MAX_LABEL_WIDTH, #document)
      end

      return kind
    end
  },
  experimental = {
    ghost_text = true,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<A-u>"] = cmp.mapping.scroll_docs(-4),
    ["<A-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
     behavior = cmp.ConfirmBehavior.Insert,
     select = true,
    },
    --[[ ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }), ]]
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip_present and luasnip.expand_or_jumpable() then
          --vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end,
      {
        "i",
        "s",
      }),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip_present and luasnip.jumpable(-1) then
          --vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      {
        "i",
        "s",
    }),
    ["`"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip_present and luasnip.jumpable(-1) then
          --vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      {
        "i",
        "s",
    }),
    --['<Esc>'] = cmp.mapping({
      --i = cmp.mapping.abort()
    --}),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- For luasnip users.
    { name = "buffer", keyword_length = 3 },
    --{ name = "cmdline" },
    { name = "nvim_lua" },
    { name = "calc" },
    --{ name = "git" },
    { -- latex_symbols
      name = "latex_symbols",
      option = {
        strategy = 0, -- mixed
      },
    }, -- latex_symbols
    { -- async_path
      --name = "path",
      name = "async_path",
      options = {
        trailing_slash = true,
      } -- options
    }, -- async_path
  }, -- sources
} -- options

--[[
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  --mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  },
  {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})
--]]

cmp.setup(options)

local available_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if available_autopairs then
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
