local available, lastplace = pcall(require, "nvim-lastplace")

if not available then
  return
end

lastplace.setup {
  lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
  lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
  lastplace_open_folds = true
}
