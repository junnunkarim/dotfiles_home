pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

import qs.configs

Singleton {
  id: hyprlandIpc

  property ListModel wsList: ListModel {}
  property ListModel specialWsList: ListModel {}
  property var focusedWs: null

  property ListModel windowList: ListModel {}
  property ListModel focusedWsWindowList: ListModel {}
  property var focusedWindow: null

  Component.onCompleted: {
    if (Config.options.showInactiveWs) {
      hyprlandIpc.prefillWsList(Config.options.wsCount)
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
        hyprlandIpc.updateWsList()
        hyprlandIpc.updateWindowList()
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
        hyprlandIpc.updateWsList()
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
        hyprlandIpc.updateWindowList()
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
        hyprlandIpc.updateWsList()
        hyprlandIpc.updateWindowList()
      }
    }
  }

  function extractWindowData(window) {
    if (!window) {
      return null
    }

    try {
      let wsId = window.workspace?.id ?? 0
      let addr = window.address ?? ""

      if (!wsId || !addr) {
        return null
      }

      return {
        "workspaceId": wsId,
        "address": addr,
        "title": window.title ?? "",
        "monitorId": window.monitor?.id ?? 0,
        "monitorName": window.monitor?.name ?? "",
        "isActive": window.activated === true,
        "isUrgent": window.urgent === true,
      }
    }
    catch (e) {
      console.log("[Error] HyprlandIPC | Error extracting window data: ", e.message)
      console.log("[Stacktrace]:\n", e.stack)
    }
  }

  function extractWsData(ws) {
    if (!ws) {
      return null
    }

    try {
      let toplevels = ws.toplevels?.values ?? null
      let windowCount = toplevels?.length ?? 0

      return {
        "id": ws.id,
        "name": ws.name ?? "",
        "monitorId": ws.monitor?.id ?? 0,
        "monitorName": ws.monitor?.name ?? "",
        "isFocused": ws.focused === true,
        "isActive": ws.active === true,
        "isOccupied": windowCount > 0,
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
      hyprlandIpc.wsList.append(hyprlandIpc.getDummyWsData())
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
            hyprlandIpc.focusedWs = wsData
          }

          // if normal workspace
          if (ws.id > 0) {
            // first workspace id is always 0, second is 1 and so on;
            // fill up the workspace list with dummy values until the length
            // is equal to the current workspace id
            while (hyprlandIpc.wsList.count < ws.id) {
              hyprlandIpc.wsList.append(hyprlandIpc.getDummyWsData())
            }

            // the index will be always available because the list is filled
            // with dummy values if necessary
            hyprlandIpc.wsList.set(ws.id - 1, wsData)
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
            while (hyprlandIpc.specialWsList.count < (normalizedId + 1)) {
              hyprlandIpc.specialWsList.append(hyprlandIpc.getDummyWsData())
            }

            hyprlandIpc.specialWsList.set(normalizedId, wsData)
          }
        }
      }

      // if the activeSpcWsCount is not equal to the length of
      // hyprlandIpc.specialWsList, that means there are inactive special
      // workspaces;
      // remove inactive special workspaces
      while (activeSpcWsCount != hyprlandIpc.specialWsList.count) {
        hyprlandIpc.specialWsList.remove(hyprlandIpc.specialWsList.count - 1)
      }
    }
    catch (e) {
      console.log("[Error] HyprlandIPC | Error updating workspaces: ", e.message)
      console.log("[Stacktrace]:\n", e.stack)
    }
  }

  // [TODO]: might need a better implementation
  function updateWindowList() {
    try {
      let hyprWindowList = Hyprland.toplevels?.values ?? null

      if (!hyprWindowList) {
        return
      }

      let oldWindowList = hyprlandIpc.windowList
      let newWindowList = []

      // fetch the new window information and add that to the newWindowList
      for(let i = 0; i < hyprWindowList.length; i++) {
        const window = hyprWindowList[i]
        if (!window) {
          continue
        }

        const windowData = extractWindowData(window)
        if (windowData) {
          if (window.activated === true) {
            hyprlandIpc.focusedWindow = windowData
          }

          newWindowList.push(windowData)
        }
      }

      // create hashmaps based on the "address" of each window for both
      // newWindowList and oldWindowList for fast lookup
      let uniqueProperty = "address"
      let newWindowListMap = new Map(
        newWindowList.map(obj => [obj[uniqueProperty], obj])
      );

      let existingMap = new Map()
      for (let i = 0; i < oldWindowList.count; i++) {
        const item = oldWindowList.get(i)
        existingMap.set(item[uniqueProperty], i)
      }

      // mark the indices that are in oldWindowList but not in newWindowList
      // for removal
      let indicesToRemove = []
      for (let i = 0; i < oldWindowList.count; i++) {
        const propertyValue = oldWindowList.get(i)[uniqueProperty]
        const newObj = newWindowListMap.get(propertyValue)

        // if an element of newWindowList already exists in oldWindowList,
        // update that element
        if (newObj) {
          oldWindowList.set(i, newObj)
        }
        else {
          // mark for removal
          indicesToRemove.push(i)
        }
      }

      // remove in reverse order to maintain indices
      for (let i = indicesToRemove.length - 1; i >= 0; i--) {
        oldWindowList.remove(indicesToRemove[i])
      }

      // append new window information from newWindowList that don't exist in
      // the oldWindowList
      for (const newObj of newWindowList) {
        if (!existingMap.has(newObj[uniqueProperty])) {
          oldWindowList.append(newObj)
        }
      }
    } catch (e) {
      console.log("[Error] HyprlandIPC | Error updating windows/clients: ", e.message)
      console.log("[Stacktrace]:\n", e.stack)
    }
  }
}
