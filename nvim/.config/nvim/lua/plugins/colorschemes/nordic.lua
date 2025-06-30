return {
  "AlexvZyl/nordic.nvim",
  lazy = true,
  -- priority = 1000,
  config = function()
    require("nordic").load()
  end,
}
