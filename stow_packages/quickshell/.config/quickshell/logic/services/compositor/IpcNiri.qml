import QtQuick
import Quickshell
import Quickshell.Io

Item {
  id: root

  property var stateManager: {
    "workspace": {
      "focusedWsIndex": null,
    },
    "client": {
      "focusedClientIndex": null,
    },
    // example structure:
    // "clients": {
    //   // client id
    //   "6": {
    //     "index": 3,
    //     "wsId": 1,
    //   },
    // }
    "clients": {},
    // example structure:
    // "clientsByWs": {
    //   // workspace id
    //   "1": {
    //     // client id
    //     "6": {
    //       "index": 3,
    //     },
    //   },
    // }
    "clientsByWs": {},
  }

  function updateClientState({
    action = "",
    clientId,
    wsId,
    index,
  }) {
    const clients = root.stateManager["clients"]
    const clientsByWs = root.stateManager["clientsByWs"]

    switch (action) {
      case "update":
        if (!clientId || !wsId || !index) {
          return
        }

        if (!clients[clientId]) {
          clients[clientId] = {}
        }
        clients[clientId]["index"] = index
        clients[clientId]["wsId"] = wsId

        if (!clientsByWs[wsId]) {
          clientsByWs[wsId] = {}
        }
        if (!clientsByWs[wsId][clientId]) {
          clientsByWs[wsId][clientId] = {}
        }
        clientsByWs[wsId][clientId]["index"] = index

        break;
      case "updateFocus":
        if (!clientId) {
          return
        }

        const oldIndex = root.stateManager["client"]["focusedClientIndex"]
        // remove old focused client state
        if (oldIndex) {
          root.clientList.get(oldIndex)["isFocused"] = false
        }

        const newIndex = clients[clientId.toString()]["index"];
        if (newIndex) {
          root.stateManager["client"]["focusedClientIndex"] = newIndex

          root.clientList.get(newIndex)["isFocused"] = true
          root.focusedClient = root.clientList.get(newIndex)
        }

        // hacky solution
        for (let i = 0; i < root.focusedWsClientList.count; i++) {
          const client = root.focusedWsClientList.get(i)

          if (client.id === clientId) {
            client.isFocused = true
          }
          else {
            client.isFocused = false
          }
        }

        break;
      default:
        break;
    }
  }

  property ListModel wsList: ListModel {}
  property ListModel specialWsList: ListModel {}
  property var focusedWs: null

  property ListModel clientList: ListModel {}
  property ListModel focusedWsClientList: ListModel {}
  property var focusedClient: null

  readonly property string socketPath: Quickshell.env("NIRI_SOCKET")

  function extractClientData(client) {
    if (!client) {
      return null
    }

    try {
      let wsId = client.workspace_id ?? 0
      if (!wsId) {
        return null
      }

      return {
        "id": client.id,
        "workspaceId": wsId,
        "address": client.address ?? "",
        "title": client.title ?? "",
        "appId": client.app_id ?? "",
        "monitorId": client.monitor?.id ?? 0,
        "monitorName": client.monitor?.name ?? "",
        "isFocused": client.is_focused === true,
        "isUrgent": client.is_urgent === true,
        "isFloating": client.is_floating === true,
        "insideSpecialWs": false,
      }
    }
    catch (e) {
      console.log("[Error] HyprlandIPC | Error extracting client data: ", e.message)
      console.log("[Stacktrace]:\n", e.stack)
    }
  }

  function extractWsData(ws) {
    if (!ws) {
      return null
    }

    try {
      return {
        "id": ws.id,
        "name": ws.name ?? "",
        "monitorId": 0,
        "monitorName": ws.output ?? "",
        "isFocused": ws.is_focused === true,
        "isActive": ws.is_active === true,
        "isOccupied": ws.active_window_id ? true : false,
        "isUrgent": ws.is_urgent === true,
        "isSpecialWs": false,
      }
    }
    catch (e) {
      console.log("[Error] NiriIPC | Error extracting workspace information: ", e.message)
      console.log("[Stacktrace]:\n", e.stack)
    }
  }

  function createWsList({
    wsList = [],
  }) {
    if (!wsList) {
      return
    }

    wsList.sort((a, b) => a.id - b.id);
    root.wsList.clear()

    for (const ws of wsList) {
      const wsData = extractWsData(ws)

      // do not add unnamed workspace
      if (wsData.name) {
        root.wsList.append(wsData)
      }

      if (wsData.isFocused) {
        root.focusedWs = wsData
      }
    }
  }

  function updateWs({
    id = 0,
    propToUpdate = "",
    focused = false,
    occupied = false,
  }) {
    for (let i = 0; i < root.wsList.count; i++) {
      const ws = root.wsList.get(i);

      if (ws.id === id) {
        switch (propToUpdate) {
          case "focused":
            ws.isFocused = focused;
            root.focusedWs = ws;

            break;
          case "occupied":
            ws.isOccupied = occupied;

            break;
          default:
            console.log("[ERROR]: IpcNiri -> `propToUpdate` in `updateWs()` is not supported: propToUpdate =", propToUpdate);

            break;
        }
      }
      else {
        switch (propToUpdate) {
          case "focused":
            ws.isFocused = false;

            break;
          default:
            break;
        }
      }
    }
  }

  function createClientList({
    clientList = [],
  }) {
    if (!clientList) {
      return
    }

    clientList.sort((a, b) => a.id - b.id);
    root.clientList.clear()

    for (let i = 0; i < clientList.length; i++) {
      const clientData = extractClientData(clientList[i])

      if (clientData) {
        root.clientList.append(clientData)

        // update state
        const wsId = clientData.workspaceId.toString()
        const clientId = clientData.id.toString()

        root.updateClientState({
          action: "update",
          clientId: clientId,
          wsId: wsId,
          index: i,
        })

        if (clientData.isFocused) {
          root.focusedClient = clientData
          
          // update state
          // root.stateManager["client"]["focusedClientIndex"] = i
          root.updateClientState({
            action: "updateFocus",
            clientId: clientId,
          })
        }
      }
    }
  }

  function updateWsClientList({
    workspaceId,
  }) {
    if (!workspaceId) {
      return
    }

    root.focusedWsClientList.clear()
    const wsId = workspaceId.toString()
    const clientsByWs = root.stateManager["clientsByWs"]

    if (clientsByWs[wsId]) {
      Object.values(clientsByWs[wsId]).forEach(i => {
        if (i["index"] < root.clientList.count) {
          const client = root.clientList.get(i["index"])
          root.focusedWsClientList.append(client)
        }
      });
    }
  }

  function updateClientList({
    clientId,
    client,
    actionToDo = "",
    focused = false,
    urgent = false,
  }) {
    if (!clientId || !client) {
      return
    }

    switch (actionToDo) {
      case "add":
        break;
      case "update":
        break;
      case "close":
        break;
      case "focus":
        break;
      case "urgent":
        break;
      default:
        break;
    }
  }


  Socket {
    id: eventStreamSocket
    path: root.socketPath
    connected: true

    onConnectionStateChanged: {
      write('"EventStream"\n')
    }

    parser: SplitParser {
      onRead: line => {
        const event = JSON.parse(line);
        // console.log(JSON.stringify(event))

        // when new workspace is created
        if (event.WorkspacesChanged) {
          const e = event.WorkspacesChanged;

          root.createWsList({ wsList: e.workspaces })
        }
        // when a workspace is activated on a monitor
        else if (event.WorkspaceActivated) {
          const e = event.WorkspaceActivated;

          root.updateWs({
            id: e.id,
            propToUpdate: "focused",
            focused: e.focused,
          })
          root.updateWsClientList({ workspaceId: e.id })
        }
        else if (event.WindowsChanged) {
          const e = event.WindowsChanged;

          root.createClientList({ clientList: e.windows })
          root.updateWsClientList({ workspaceId: root.focusedWs.id })
        }
        else if (event.WindowOpenedOrChanged) {
          const e = event.WindowOpenedOrChanged;

          const client = root.extractClientData(e.window)
          const index = -1

          if (root.stateManager["clients"][client.id.toString()]) {
            index = root.stateManager["clients"][client.id.toString()]["index"]
          }
          else {
            index = root.clientList.count

            if (client) {
              root.clientList.append(client)

              root.updateWsClientList({ workspaceId: client.workspaceId })
              root.updateClientState({
                action: "updateFocus",
                clientId: client.id,
              })
            }
          }

          root.updateClientState({
            action: "update",
            clientId: client.id,
            wsId: client.workspaceId,
            index: index,
          })

          // let clientIdFound = false
          //
          // for (let i = 0; i < root.clientList.count; i++) {
          //   const client = root.clientList.get(i)
          //
          //   if (client.id === e.window.id) {
          //     clientIdFound = true
          //
          //     break;
          //   }
          //   else {
          //     client.isFocused = false
          //   }
          // }
          //
          // if (!clientIdFound) {
          //   const client = root.extractClientData(e.window)
          //
          //   if (client) {
          //     root.clientList.append(client)
          //
          //     if (client.isFocused) {
          //       root.focusedClient = client
          //     }
          //
          //     root.updateWsClientList({ workspaceId: client.workspaceId })
          //   }
          // }
        }
        else if (event.WindowClosed) {
          const e = event.WindowClosed;

          for (let i = 0; i < root.clientList.count; i++) {
            const client = root.clientList.get(i)

            if (client.id === e.id) {
              root.clientList.remove(i)
              root.updateWsClientList({ workspaceId: root.focusedWs.id })

              break;
            }
          }
        }
        else if (event.WindowFocusChanged) {
          const e = event.WindowFocusChanged;

          root.updateClientState({
            action: "updateFocus",
            clientId: e.id,
          })

          // console.log("windowFocusId", e.id);
        }
      }
    }
  }
}
