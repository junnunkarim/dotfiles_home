-- install jdtls first, for arch linux, it can be found on AUR

local available, jdtls = pcall(require, 'jdtls')
if not available then
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = os.getenv("HOME") .. "/.cache/jdtls_workspace" .. project_name
os.execute("mkdir " .. workspace_dir)

local options = {
  --[[
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', os.getenv("HOME") .. '/.config/nvim/lsp/jdtls/plugins/org.eclipse.equinox.launcher_*.jar',
    '-configuration', os.getenv("HOME") .. '/.config/nvim/lsp/jdtls/config_linux',
    '-data', workspace_dir,
  },
  ]]--

  cmd = { os.getenv("HOME") .. '/.config/nvim/lsp/jdtls/bin/jdtls' },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
  settings = {
    java = {
    }
  },
  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(options)
