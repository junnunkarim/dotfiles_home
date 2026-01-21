import QtQuick
import Quickshell
import Quickshell.Hyprland

import qs.logic.configs

Item {
  id: root

  property ListModel wsList: ListModel {}
  property ListModel specialWsList: ListModel {}
  property var focusedWs: null

  property ListModel clientList: ListModel {}
  property ListModel focusedWsClientList: ListModel {}
  property var focusedClient: null

  Component.onCompleted: {
    if (Config.options.showInactiveWs) {
      root.prefillWsList(Config.options.wsCount)
    }
  }

  Connections {
    target: Hyprland

    function onRawEvent(event: HyprlandEvent) {
      const eventName = event.name;

      if (
        [
          "openlayer",
          "configreloaded",
          "closelayer",
        ].includes(eventName)
      ) {
        root.updateWsList()
        root.updateClientList(true)
      }
      else if (
        [
          // "workspace",
          "workspacev2",
          // "createworkspace",
          "createworkspacev2",
          // "destroyworkspace",
          "destroyworkspacev2",
          "renameworkspacev2",
        ].includes(eventName)
      ) {
        // console.log(eventName, "fired")
        root.updateWsList()
        root.updateClientList(true)
      }
      else if (
        [
          // "activewindow",
          "activewindowv2",
          // "windowtitle",
          "windowtitlev2",
        ].includes(eventName)
      ) {
        // console.log(eventName, "fired")
        root.updateClientList(true)
      }
      else if (
        [
          "openwindow",
          "closewindow",
          "movewindow",
          "movewindowv2",
          "urgent",
        ].includes(eventName)
      ) {
        root.updateWsList()
        root.updateClientList(true)
      }
    }
  }

  function extractClientData(client) {
    if (!client) {
      return null
    }

    try {
      let wsId = client.workspace?.id ?? 0
      let addr = client.address ?? ""

      if (!wsId || !addr) {
        return null
      }

      return {
        "workspaceId": wsId,
        "address": addr,
        "title": client.title ?? "",
        "appId": client.appId ?? "",
        "monitorId": client.monitor?.id ?? 0,
        "monitorName": client.monitor?.name ?? "",
        "isActive": client.activated === true,
        "isUrgent": client.urgent === true,
        "insideSpecialWs": wsId < 0,
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
      let toplevels = ws.toplevels?.values ?? null
      let clientCount = toplevels?.length ?? 0

      return {
        "id": ws.id,
        "name": ws.name ?? "",
        "monitorId": ws.monitor?.id ?? 0,
        "monitorName": ws.monitor?.name ?? "",
        "isFocused": ws.focused === true,
        "isActive": ws.active === true,
        "isOccupied": clientCount > 0,
        "isUrgent": ws.urgent === true,
        "isSpecialWs": ws.id < 0,
      }
    }
    catch (e) {
      console.log("[Error] HyprlandIPC | Error extracting workspace information: ", e.message)
      console.log("[Stacktrace]:\n", e.stack)
    }
  }

  function getDummyWsData() {
    return {
      // using id -1000 to represent dummy/empty workspace
      "id": -1000,
      "name": "",
      "monitorId": 0,
      "monitorName": "",
      "isFocused": false,
      "isActive": false,
      "isOccupied": false,
      "isUrgent": false,
      "isSpecialWs": false,
    }
  }

  function prefillWsList(count) {
    for (let i = 0; i < count; i++) {
      root.wsList.append(root.getDummyWsData())
    }
  }

  function updateWsList() {
    try {
      let hyprWsList = Hyprland.workspaces?.values ?? null

      if (!hyprWsList) {
        return
      }

      // to find out the count of current special workspaces
      let activeSpcWsCount = 0

      for (let i = 0; i < hyprWsList.length; i++) {
        const ws = hyprWsList[i]

        if (!ws) {
          continue
        }

        const wsData = extractWsData(ws)

        if (wsData) {
          if (ws.focused === true) {
            root.focusedWs = wsData
          }

          // if normal workspace
          if (ws.id > 0) {
            // first workspace id is always 0, second is 1 and so on;
            // fill up the workspace list with dummy values until the length
            // is equal to the current workspace id
            while (root.wsList.count < ws.id) {
              root.wsList.append(root.getDummyWsData())
            }

            // the index will be always available because the list is filled
            // with dummy values if necessary
            root.wsList.set(ws.id - 1, wsData)
          }
          // if special workspace
          else if (ws.id < 0) {
            activeSpcWsCount++

            // first sepcial workspace id is always -98, second one is -97
            // and so on;
            // normalize to use as index
            let normalizedId = 98 + ws.id

            // fill up the special workspace list with dummy values until
            // the length is equal to the current
            // (normalized special workspace id + 1)
            while (root.specialWsList.count < (normalizedId + 1)) {
              root.specialWsList.append(root.getDummyWsData())
            }

            root.specialWsList.set(normalizedId, wsData)
          }
        }
      }

      // if the activeSpcWsCount is not equal to the length of
      // hyprlandIpc.specialWsList, that means there are inactive special
      // workspaces;
      // remove inactive special workspaces
      while (activeSpcWsCount != root.specialWsList.count) {
        root.specialWsList.remove(root.specialWsList.count - 1)
      }
    }
    catch (e) {
      console.log("[Error] HyprlandIPC | Error updating workspaces: ", e.message)
      console.log("[Stacktrace]:\n", e.stack)
    }
  }

  // [TODO]: might need a better implementation
  function updateClientList(focusedWsOnly = true) {
    try {
      let hyprClientList

      if (focusedWsOnly) {
        hyprClientList = Hyprland.focusedWorkspace.toplevels?.values ?? null
      }
      else {
        hyprClientList = Hyprland.toplevels?.values ?? null
      }

      if (!hyprClientList) {
        return
      }

      let oldClientList
      if (focusedWsOnly) {
        oldClientList = root.focusedWsClientList
      }
      else {
        oldClientList = root.clientList
      }

      let newClientList = []

      // fetch the new client information and add that to the newClientList
      for(let i = 0; i < hyprClientList.length; i++) {
        const client = hyprClientList[i]
        if (!client) {
          continue
        }

        const clientData = extractClientData(client)
        if (clientData) {
          if (client.activated === true) {
            root.focusedClient = clientData
          }

          newClientList.push(clientData)
        }
      }

      // create hashmaps based on the "address" of each client for both
      // newClientList and oldClientList for fast lookup
      let uniqueProperty = "address"
      let newClientListMap = new Map(
        newClientList.map(obj => [obj[uniqueProperty], obj])
      );

      let existingMap = new Map()
      for (let i = 0; i < oldClientList.count; i++) {
        const item = oldClientList.get(i)
        existingMap.set(item[uniqueProperty], i)
      }

      // mark the indices that are in oldClientList but not in newClientList
      // for removal
      let indicesToRemove = []
      for (let i = 0; i < oldClientList.count; i++) {
        const propertyValue = oldClientList.get(i)[uniqueProperty]
        const newObj = newClientListMap.get(propertyValue)

        // if an element of newClientList already exists in oldClientList,
        // update that element
        if (newObj) {
          oldClientList.set(i, newObj)
        }
        else {
          // mark for removal
          indicesToRemove.push(i)
        }
      }

      // remove in reverse order to maintain indices
      for (let i = indicesToRemove.length - 1; i >= 0; i--) {
        oldClientList.remove(indicesToRemove[i])
      }

      // append new client information from newClientList that don't exist in
      // the oldClientList
      for (const newObj of newClientList) {
        if (!existingMap.has(newObj[uniqueProperty])) {
          oldClientList.append(newObj)
        }
      }
    } catch (e) {
      console.log("[Error] HyprlandIPC | Error updating windows/clients: ", e.message)
      console.log("[Stacktrace]:\n", e.stack)
    }
  }
}
