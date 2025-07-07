return {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_markers = {
    ".svelte",
    ".git",
  },
  root_dir = function(bufnr, on_dir)
    local root_files = { 'package.json', '.git' }
    local fname = vim.api.nvim_buf_get_name(bufnr)

    if vim.uv.fs_stat(fname) ~= nil then
      on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
    end
  end,
}
