import { get_colors_vars } from "./colorschemes_vars.js";
const { execute_cmd } = await import(
  `file://${App.configDir}/helpers/utils.js`
);

// function to generate scss color variables
const scss_format = (name, value) => `$${name}: ${value};`;

// all scss color variables
const colors_to_write = (colors_vars) => [
  "// This file is auto-generated using the `generate_colors_vars` javascript function\n",
  scss_format("label_fg", colors_vars.label_fg),
  "", // separator
  scss_format("bar_bg", colors_vars.bar_bg),
  "", // separator
  scss_format("clock_container_bg", colors_vars.clock_container_bg),
  scss_format("clock_icon_bg", colors_vars.clock_icon_bg),
  scss_format("clock_icon_fg", colors_vars.clock_icon_fg),
  scss_format("clock_label_fg", colors_vars.clock_label_fg),
  scss_format("clock_border", colors_vars.clock_border),
  "", // separator
  scss_format("window_title_border", colors_vars.window_title_border),
  "", // separator
  scss_format(
    "workspace_item_active_icon_bg",
    colors_vars.workspace_item_active_icon_bg,
  ),
  scss_format(
    "workspace_item_active_icon_fg",
    colors_vars.workspace_item_active_icon_fg,
  ),
  scss_format(
    "workspace_item_active_container_bg",
    colors_vars.workspace_item_active_container_bg,
  ),
  scss_format(
    "workspace_item_active_label_fg",
    colors_vars.workspace_item_active_label_fg,
  ),
  scss_format("workspace_border", colors_vars.workspace_border),
  "", // separator
  scss_format("systray_bg", colors_vars.systray_bg),
  "", // separator
  scss_format("battery_container_bg", colors_vars.battery_container_bg),
  scss_format(
    "battery_container_charging_bg",
    colors_vars.battery_container_charging_bg,
  ),
  scss_format("battery_label_fg", colors_vars.battery_label_fg),
  scss_format(
    "battery_label_charging_fg",
    colors_vars.battery_label_charging_fg,
  ),
  scss_format("battery_icon_fg", colors_vars.battery_icon_fg),
  scss_format("battery_icon_bg", colors_vars.battery_icon_bg),
  scss_format("battery_icon_charging_bg", colors_vars.battery_icon_charging_bg),
  scss_format("battery_border", colors_vars.battery_border),
  scss_format("battery_border_charging", colors_vars.battery_border_charging),
];

const vars_to_write = (colors_vars) => {
  // NOTE: i could also store these vars in the `user_options.json` file and get
  // them from there
  const font_name = "Iosevka";
  const font_size = "95%";
  // top-left top-right bottom-right bottem-left
  const border_radius = "0rem 1rem 1rem 0rem";
  const bar_border_radius = "1rem 1rem 1rem 1rem";
  const top_edge_border_radius = "0.7rem 1rem 1rem 0rem";
  const bottom_edge_border_radius = "0rem 1rem 1rem 0.7rem";
  const square_radius = "0rem 0rem 0rem 0rem";

  const bar_opacity = colors_vars.bar_opacity;
  const transition_animation = "all 0.5s ease-in-out";
  // const transition_animation = "all 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)";

  return [
    "// This file is auto-generated using the `generate_vars` javascript function\n",
    scss_format("font", font_name),
    "", // separator
    scss_format("font_size", font_size),
    scss_format("icon_size", "$font_size * 1.15"),
    scss_format("icon_glyph_size", "$icon_size * 1.6"),
    "", // separator
    scss_format("border_radius", border_radius),
    scss_format("bar_border_radius", bar_border_radius),
    scss_format("top_edge_border_radius", top_edge_border_radius),
    scss_format("bottom_edge_border_radius", bottom_edge_border_radius),
    "", // separator
    scss_format("bar_opacity", bar_opacity),
    "", // separator
    scss_format("transition_animation", transition_animation),
  ];
};

// called by the `init.js` in the `styles` directory
export const generate_colors = (user_options) => {
  // TODO: this function is getting executed multiple times, need to fix this
  console.log(`LOG: Loaded Colorscheme - "${user_options.colorscheme}"`);

  // get the json object of the selected colorscheme
  const colors_vars = get_colors_vars(user_options.colorscheme);
  const scss_colors_location =
    `${App.configDir}/themes/${user_options.theme}/styles/_colors.scss`;

  // switch border color of hyprland
  execute_cmd(
    `hyprctl keyword general:col.active_border "rgba(${colors_vars.hyprland_border}ff)"`,
  );

  // write the scss color variables to the `_colors.scss`
  // file each time the colorscheme changes
  Utils.writeFile(
    colors_to_write(colors_vars).join("\n"),
    scss_colors_location,
  );
};

// NOTE: if i want different css values for horizontal and vertical bars,
// i could do is to create a scss variable named `vertical` that contains
// boolean values. depending on this variable, i could use conditionals to load
// different values
export const generate_vars = (user_options) => {
  const colors_vars = get_colors_vars(user_options.colorscheme);
  const scss_vars_location =
    `${App.configDir}/themes/${user_options.theme}/styles/_vars.scss`;

  // write the scss variables to the `_vars.scss`
  Utils.writeFile(vars_to_write(colors_vars).join("\n"), scss_vars_location);
};
