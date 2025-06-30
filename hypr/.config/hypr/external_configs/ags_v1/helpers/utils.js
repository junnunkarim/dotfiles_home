export async function execute_cmd(cmd) {
  return Utils.execAsync(cmd).catch((err) => {
    console.error(typeof cmd === "string" ? cmd : cmd.join(" "), err);
    return "";
  });
}

export async function bash(strings, ...values) {
  const cmd =
    typeof strings === "string"
      ? strings
      : strings.flatMap((str, i) => str + `${values[i] ?? ""}`).join("");

  return Utils.execAsync(["bash", "-c", cmd]).catch((err) => {
    console.error(cmd, err);
    return "";
  });
}

export function capture_cmd_output(cmd) {
  return Utils.exec(cmd);
}

export function toggle_popup_applications(launch_cmd, class_name) {
  const clients_json = capture_cmd_output("hyprctl clients -j");
  const clients = JSON.parse(clients_json);

  const client = clients.find((c) => c.class === class_name);

  if (client) {
    execute_cmd(`kill ${client.pid}`);
  } else {
    execute_cmd(launch_cmd);
  }
}
