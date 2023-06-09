/*
    SPDX-FileCopyrightText: 2017 Marco Martin <mart@kde.org>
    SPDX-FileCopyrightText: 2017 The Qt Company Ltd.

    SPDX-License-Identifier: LGPL-3.0-only OR GPL-2.0-or-later
*/

import QtQuick 2.6
import QtQuick.Templates 2.15 as T
import org.kde.qqc2desktopstyle.private 1.0 as StylePrivate
import org.kde.kirigami 2.4 as Kirigami

T.Button {
    id: controlRoot

    Kirigami.Theme.colorSet: Kirigami.Theme.Button
    Kirigami.Theme.inherit: false

    implicitWidth: Math.max((text && display !== T.AbstractButton.IconOnly ?
        implicitBackgroundWidth : implicitHeight) + leftInset + rightInset,
        implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    hoverEnabled: Qt.styleHints.useHoverEffects

    Kirigami.MnemonicData.enabled: controlRoot.enabled && controlRoot.visible
    Kirigami.MnemonicData.controlType: Kirigami.MnemonicData.ActionElement
    Kirigami.MnemonicData.label: controlRoot.display !== T.AbstractButton.IconOnly ? controlRoot.text : ""
    Shortcut {
        //in case of explicit & the button manages it by itself
        enabled: !(RegExp(/\&[^\&]/).test(controlRoot.text))
        sequence: controlRoot.Kirigami.MnemonicData.sequence
        onActivated: controlRoot.clicked()
    }
    background: StylePrivate.StyleItem {
        control: controlRoot
        elementType: "button"
        sunken: controlRoot.down
        on: controlRoot.checkable && controlRoot.checked
        flat: controlRoot.flat
        hover: controlRoot.hovered
        text: controlRoot.Kirigami.MnemonicData.mnemonicLabel
        hasFocus: controlRoot.activeFocus || controlRoot.highlighted
        activeControl: controlRoot.Accessible.defaultButton ? "default" : "f"
        properties: {
            "icon": controlRoot.icon && controlRoot.display !== T.AbstractButton.TextOnly ? (controlRoot.icon.name || controlRoot.icon.source) : "",
            "iconColor": controlRoot.icon && controlRoot.icon.color.a > 0? controlRoot.icon.color : Kirigami.Theme.textColor,
            "iconWidth": controlRoot.icon && controlRoot.icon.width ? controlRoot.icon.width : 0,
            "iconHeight": controlRoot.icon && controlRoot.icon.height ? controlRoot.icon.height : 0,
        }
    }
}
