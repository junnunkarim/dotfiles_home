// declare this type as a singleton
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: timeService
    property string time

    // an object to run the "date" command to get time-date information
    Process {
        // identifier of the object
        id: proc_date
        // command to run
        command: ["date", "+%a, %b %d | %I:%M %p"]
        // running state
        running: true
        // collect output of command when process is complete and bind it
        // to the "text" property of the "clock" item, effectivly updating
        // it

        stdout: StdioCollector {
            onStreamFinished: root.time = this.text
        }
    }

    // an object to run the "proc_date" object after specifc interval
    Timer {
        // 1000 milliseconds is 1 second
        interval: 30000 // 30s
        // running state
        running: true
        // repeat the timer after specified interval
        repeat: true
        // set the "running" property of the process to true after specified
        // interval
        onTriggered: proc_date.running = true
    }
}
