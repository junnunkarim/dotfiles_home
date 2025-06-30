const lib_sys_tray = await Service.import("systemtray");

const sys_tray = (item) =>
  Widget.Button({
    class_name: "systray_button_icon__btn",
    tooltipMarkup: item.bind("tooltip_markup"),

    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),

    child: Widget.Icon({
      class_name: "systray_icon__icn",
      icon: item.bind("icon"),
    }),
  });

export default () =>
  Widget.Box({
    class_name: "systray_container__box",
    vertical: true,

    children: lib_sys_tray.bind("items").as((i) => i.map(sys_tray)),
  });
