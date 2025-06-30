import GLib from "gi://GLib";
const { toggle_popup_applications } = await import(
  `file://${App.configDir}/helpers/utils.js`
);

const lib_time = Variable(GLib.DateTime.new_now_local(), {
  poll: [20000, () => GLib.DateTime.new_now_local()], // 20 seconds
});

// const calendar = capture_cmd_output("cal -3");
const tooltip_time_date = lib_time
  .bind()
  // .as((t) => t.format(`󰥔 %I:%M %p\n %A, %d %B %Y\n\n${calendar}`));
  .as((t) => t.format(`󰥔 %I:%M %p\n %A, %d %B %Y`));

const clock_icon = Widget.Label({
  class_name: "clock_icon__lbl",
  label: "󰥔",
});

const clock_string = Widget.Label({
  class_name: "clock_string__lbl",
  // 24-Hour : Minute
  label: lib_time.bind().as((t) => t.format("%H\n%M")),
});

const clock_container = Widget.Box({
  class_name: "clock_container__box",
  vertical: true,

  children: [clock_icon, clock_string],
});

export default () =>
  Widget.Button({
    class_name: "clock_button_container__btn",
    tooltipText: tooltip_time_date,

    child: clock_container,

    on_clicked: () =>
      toggle_popup_applications("kitty --class pop_cal -e calcure", "pop_cal"),
  });
