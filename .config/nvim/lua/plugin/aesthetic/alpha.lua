local available, alpha = pcall(require, "alpha")
if not available then
  return
end

--alpha.setup(require'alpha.themes.dashboard'.config)

local dashboard = require("alpha.themes.dashboard")
 dashboard.section.header.val = {
  "           ▄ ▄                   ",
  "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
  "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
  "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
  "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
  "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
  "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
  "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
  "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
}

local function footer()
 return '"My Lord increase me in knowledge" - Surah Ta-Ha:114'
end

 dashboard.section.buttons.val = {
   dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files <CR>"),
   dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert <CR>"),
   dashboard.button("r", "󰄉  Recently used files", "<cmd>Telescope oldfiles <CR>"),
   dashboard.button("t", "󰊄  Find text", "<cmd>Telescope live_grep <CR>"),
   dashboard.button("c", "  Configuration", "<cmd>e ~/.config/nvim/lua/<CR>"),
   dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
