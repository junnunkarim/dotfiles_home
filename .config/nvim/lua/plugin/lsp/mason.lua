local available, mason = pcall(require, "mason")

if not available then
  return
end

local options = {}

mason.setup(options)
