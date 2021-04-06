import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import Qt.labs.qmlmodels 1.0

Window {
    width: 919
    height: 475
    visible: true

    Rectangle {
        z: 10
        id: tableView
        width: 919
        height: 475
        anchors {
            top: parent.top
            topMargin: 88
            left: parent.left
            leftMargin: 47
        }

        Item {
            id: control
            implicitHeight: parent.height
            implicitWidth: parent.width

            //表头行高
            property int headerHeight: 48
            //行高
            property int rowHeight: 48
            property int tableLeft: 100
            //滚动条
            property color scrollBarColor: "#E5E5E5"
            property int scrollBarWidth: 7
            //列宽
            property variant columnWidthArr: [(control.width - control.tableLeft)
                / 2, (control.width - control.tableLeft) / 2]

            property var horHeader: ["名称", "格式"]
            property int selected: -1
            property var datas: [{
                    "checked": false,
                    "id": 1,
                    "name": "汽车曲轴分拣项目1",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 2,
                    "name": "汽车曲轴分拣项目2",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 3,
                    "name": "汽车曲轴分拣项目3",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 4,
                    "name": "汽车曲轴分拣项目4",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 5,
                    "name": "汽车曲轴分拣项目5",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 6,
                    "name": "汽车曲轴分拣项目6",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 7,
                    "name": "汽车曲轴分拣项目7",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 8,
                    "name": "汽车曲轴分拣项目8",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 9,
                    "name": "汽车曲轴分拣项目9",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 10,
                    "name": "汽车曲轴分拣项目10",
                    "type": "mission"
                }, {
                    "checked": false,
                    "id": 11,
                    "name": "汽车曲轴分拣项目11",
                    "type": "mission"
                }]

            //数据展示
            TableView {
                id: table
                anchors {
                    fill: parent
                    topMargin: control.rowHeight
                    leftMargin: control.tableLeft
                }

                clip: true
                boundsBehavior: Flickable.StopAtBounds
                columnSpacing: 0
                rowSpacing: 0

                //内容行高
                rowHeightProvider: function (row) {
                    return control.headerHeight
                }
                //内容列的列宽
                columnWidthProvider: function (column) {
                    return control.columnWidthArr[column]
                }

                ScrollBar.vertical: ScrollBar {
                    id: scroll_vertical
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    contentItem: Rectangle {
                        visible: (scroll_vertical.size < 1.0)
                        implicitWidth: control.scrollBarWidth
                        color: control.scrollBarColor
                    }
                }

                ScrollBar.horizontal: ScrollBar {
                    id: scroll_horizontal
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: -control.tableLeft

                    contentItem: Rectangle {
                        visible: (scroll_horizontal.size < 1.0)
                        implicitHeight: control.scrollBarWidth
                        color: control.scrollBarColor
                    }
                }

                model: TableModel {

                    TableModelColumn {
                        display: "name"
                    }
                    TableModelColumn {

                        display: "type"
                    }

                    rows: control.datas
                }

                delegate: Rectangle {
                    color: table.model.rows[row].checked ? "#EAF1FF" : "white"

                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                        text: display
                        font.pixelSize: 15
                        color: "#707070"
                    }
                    Rectangle {
                        color: "#E5E5E5"
                        width: parent.width
                        height: 1
                        anchors {
                            bottom: parent.bottom
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {

                            control.datas[row].checked = !control.datas[row].checked
                            table.model.rows = control.datas

                            if (checkBox.checked
                                    && !control.datas[row].checked) {
                                checkBox.checked = false
                            }
                        }
                    }
                }
            }

            //全选按钮
            Rectangle {
                width: control.tableLeft
                height: control.rowHeight - 1
                color: "#F8F8F8"
                anchors {
                    top: parent.top
                    left: parent.left
                }

                CheckBoxButton {
                    checked: false
                    id: checkBox
                    state: checked ? "checked" : "noCheck"
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 20
                    }
                    onClicked: {
                        checkBox.checked = !checkBox.checked
                        let count = control.datas.length
                        if (!count) {
                            return false
                        }

                        for (var i = 0; i < count; i++) {
                            if (checkBox.checked) {
                                control.datas[i].checked = true
                            } else {
                                control.datas[i].checked = false
                            }
                        }
                        table.model.rows = control.datas

                    }
                }
                Text {
                    anchors {
                        verticalCenter: checkBox.verticalCenter
                        left: checkBox.right
                        leftMargin: 20
                    }

                    text: checkBox.checked ? "取消" : "全选"
                    font.pixelSize: 18
                    color: "#707070"
                }
                Rectangle {
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom
                    color: "#E5E5E5"
                }
                Rectangle {
                    height: 1
                    width: parent.width
                    anchors.top: parent.top
                    color: "#E5E5E5"
                }
            }

            //表头
            Item {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: control.tableLeft
                }
                height: control.rowHeight
                z: 2

                Row {
                    anchors.fill: parent
                    leftPadding: -table.contentX
                    clip: true
                    spacing: 0

                    Repeater {
                        model: table.columns > 0 ? table.columns : 0

                        Rectangle {

                            width: table.columnWidthProvider(
                                       index) + table.columnSpacing
                            height: control.rowHeight - 1
                            color: "#F8F8F8"

                            Text {
                                anchors.centerIn: parent
                                text: control.horHeader[index]
                                font.pixelSize: 18
                                color: "#707070"
                            }
                            Rectangle {
                                height: 1
                                width: parent.width
                                anchors.bottom: parent.bottom
                                color: "#E5E5E5"
                            }
                            Rectangle {
                                height: 1
                                width: parent.width
                                anchors.top: parent.top
                                color: "#E5E5E5"
                            }
                        }
                    }
                }
            }

            //每一行前面加多选框
            Column {

                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    topMargin: control.headerHeight
                }
                topPadding: -table.contentY
                z: 2
                clip: true
                spacing: 1
                Repeater {
                    model: table.rows > 0 ? table.rows : 0
                    Rectangle {
                        width: control.tableLeft
                        height: table.rowHeightProvider(index)
                        color: "white"

                        CheckBoxButton {//自定义多选框组件
                            state: table.model.rows[index].checked ? "checked" : "noCheck"
                            anchors.centerIn: parent

                            onClicked: {
                                control.datas[index].checked = !control.datas[index].checked
                                table.model.rows = control.datas

                                if (checkBox.checked
                                        && !control.datas[index].checked) {
                                    checkBox.checked = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
