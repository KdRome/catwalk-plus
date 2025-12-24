import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property int cfg_displayModeDefault: 0
    property int cfg_idleDefault: 5
    property bool cfg_showLabelDefault: true
    property int cfg_typeDefault: 0
    property int cfg_updateRateLimitDefault: 1000

    property alias cfg_idle: idleSlider.value
    property alias cfg_type: typeBox.currentIndex
    property alias cfg_updateRateLimit: updateRateLimitSpinBox.value
    property alias cfg_showLabel: showLabelCheckbox.checked
    property int cfg_displayMode
    property alias cfg_swapOrder: swapOrderCheckbox.checked
    property bool cfg_swapOrderDefault: false

    Kirigami.FormLayout {
        id: root
        
        // spacing in the config menu - cleaner look
        Item { Kirigami.FormData.isSection: true }

        RowLayout {
            Kirigami.FormData.label: i18n("Show:")

            Controls.RadioButton {
                text: i18n("CPU Usage")
                checked: cfg_displayMode === 0
                onToggled: if (checked) cfg_displayMode = 0
            }

            Controls.RadioButton {
                text: i18n("GPU Usage")
                checked: cfg_displayMode === 1
                onToggled: if (checked) cfg_displayMode = 1
            }

            Controls.RadioButton {
                text: i18n("RAM Usage")
                checked: cfg_displayMode === 2
                onToggled: if (checked) cfg_displayMode = 2
            }
        }

        Item { Kirigami.FormData.isSection: true }

        Controls.CheckBox {
            id: showLabelCheckbox
            Kirigami.FormData.label: i18n("Prefix:")
            text: i18n("Show prefix (CPU:, GPU:, RAM:)")
        }

        Item { Kirigami.FormData.isSection: true }

        Controls.CheckBox {
            id: swapOrderCheckbox
            Kirigami.FormData.label: i18n("Swap Order:")
            text: i18n("Show animation on the right")
            checked: cfg_swapOrder
        }

        Item { Kirigami.FormData.isSection: true }

        RowLayout {
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Idle threshold")
            Controls.Slider {
                Layout.fillWidth: true
                id: idleSlider
                from: 0
                to: 100
                stepSize: 1
            }
            Controls.Label {
                id: label
                text: idleSlider.value + "%"
                Layout.minimumWidth: textMetrics.width
                Layout.minimumHeight: textMetrics.height
                horizontalAlignment: Text.AlignRight
            }
            TextMetrics {
                id: textMetrics
                text: "199%"
            }
        }

        Item { Kirigami.FormData.isSection: true }

        Controls.ComboBox {
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Displaying items")
            id: typeBox
            model: [i18n("Character and percentage"), i18n(
                    "Character only"), i18n("Percentage only")]
        }

        Item { Kirigami.FormData.isSection: true }

        Controls.SpinBox {
            id: updateRateLimitSpinBox
            Layout.fillWidth: true
            Kirigami.FormData.label: i18nd("KSysGuardSensorFaces",
                                           "Minimum Time Between Updates:")
            from: 0
            to: 60000
            stepSize: 500
            editable: true
            textFromValue: function (value, locale) {
                if (value <= 0) {
                    return i18nd("KSysGuardSensorFaces", "No Limit")
                } else {
                    var seconds = value / 1000
                    if (seconds == 1) {
                        return i18nd("KSysGuardSensorFaces", "1 second")
                    } else {
                        return i18nd("KSysGuardSensorFaces",
                                     "%1 seconds", seconds)
                    }
                }
            }
            valueFromText: function (value, locale) {
                var v = parseInt(value)
                if (isNaN(v)) {
                    return 0
                } else {
                    return v * 1000
                }
            }
        }
    }
}
