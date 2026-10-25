local options = {
  mappings = {
    enabled = true,
    cmdline = true,
    disabled_filetypes = {},
    wrap = {
      ["<C-b>"] = "motion",
      ["<C-S-b>"] = "motion_reverse",
    },
    pairs = {},
  },
  highlights = {
    enabled = true,
    cmdline = true,
    groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
    unmatched_group = "BlinkPairsUnmatched",

    -- highlights matching pairs under the cursor
    matchparen = {
      enabled = true,
      -- known issue where typing won't update matchparen highlight, disabled by default
      cmdline = false,
      -- also include pairs not on top of the cursor, but surrounding the cursor
      include_surrounding = false,
      group = "BlinkPairsMatchParen",
      priority = 250,
    },
  },
  debug = false,
}

return {
  "saghen/blink.pairs",
  version = "*",
  dependencies = "saghen/blink.download",
  opts = options,
}
