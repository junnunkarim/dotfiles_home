local buffers = {
  layout = {
    preset = "custom_dropdown",
  },
  win = {
    input = {
      keys = {
        ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
      },
    },
    list = { keys = { ["dd"] = "bufdelete" } },
  },
}

return buffers
