local available, cmp = pcall(require, "cmp")
if not available then
  return
end


local cmp_window = require("cmp.utils.window")
local luasnip_present, luasnip = pcall(require, "luasnip")

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 25


local has_words_before = function()
  --unpack = unpack or table.unpack
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

local function document_border(hl_name)
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
  autocomplete = false,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  }, -- view
  completion = {
    completeopt = 'menu,menuone,preview,noinsert,noselect',
  }, -- completion
  sources = {
    { name = 'otter' },
    { name = "nvim_lsp" },
    { name = 'nvim_lsp_signature_help' },
    { name = "luasnip" }, -- For luasnip users.
    { name = 'pandoc_references' },
    { name = "buffer", keyword_length = 3 },
    { name = "nvim_lua" },
    { name = 'spell', keyword_length = 3, },
    { name = 'treesitter', keyword_length = 3, },
    { name = "calc" },
    { -- latex_symbols
      name = "latex_symbols",
      option = {
        strategy = 0, -- mixed
      },
    }, -- latex_symbols
    { -- async_path
      name = "async_path",
      options = {
        trailing_slash = true,
      } -- options
    }, -- async_path
    --{ name = "cmdline" },
    --{ name = "git" },
  }, -- sources
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
      border = document_border "CmpDocBorder",
      --winhighlight = "Normal:CmpDoc",
    },
  }, -- window
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
  }, -- formatting
  experimental = {
    ghost_text = true,
  }, -- experimental
  mapping = {
    -- ["<C-p>"] = cmp.mapping.select_prev_item(),
    -- ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-n>'] = cmp.mapping(
      function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
          fallback()
        end
      end,
      {
        "i",
        "s",
      }),
    ['<C-p>'] = cmp.mapping(
      function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      {
        "i",
        "s",
      }),
    ["<A-u>"] = cmp.mapping.scroll_docs(-4),
    ["<A-d>"] = cmp.mapping.scroll_docs(4),
    --["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    -- ["<CR>"] = cmp.mapping.confirm {
    --  behavior = cmp.ConfirmBehavior.Insert,
    --  select = true,
    -- },
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    }),
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        --elseif luasnip_present and luasnip.expand_or_jumpable() then
          --vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          --luasnip.expand_or_jump()
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
  }, -- mapping
} -- options

cmp.setup(options)

local available_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if available_autopairs then
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
