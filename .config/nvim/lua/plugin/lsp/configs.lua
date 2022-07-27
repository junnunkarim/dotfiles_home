local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = { "jsonls", "sumneko_lua" }

lsp_installer.setup {
	ensure_installed = servers
}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("plugin.lsp.handlers").on_attach,
		capabilities = require("plugin.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "plugin.lsp.settings." .. server)
	if has_custom_opts then
	 	opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	lspconfig[server].setup(opts)
end
