export function create_revealer_box({
  single_widget,
  revealer_container_class__box = "",
  revealer_button_class__btn = "",
  open_icon = "",
  close_icon = "",
  animation = "slide_down",
  animation_duration_ms = 1000,
} = {}) {
  // contains the the single widget
  const revealer = Widget.Revealer({
    revealChild: false,
    transitionDuration: animation_duration_ms,
    transition: animation,

    child: single_widget,
  });

  // button widget to reveal/unreveal the single widget
  const revealer_button = Widget.Button({
    class_name: revealer_button_class__btn,
    label: open_icon,

    on_clicked: (self) => {
      revealer.reveal_child = !revealer.reveal_child;

      if (revealer.revealChild === false) {
        self.label = open_icon;
      } else {
        self.label = close_icon;
      }
    },
  });

  // main container
  const container = Widget.Box({
    class_name: revealer_container_class__box,
    vertical: true,

    children: [revealer, revealer_button],
  });

  return container;
}
