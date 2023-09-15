return {
  set_keymap = function(mode, map, command, opts)
    local options = {
      noremap=true,
      silent=true
    }

    if opts then
      options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, map, command, options)
  end
}
