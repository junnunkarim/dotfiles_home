local buffers = {
  -- need to be false, or else the buffer list will sort
  -- each time a buffer is deleted which is annoying
  sort_lastused = false,
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
