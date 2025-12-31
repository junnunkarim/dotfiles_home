import QtQuick

Item {
  id: stateManager

  property var workspace: {
    "focusedWsIndex": null,
  }

  property var client: {
    "focusedClientIndex": null,
  }

  // example structure:
  // "clients": {
  //   // client id
  //   "6": {
  //     "index": 3,
  //     "wsId": 1,
  //   },
  // }
  property var clients: {}

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
  property var clientsByWs: {}

  function updateClient({
    action = "",
    clientId,
    wsId,
    index,
  }) {
    const clients = stateManager.clients
    const clientsByWs = stateManager.clientsByWs

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

        const oldIndex = stateManager.client["focusedClientIndex"]
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
}
