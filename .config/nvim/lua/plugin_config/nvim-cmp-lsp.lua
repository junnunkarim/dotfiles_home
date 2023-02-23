--local available, cmp = pcall(require, "cmp")
--if not available then
--  return
--end

local present, lspconfig = pcall(require, "lspconfig")
if not present then
  return
end

--[[
cmp.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}
]]--

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.clangd.setup {
  capabilities = capabilities,
}

lspconfig.html.setup {
  capabilities = capabilities,
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  }
}
lspconfig.cssls.setup {
  capabilities = capabilities,
}

lspconfig.pyright.setup{}

lspconfig.kotlin_language_server.setup{}

-- not needed, configured in jdtls
--lspconfig.jdtls.setup{}
