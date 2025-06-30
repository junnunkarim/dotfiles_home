return {
  enabled = true,
  preset = {
    header = "Someone at Somewhere doing Something",
  },
  sections = {
    { section = "header" },
    { section = "keys", gap = 1, padding = 1 },
    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
    { section = "startup" },
  },
}
