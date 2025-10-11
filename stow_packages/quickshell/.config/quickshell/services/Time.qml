// declare this type as a singleton
pragma Singleton

import Quickshell

Singleton {
    id: root

    property alias enabled: clock.enabled

    readonly property date date: clock.date
    readonly property int minutes: clock.minutes
    readonly property int hours: clock.hours

    function format(date_format: string): string {
        return Qt.formatDateTime(clock.date, date_format);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
