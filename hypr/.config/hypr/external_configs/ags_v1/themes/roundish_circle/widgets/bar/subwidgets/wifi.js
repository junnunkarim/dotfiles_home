// import { toggle_popup_applications } from "../../helpers/utils.js";
const { toggle_popup_applications } = await import(
  `file://${App.configDir}/helpers/utils.js`
);

const lib_network = await Service.import("network");

const wifi_icon = Widget.Icon({
  class_name: "wifi_icon__icn",
  icon: lib_network.wifi.bind("icon_name"),
});

export default () =>
  Widget.Button({
    class_name: "wifi_container__btn",
    tooltipText: lib_network.wifi
      .bind("ssid")
      .as((ssid) => ` Wifi SSID: ${ssid}` || "unknown"),

    on_clicked: () =>
      toggle_popup_applications("nm-connection-editor", "nm-connection-editor"),

    child: wifi_icon,
  });
