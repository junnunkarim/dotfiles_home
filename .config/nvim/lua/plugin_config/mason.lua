local available, mason = pcall(require, "mason")

if not available then
  return
end

local options = {
  PATH = "skip",

  --[[
  pip = {
      -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
      upgrade_pip = false,

      -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
      -- and is not recommended.
      --
      -- Example: { "--proxy", "https://proxyserver" }
      install_args = {},
  },

  -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
  -- debugging issues with package installations.
  log_level = vim.log.levels.INFO,

  -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
  -- packages that are requested to be installed will be put in a queue.
  max_concurrent_installers = 4,

  github = {
      -- The template URL to use when downloading assets from GitHub.
      -- The placeholders are the following (in order):
      -- 1. The repository (e.g. "rust-lang/rust-analyzer")
      -- 2. The release version (e.g. "v0.3.0")
      -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
      download_url_template = "https://github.com/%s/releases/download/%s/%s",
  },

  -- The provider implementations to use for resolving package metadata (latest version, available versions, etc.).
  -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
  -- Builtin providers are:
  --   - mason.providers.registry-api (default) - uses the https://api.mason-registry.dev API
  --   - mason.providers.client                 - uses only client-side tooling to resolve metadata
  providers = {
      "mason.providers.registry-api",
  },
  ]]--

  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,

    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "none",

    -- Width of the window. Accepts:
    -- - Integer greater than 1 for fixed width.
    -- - Float in the range of 0-1 for a percentage of screen width.
    width = 0.8,

    -- Height of the window. Accepts:
    -- - Integer greater than 1 for fixed height.
    -- - Float in the range of 0-1 for a percentage of screen height.
    height = 0.9,

    icons = {
      -- The list icon to use for installed packages.
      package_installed = "✓",
      -- The list icon to use for packages that are installing, or queued for installation.
      package_pending = "➜",
      -- The list icon to use for packages that are not installed.
      package_uninstalled = "✗",
    },

    keymaps = {
      -- Keymap to expand a package
      toggle_package_expand = "<CR>",
      -- Keymap to install the package under the current cursor position
      install_package = "i",
      -- Keymap to reinstall/update the package under the current cursor position
      update_package = "u",
      -- Keymap to check for new version for the package under the current cursor position
      check_package_version = "c",
      -- Keymap to update all installed packages
      update_all_packages = "U",
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = "C",
      -- Keymap to uninstall a package
      uninstall_package = "X",
      -- Keymap to cancel a package installation
      cancel_installation = "<C-c>",
      -- Keymap to apply language filter
      apply_language_filter = "<C-f>",
    },
  },
}

mason.setup(options)
