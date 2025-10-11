pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias options: configAdaptor.options
    property alias styles: configAdaptor.styles

    FileView {
        watchChanges: true
        onFileChanged: this.reload()

        adapter: JsonAdapter {
            id: configAdaptor

            property OptionConfig options: OptionConfig {}
            property StyleConfig styles: StyleConfig {}
        }
    }
}
