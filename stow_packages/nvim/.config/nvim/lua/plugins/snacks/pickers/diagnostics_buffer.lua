local diagnostics_buffer = {
  finder = "diagnostics",
  format = "diagnostic",
  sort = {
    fields = { "severity", "file", "lnum" },
  },
  matcher = { sort_empty = true },
  filter = { buf = true },
  layout = {
    preset = "custom_dropdown",
  },
}

return diagnostics_buffer
