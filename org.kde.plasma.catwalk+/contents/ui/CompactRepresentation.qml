import QtQuick
import org.kde.ksvg as KSvg
import QtQuick.Layouts
import org.kde.ksysguard.sensors as Sensors
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.plasmoid

Item {
    id: root
    implicitWidth: mainLayout.implicitWidth
    implicitHeight: mainLayout.implicitHeight
    Layout.preferredWidth: mainLayout.implicitWidth
    Layout.preferredHeight: mainLayout.implicitHeight

    property int iconSize: Kirigami.Units.iconSizes.smallMedium
    property int fontSize: 11

    property real cpuPercentage: cpuSensor.value !== undefined ? cpuSensor.value : 0
    property real ramPercentage: {
        if (ramSensorTotal.value !== undefined && ramSensorTotal.value > 0) {
            return (ramSensorUsed.value / ramSensorTotal.value) * 100
        }
        return 0
    }
    property real gpuPercentage: gpuSensor.value !== undefined ? gpuSensor.value : 0

    property real currentUsagePercentage: {
        switch(plasmoid.configuration.displayMode) {
            case 0: return cpuPercentage
            case 1: return gpuPercentage
            case 2: return ramPercentage
            default: return cpuPercentage
        }
    }

    property string currentLabel: {
        if (!plasmoid.configuration.showLabel) {
            return ""
        }
        switch(plasmoid.configuration.displayMode) {
            case 0: return "CPU: "
            case 1: return "GPU: "
            case 2: return "RAM: "
            default: return "CPU: "
        }
    }

    property string currentMetricName: {
        switch(plasmoid.configuration.displayMode) {
            case 0: return i18n("CPU Usage")
            case 1: return i18n("GPU Usage")
            case 2: return i18n("RAM Usage")
            default: return i18n("CPU Usage")
        }
    }

    RowLayout {
        id: mainLayout
        spacing: Kirigami.Units.smallSpacing

        // Icon left, text right
        KSvg.SvgItem {
            id: svgItem1
            property int sourceIndex: 0
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: iconSize
            Layout.preferredHeight: iconSize
            width: iconSize
            height: iconSize
            visible: !plasmoid.configuration.swapOrder && plasmoid.configuration.type !== 2
            imagePath: Qt.resolvedUrl("../images/my-idle-symbolic.svg")
        }
        PlasmaComponents3.Label {
            id: labelItem1
            Layout.alignment: Qt.AlignVCenter
            text: currentLabel + currentUsagePercentage.toFixed(1) + "%"
            visible: !plasmoid.configuration.swapOrder && plasmoid.configuration.type !== 1
            font.pixelSize: fontSize
        }
        // Text left, icon right
        PlasmaComponents3.Label {
            id: labelItem2
            Layout.alignment: Qt.AlignVCenter
            text: currentLabel + currentUsagePercentage.toFixed(1) + "%"
            visible: plasmoid.configuration.swapOrder && plasmoid.configuration.type !== 1
            font.pixelSize: fontSize
        }
        KSvg.SvgItem {
            id: svgItem2
            property int sourceIndex: 0
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: iconSize
            Layout.preferredHeight: iconSize
            width: iconSize
            height: iconSize
            visible: plasmoid.configuration.swapOrder && plasmoid.configuration.type !== 2
            imagePath: Qt.resolvedUrl("../images/my-idle-symbolic.svg")
        }
    }

    // Sensors and Timer OUTSIDE the RowLayout!
    Sensors.Sensor {
        id: cpuSensor
        sensorId: "cpu/all/usage"
        updateRateLimit: plasmoid.configuration.updateRateLimit
    }
    Sensors.Sensor {
        id: gpuSensor
        sensorId: "gpu/all/usage"
        updateRateLimit: plasmoid.configuration.updateRateLimit
    }
    Sensors.Sensor {
        id: ramSensorUsed
        sensorId: "memory/physical/used"
        updateRateLimit: plasmoid.configuration.updateRateLimit
    }
    Sensors.Sensor {
        id: ramSensorTotal
        sensorId: "memory/physical/total"
        updateRateLimit: plasmoid.configuration.updateRateLimit
    }

    Timer {
        id: switchTimer
        repeat: true
        running: true
        interval: Math.ceil(5000 / Math.sqrt(currentUsagePercentage + 35) - 400)
        onTriggered: {
            var item = plasmoid.configuration.swapOrder ? svgItem2 : svgItem1;
            if (item.sourceIndex == 5) {
                item.sourceIndex = 0
            }
            item.imagePath = (currentUsagePercentage < plasmoid.configuration.idle) ? 
                Qt.resolvedUrl("../images/my-idle-symbolic.svg") : 
                Qt.resolvedUrl("../images/my-active-" + item.sourceIndex + "-symbolic.svg")
            item.sourceIndex += 1
        }
    }

    // tooltip
    Component.onCompleted: { plasmoid.title = currentMetricName }
    onCurrentMetricNameChanged: { plasmoid.title = currentMetricName }
}
