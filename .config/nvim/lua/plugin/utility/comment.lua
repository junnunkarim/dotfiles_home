local available, comment = pcall(require, "Comment")

if not available then
  return
end

local options = {}

comment.setup(options)
