local matugen_colors = {
  <* for name, value in colors *>{{name}} = "{{value.dark.hex}}",
  <* endfor *>
}

return matugen_colors
