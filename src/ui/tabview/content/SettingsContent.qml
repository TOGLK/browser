/*
 * This file is part of Liri Browser
 *
 * Copyright (C) 2016 Tim Süberkrüb <dev@timsueberkrueb.io>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
*/

import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import Fluid.Core 1.0
import Fluid.Controls 1.0 as FluidControls
import core 1.0
import "../.."

TabContent {
    id: content

    function timeString(time) {
        return Qt.formatTime(time, "HH:mm");
    }

    Flickable {
        anchors {
            fill: parent
            margins: 2 * FluidControls.Units.smallSpacing
        }

        ScrollBar.vertical: ScrollBar {}

        contentHeight: contentItem.childrenRect.height
        interactive: contentHeight > height

        Item {
            id: contentItem
            width: parent.width
            height: childrenRect.height

            Column {
                width: parent.width
                spacing: 2 * FluidControls.Units.smallSpacing

                FluidControls.HeadlineLabel {
                    text: qsTr("Settings")
                }

                FluidControls.TitleLabel {
                    text: qsTr("Startup")
                }

                Column {
                    Label { text: qsTr("Start new window with") }
                    RadioButton {
                        text: qsTr("New page")
                        checked: Settings.startConfig.startupType === StartConfig.StartFromNewPage
                        onClicked: {
                            if (Settings.startConfig.startupType !== StartConfig.StartFromNewPage) {
                                Settings.startConfig.startupType = StartConfig.StartFromNewPage;
                                Settings.dirty = true;
                            }
                        }
                    }
                    RadioButton {
                        text: qsTr("Continue where you left off")
                        checked: Settings.startConfig.startupType === StartConfig.StartFromPreviouslyOpenedTabs
                        onClicked: {
                            if (Settings.startConfig.startupType !== StartConfig.StartFromPreviouslyOpenedTabs) {
                                Settings.startConfig.startupType = StartConfig.StartFromPreviouslyOpenedTabs;
                                Settings.dirty = true;
                            }
                        }
                    }
                }

                FluidControls.TitleLabel {
                    text: qsTr("New page url")
                    font.pixelSize: 16
                }

                GridLayout {
                    columns: 2
                    columnSpacing: 2 * FluidControls.Units.smallSpacing

                    Label {
                        text: qsTr("Primary")
                    }

                    TextField {
                        Layout.minimumWidth: 256
                        text: Settings.startConfig.primaryStartUrl
                        selectByMouse: true
                        onEditingFinished: {
                            if (Settings.startConfig.primaryStartUrl != text) {
                                Settings.startConfig.primaryStartUrl = text;
                                Settings.dirty = true;
                            }
                        }
                    }

                    Label {
                        text: qsTr("Dark theme")
                    }

                    TextField {
                        Layout.minimumWidth: 256
                        text: Settings.startConfig.darkStartUrl
                        selectByMouse: true
                        onEditingFinished: {
                            if (Settings.startConfig.darkStartUrl != text) {
                                Settings.startConfig.darkStartUrl = text;
                                Settings.dirty = true;
                            }
                        }
                    }

                    Label {
                        text: qsTr("Incognito")
                    }

                    TextField {
                        Layout.minimumWidth: 256
                        text: Settings.startConfig.incognitoStartUrl
                        selectByMouse: true
                        onEditingFinished: {
                            if (Settings.startConfig.incognitoStartUrl != text) {
                                Settings.startConfig.incognitoStartUrl = text;
                                Settings.dirty = true;
                            }
                        }
                    }
                }

                FluidControls.TitleLabel {
                    text: qsTr("Search")
                }

                ColumnLayout {
                    RadioButton {
                        text: "DuckDuckGo"
                        checked: Settings.searchConfig.searchEngine == SearchConfig.DuckDuckGo
                        onClicked: {
                            if (Settings.searchConfig.searchEngine != SearchConfig.DuckDuckGo) {
                                Settings.searchConfig.searchEngine = SearchConfig.DuckDuckGo;
                                Settings.dirty = true;
                            }
                        }
                    }

                    RadioButton {
                        text: "Google"
                        checked: Settings.searchConfig.searchEngine == SearchConfig.Google
                        onClicked: {
                            if (Settings.searchConfig.searchEngine != SearchConfig.Google) {
                                Settings.searchConfig.searchEngine = SearchConfig.Google;
                                Settings.dirty = true;
                            }
                        }
                    }

                    RadioButton {
                        text: "Bing"
                        checked: Settings.searchConfig.searchEngine == SearchConfig.Bing
                        onClicked: {
                            if (Settings.searchConfig.searchEngine != SearchConfig.Bing) {
                                Settings.searchConfig.searchEngine = SearchConfig.Bing;
                                Settings.dirty = true;
                            }
                        }
                    }

                    RadioButton {
                        text: "Yahoo"
                        checked: Settings.searchConfig.searchEngine == SearchConfig.Yahoo
                        onClicked: {
                            if (Settings.searchConfig.searchEngine != SearchConfig.Yahoo) {
                                Settings.searchConfig.searchEngine = SearchConfig.Yahoo;
                                Settings.dirty = true;
                            }
                        }
                    }

                    RadioButton {
                        text: "StartPage"
                        checked: Settings.searchConfig.searchEngine == SearchConfig.StartPage
                        onClicked: {
                            if (Settings.searchConfig.searchEngine != SearchConfig.StartPage) {
                                Settings.searchConfig.searchEngine = SearchConfig.StartPage;
                                Settings.dirty = true;
                            }
                        }
                    }

                    ColumnLayout {
                        RowLayout {
                            RadioButton {
                                text: qsTr("Custom")
                                checked: Settings.searchConfig.searchEngine == SearchConfig.Custom
                                onClicked: {
                                    if (Settings.searchConfig.searchEngine != SearchConfig.Custom) {
                                        Settings.searchConfig.searchEngine = SearchConfig.Custom;
                                        Settings.dirty = true;
                                    }
                                }
                            }

                            TextField {
                                Layout.minimumWidth: 256
                                enabled: Settings.searchConfig.searchEngine == SearchConfig.Custom
                                text: Settings.searchConfig.customSearchUrl
                                selectByMouse: true
                                placeholderText: qsTr("e.g https://example.com/?q=")
                                onEditingFinished: {
                                    if (Settings.searchConfig.customSearchUrl != text) {
                                        Settings.searchConfig.customSearchUrl = text;
                                        Settings.dirty = true;
                                    }
                                }
                            }
                        }
                    }
                }

                FluidControls.TitleLabel {
                    text: qsTr("Theme")
                }

                ButtonGroup {
                    buttons: [
                        radioButtonLightTheme,
                        radioButtonAlwaysDark,
                        radioButtonDarkBetween
                    ]
                }

                ColumnLayout {
                    CheckBox {
                        text: qsTr("Adapt to website theme colors")
                        checked: Settings.themeConfig.themeColorEnabled
                        onClicked: {
                            if (Settings.themeConfig.themeColorEnabled !== checked) {
                                Settings.themeConfig.themeColorEnabled = checked;
                                Settings.dirty = true;
                            }
                        }
                    }

                    RadioButton {
                        id: radioButtonLightTheme
                        text: qsTr("Light theme")
                        checked: !Settings.themeConfig.darkThemeEnabled
                        onClicked: {
                            if (Settings.themeConfig.darkThemeEnabled === checked) {
                                Settings.themeConfig.darkThemeEnabled = !checked;
                                Settings.dirty = true;
                            }
                        }
                    }

                    RadioButton {
                        id: radioButtonAlwaysDark
                        text: qsTr("Dark theme (always on)")
                        checked: Settings.themeConfig.darkThemeEnabled
                                 && (timeString(Settings.themeConfig.darkThemeStartTime)
                                 === timeString(Settings.themeConfig.darkThemeEndTime))
                        onClicked: {
                            Settings.themeConfig.darkThemeEnabled = true;
                            Settings.themeConfig.setDarkThemeStartTime("00:00", "HH:mm");
                            Settings.themeConfig.setDarkThemeEndTime("00:00", "HH:mm");
                            Settings.dirty = true;
                        }
                    }

                    RowLayout {
                        RadioButton {
                            id: radioButtonDarkBetween
                            text: qsTr("Dark between")
                            checked: Settings.themeConfig.darkThemeEnabled
                                     && (timeString(Settings.themeConfig.darkThemeStartTime)
                                         !== timeString(Settings.themeConfig.darkThemeEndTime))
                            onClicked: {
                                Settings.themeConfig.darkThemeEnabled = true;
                                if (inputStartTime.text == inputEndTime.text) {
                                    inputStartTime.text = "21:00";
                                    inputEndTime.text = "07:00"
                                }
                                Settings.themeConfig.setDarkThemeStartTime(inputStartTime.text, "HH:mm");
                                Settings.themeConfig.setDarkThemeEndTime(inputEndTime.text, "HH:mm");
                                DarkThemeTimer.update();
                                Settings.dirty = true;
                            }
                        }

                        TextField {
                            id: inputStartTime
                            Layout.maximumWidth: 56
                            text: Qt.formatTime(Settings.themeConfig.darkThemeStartTime, "HH:mm")
                            selectByMouse: true
                            enabled: radioButtonDarkBetween.checked
                            maximumLength: 5
                            validator: RegExpValidator {
                                regExp: /^([0-1][0-9]|2[0-3]):([0-5][0-9])/
                            }
                            onEditingFinished: {
                                Settings.themeConfig.setDarkThemeStartTime(text, "HH:mm");
                                DarkThemeTimer.update();
                                Settings.dirty = true;
                            }

                        }

                        Label {
                            text: qsTr("and")
                        }

                        TextField {
                            id: inputEndTime
                            Layout.maximumWidth: 56
                            text: Qt.formatTime(Settings.themeConfig.darkThemeEndTime, "HH:mm")
                            selectByMouse: true
                            enabled: radioButtonDarkBetween.checked
                            maximumLength: 5
                            validator: RegExpValidator {
                                regExp: /^([0-1][0-9]|2[0-3]):([0-5][0-9])/
                            }
                            onEditingFinished: {
                                Settings.themeConfig.setDarkThemeEndTime(text, "HH:mm");
                                DarkThemeTimer.update();
                                Settings.dirty = true;
                            }
                        }
                    }
                }

                FluidControls.TitleLabel {
                    text: qsTr("Privacy")
                }

                Column {
                    CheckBox {
                        text: qsTr("Save cookies")
                        checked: Settings.startConfig.persistentCookies
                        onCheckedChanged: {
                            if (checked === Settings.startConfig.persistentCookies) {
                                return;
                            }

                            Settings.startConfig.persistentCookies = checked;
                            Settings.dirty = true;
                        }
                    }
                }
            }
        }
    }

    Binding {
        target: content.tab
        property: "canReload"
        value: false
    }

    Binding {
        target: content.tab
        property: "iconUrl"
        value: FluidControls.Utils.iconUrl("action/settings")
    }

    Binding {
        target: content.tab
        property: "adaptIconColor"
        value: true
    }

    Binding {
        target: content.tab
        property: "canGoBack"
        value: false
    }

    Binding {
        target: content.tab
        property: "canGoForward"
        value: false
    }

    Binding {
        target: content.tab
        property: "loading"
        value: false
    }

    Binding {
        target: content.tab
        property: "loadProgress"
        value: 100
    }

    Binding {
        target: content.tab
        property: "url"
        value: "liri://settings"
    }

    Binding {
        target: content.tab
        property: "title"
        value: "Settings"
    }

    Binding {
        target: content.tab
        property: "hasThemeColor"
        value: false
    }
}
