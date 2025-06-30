import { setup_styles } from "./styles/init.js";
import { setup_bar } from "./widgets/bar/init.js";

// called by the main `config.js`
export const setup_all_widgets = (scss_directory, css_to_load) => {
  // generate scss colors and stuffs
  setup_styles(scss_directory, css_to_load);

  // need to return array of gtk widgets
  return [setup_bar()];
};
