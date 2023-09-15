local available, cmp_git = pcall(require, "cmp_git")

if not available then
  return
end

local options = {}

cmp_git.setup(options)
