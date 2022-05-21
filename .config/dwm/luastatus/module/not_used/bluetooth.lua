-- A widget to display currently connected and paired bluetooth devices.
-- To change output format modify reprint_devices function.

separator = " "

-- Object paths look like /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/somethingsomething
function get_device_mac_address(device_object_path)
    return device_object_path:gsub("/.*/dev_", ""):gsub("/.*", ""):gsub("_", ":")
end

-- For reference bluetoothctl devices output looks like that:
-- Device XX:XX:XX:XX:XX:XX JBL T450BT
-- Device YY:YY:YY:YY:YY:YY Redmi 8
--
-- Function returns mac addresses of all devices.
function get_devices()
    local devices = {}
    local handle = io.popen(string.format("bluetoothctl devices"))
    for line in handle:lines() do
        table.insert(devices, string.match(line, "Device ([%x:]+)"))
    end
    handle:close()
    return devices
end

-- For reference bluetoothctl info output looks like that:
-- Device XX:XX:XX:XX:XX:XX (public)
--         Name: JBL T450BT
--         Alias: JBL T450BT
--         Class: 0xFFFFFFFF
--         Icon: audio-card
--         Paired: yes
--         Trusted: yes
--         Blocked: no
--         Connected: yes
--         LegacyPairing: no
--         UUID: Headset                   (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
--         ...
--         UUID: Handsfree                 (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
--
-- Given this input function returns a following table:
-- [alias]         string  JBL T450BT
-- [blocked]       boolean false
-- [class]         string  0x00240404
-- [connected]     boolean true
-- [icon]          string  audio
-- [legacypairing] boolean false
-- [name]          string  JBL T450BT
-- [paired]        boolean true
-- [trusted]       boolean true
function get_device_info(mac_address)
    if mac_address == nil then
        mac_address = ""
    end
    local device_info = {}
    local handle = io.popen(string.format("bluetoothctl info %s", mac_address))
    for line in handle:lines() do
        local key, value = string.match(line, "(%w+): (.*)")
        -- Filter junk
        if key ~= "UUID" and key ~= nil and value ~= nil then
            key = string.lower(key)
            if key ~= "name" and key ~= "alias" and key ~= "icon" then
                if value == "yes" then
                    value = true
                end
                if value == "no" then
                    value = false
                end
            end
            device_info[key] = value
        end
    end
    handle:close()
    return device_info
end

devices = {}

function reprint_devices()
    local t = {}
    for mac_address, device in pairs(devices) do
        table.insert(t, string.format("%s(%s)", device["name"], mac_address))
    end
    return table.concat(t, separator)
end

widget = {
    plugin = "dbus",
    opts = {
        greet = true,
        -- https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/device-api.txt
        signals = {
            {
                sender = "org.bluez",
                interface = "org.freedesktop.DBus.Properties",
                signal = "PropertiesChanged",
                arg0 = "org.bluez.Device1",
                bus = "system"
            }
        }
    },
    cb = function(t)
        if t.what == "hello" then
            local mac_addresses = get_devices()
            for i, mac_address in pairs(mac_addresses) do
                local device = get_device_info(mac_address)
                if device["connected"] and device["paired"] then
                    devices[mac_address] = device
                end
            end
        elseif t.what == "signal" then
            -- For reference message from dbus looks like that:
            -- table
            -- [1]     string  org.bluez.Device1
            -- [2]     table
            -- [2]     [1]     table
            -- [2]     [1]     [1]     string  SomethingSomething
            -- [2]     [1]     [2]     boolean false
            -- [2]     [2]     table
            -- [2]     [2]     [1]     string  Connected
            -- [2]     [2]     [2]     boolean true
            -- [3]     table
            if t.signal == "PropertiesChanged" then
                for i, message in pairs(t.parameters[2]) do
                    if message[1] == "Connected" or message[1] == "Paired" then
                        local mac_address = get_device_mac_address(t.object_path)
                        if message[2] then
                            local device = get_device_info(mac_address)
                            if device["paired"] then
                                devices[mac_address] = device
                            end
                        else
                            devices[mac_address] = nil
                        end
                    end
                end
            end
        end
        return reprint_devices()
    end
}
