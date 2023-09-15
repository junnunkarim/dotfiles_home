local available, clangd = pcall(require, "clangd_extensions")
if not available then
  return
end

clangd.setup()
