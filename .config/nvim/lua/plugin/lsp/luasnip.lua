local available, luasnip = pcall(require, "luasnip")

if available then
  require("luasnip.loaders.from_vscode").lazy_load()
end
