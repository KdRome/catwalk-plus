import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root
    readonly property bool inPanel: [PlasmaCore.Types.TopEdge, PlasmaCore.Types.RightEdge, PlasmaCore.Types.BottomEdge, PlasmaCore.Types.LeftEdge].includes(
        Plasmoid.location)
    readonly property bool isVertical: Plasmoid.formFactor === PlasmaCore.Types.Vertical
    preferredRepresentation: compactRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground
    compactRepresentation: CompactRepresentation {}
    fullRepresentation: Item {}

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18ndc("plasma_applet_org.kde.plasma.systemmonitor",
                         "@action", "Open System Monitor…")
            icon.name: "utilities-system-monitor"
            priority: Plasmoid.LowPriorityAction
            onTriggered: {
                Qt.openUrlExternally("file:///usr/bin/plasma-systemmonitor")
            }
        }
    ]
}
