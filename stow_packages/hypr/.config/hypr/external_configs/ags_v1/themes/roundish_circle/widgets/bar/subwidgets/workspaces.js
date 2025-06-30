const lib_hyprland = await Service.import("hyprland");

const workspace_count = 9;
const workspace_labels = {
  1: "",
  2: "󰅨",
  3: "󰉋",
  4: "",
  5: "",
  6: "",
  7: "󰍡",
  8: "",
  9: "󰌴",
};

const create_ws_icon = (workspace_id) =>
  Widget.Label({
    class_name: "workspace_icon__lbl",
    label: workspace_labels[workspace_id],
  });

const create_ws_client_count = () => {
  const label = Widget.Label({
    class_name: "workspace_client_count__lbl",
  });

  return Widget.Revealer({
    revealChild: true,
    transitionDuration: 500,
    transition: "slide_down",

    child: label,
  });
};

const ws_item = (workspace_id) =>
  Widget.Box({
    vertical: true,
    class_name: "workspace_item__box",

    setup: (self) => {
      // these two child widgets are instantiated for each ws_item widget
      const ws_icon = create_ws_icon(workspace_id);
      const ws_client_count = create_ws_client_count();

      // add child widgets;
      // widget, expand, fill, padding;
      self.pack_start(ws_icon, false, false, 0);
      self.pack_end(ws_client_count, false, false, 0);

      // hook into hyprland's state and update the button's state based on the workspace status;
      self.hook(lib_hyprland, () => {
        // lib_hyprland.messageAsync(`notify 1 5000 0 "Current Workspace"`);
        // get the client count in current workspace
        const client_count = lib_hyprland.getWorkspace(workspace_id)?.windows ||
          0;
        // check if the current workspace is active or not
        const is_active = lib_hyprland.active.workspace.id === workspace_id;
        // check if the current workspace has clients/windows or not
        const is_occupied = client_count > 0;

        // toggle widget visibility if workspace is active or occupied
        // self.visible = is_active || is_occupied;

        // first add the class name, afterwards toggle the class names depending on active/occupied state
        self.toggleClassName("workspace_item_active__box", is_active);
        self.toggleClassName("workspace_item_occupied__box", is_occupied);

        self.set_tooltip_text(` Client/Window Count: ${client_count}`);

        // show client count only if the current workspace is active
        if (is_active) {
          ws_client_count.reveal_child = true;
          ws_client_count.child.set_label(`${client_count}`);
        } else {
          ws_client_count.reveal_child = false;
        }
      });
    },
  });

const ws_item_button = (workspace_id) =>
  Widget.Button({
    class_name: "workspace_item_container__btn",

    on_clicked: () =>
      lib_hyprland.messageAsync(`dispatch workspace ${workspace_id}`),

    child: ws_item(workspace_id),
  });

const ws_item_revealer = (workspace_id) =>
  Widget.Revealer({
    revealChild: false,
    transitionDuration: 1000,
    transition: "slide_up",

    child: ws_item_button(workspace_id),

    setup: (self) => {
      // hook into hyprland's state and update the button's state based on the workspace status
      self.hook(lib_hyprland, () => {
        // get the client count in current workspace
        const client_count = lib_hyprland.getWorkspace(workspace_id)?.windows ||
          0;
        // check if the current workspace is active or not
        const is_active = lib_hyprland.active.workspace.id === workspace_id;
        // check if the current workspace has clients/windows or not
        const is_occupied = client_count > 0;

        // toggle widget visibility if workspace is active or occupied
        self.revealChild = is_active || is_occupied;
      });
    },
  });

export default () =>
  Widget.Box({
    class_name: "workspace_container__box",
    vertical: true,

    // create buttons for workspaces 1 to 9
    children: [...Array(workspace_count).keys()].map((i) =>
      ws_item_revealer(i + 1)
    ),
  });
