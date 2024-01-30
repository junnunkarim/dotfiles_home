local available, luasnip = pcall(require, "luasnip")

if available then
  require("luasnip.loaders.from_vscode").lazy_load()

  luasnip.filetype_extend("quarto", { "markdown" })
  luasnip.filetype_extend("rmarkdown", { "markdown" })
end
