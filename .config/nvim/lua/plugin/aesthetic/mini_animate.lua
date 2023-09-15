local available, mini_animate = pcall(require, "mini.animate")
if not available then
  return
end

local options = {}

mini_animate.setup(options)
