local available, alpha = pcall(require, "alpha")
if not available then
  return
end

alpha.setup(require'alpha.themes.dashboard'.config)
