import widget_clock from "./subwidgets/clock.js";
import widget_window_title from "./subwidgets/window_title.js";
import widget_workspaces from "./subwidgets/workspaces.js";
import widget_sys_tray from "./subwidgets/sys_tray.js";
import widget_wifi from "./subwidgets/wifi.js";
import widget_volume from "./subwidgets/volume.js";
import widget_brightness from "./subwidgets/brightness.js";
import widget_battery from "./subwidgets/battery.js";

const { create_revealer_box } = await import(
  `file://${App.configDir}/helpers/revealer_box.js`
);

const clock_container = widget_clock();
const window_button_title = widget_window_title();
const workspace_container = widget_workspaces();
const sys_tray_container = widget_sys_tray();
const volume_container = widget_volume();
const brightness_container = widget_brightness();
const wifi_container = widget_wifi();
const battery_container = widget_battery();

const sys_tray_reveal_container = create_revealer_box({
  single_widget: sys_tray_container,
  revealer_container_class__box: "systray_container_reveal__box",
  revealer_button_class__btn: "systray_reveal_button__btn",
  animation: "slide_down",
  animation_duration_ms: 1000,
});

const start_widget = Widget.Box({
  vertical: true,
  children: [clock_container, window_button_title],
});
const center_widget = Widget.Box({
  vertical: true,
  children: [workspace_container],
});
const end_widget = Widget.Box({
  vertical: true,
  vpack: "end",
  children: [
    sys_tray_reveal_container,
    wifi_container,
    volume_container,
    brightness_container,
    battery_container,
  ],
});

// layout of the bar
export const setup_bar = (monitor = 0) =>
  Widget.Window({
    // name has to be unique
    name: `bar-${monitor}`,
    class_name: "window_bar",
    monitor,
    anchor: ["left", "top", "bottom"],
    // [top, right, bottom, left]
    margins: [10, 0, 10, 10],
    exclusivity: "exclusive",
    // widthRequest: 40,
    child: Widget.CenterBox({
      vertical: true,
      startWidget: start_widget,
      centerWidget: center_widget,
      endWidget: end_widget,
    }),
  });
