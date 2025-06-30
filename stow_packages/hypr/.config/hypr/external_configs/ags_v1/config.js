// read the `user_options.json` to get the user-selected theme name
const user_options = JSON.parse(
  Utils.readFile(`${App.configDir}/user_options.json`),
);
const theme_directory = `${App.configDir}/themes/${user_options.theme}`;
const { setup_all_widgets } = await import(`file://${theme_directory}/init.js`);

const scss_directory = `${theme_directory}/styles`;
const css_to_load = `${App.configDir}/temp/main.css`;

const all_widgets = setup_all_widgets(scss_directory, css_to_load);

App.config({
  style: css_to_load,
  windows: all_widgets,
});

export {};
