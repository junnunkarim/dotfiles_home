const lib_hyprland = await Service.import("hyprland");

const window_title = Widget.Label({
  class_name: "window_title__lbl",
  label: lib_hyprland.active.client.bind("title"),
  // makes it vertical
  angle: 90,
  vexpand: true,

  // prevents the widget from taking up all the visible space
  // if the window title is too long
  widthChars: 25,
  // maxWidthChars: 25,
  truncate: "end",
  justification: "center",
});

const window_title_button__btn = Widget.Button({
  class_name: "window_title__btn",
  tooltipText: lib_hyprland.active.client
    .bind("title")
    .as((title) => ` Window Name: "${title}"`),

  child: window_title,
});

export default () => window_title_button__btn;
