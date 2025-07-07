return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "quarto",
          "pandoc",
          "io",
          "string",
          "print",
          "require",
          "table",
          "awesome",
          "screen",
          "client",
        },
        disable = { "trailing-space" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
