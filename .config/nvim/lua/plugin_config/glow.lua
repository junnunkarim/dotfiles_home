local available, glow = pcall(require, "glow")
if not available then
  return
end

local options = {
  style = "dark",
  width = 120,
}

glow.setup(options)
