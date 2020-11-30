import 'package:crossplatform/common/labels.dart';
import 'package:crossplatform/widgets/home.dart';
import 'package:flutter/material.dart';

enum SelectedItem {
  placeholder,
  timeSetting,
  resourceUsage,
  resourceLoad,
  resourceLoadChart,
  resourceLoadHumanTable,
  resourceLoadEquipmentTable,
  orderDetail,
  orderDetailChart,
  orderDetailTable,
  scheduleDetail,
  scheduleDetailOrderPlanTable,
  scheduleDetailOrderProductionTable,
  scheduleDetailProductionTable,
  scheduleDetailProductionResourceTable,
}

final selectedMap = {
  SelectedItem.placeholder: [SelectedItem.placeholder],
  SelectedItem.timeSetting: [SelectedItem.timeSetting],
  SelectedItem.resourceUsage: [SelectedItem.resourceUsage],
  SelectedItem.resourceLoad: [
    SelectedItem.resourceLoad,
    SelectedItem.resourceLoadChart,
    SelectedItem.resourceLoadEquipmentTable,
    SelectedItem.resourceLoadHumanTable
  ],
  SelectedItem.orderDetail: [
    SelectedItem.orderDetail,
    SelectedItem.orderDetailChart,
    SelectedItem.orderDetailTable
  ],
  SelectedItem.scheduleDetail: {
    SelectedItem.scheduleDetail,
    SelectedItem.scheduleDetailOrderPlanTable,
    SelectedItem.scheduleDetailOrderProductionTable,
    SelectedItem.scheduleDetailProductionResourceTable,
    SelectedItem.scheduleDetailProductionTable
  }
};

class SideDrawer extends StatefulWidget {
  const SideDrawer();

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  dynamic selected = SelectedItem.placeholder;
  dynamic toggled = false;

  Icon _toggleArrow(SelectedItem currentItem) {
    if (selectedMap[currentItem].contains(selected) && toggled) {
      return Icon(Icons.keyboard_arrow_up);
    } else {
      return Icon(Icons.keyboard_arrow_down);
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomePageState state = HomePage.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Image.asset('assets/icons/flutter.png'),
              title: Text(
                drawerTitle,
                style: textTheme.headline6,
              ),
              subtitle: Text(
                drawerSubtitle,
                style: textTheme.bodyText2,
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('时间设置'),
              enabled: true,
              selected: SelectedItem.timeSetting == selected,
              onTap: () {
                state.handleClickEvent(SelectedItem.timeSetting);
                setState(() {
                  if (selected == SelectedItem.timeSetting) {
                    toggled = !toggled;
                  } else {
                    toggled = false;
                    selected = SelectedItem.timeSetting;
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.file_copy_sharp),
              title: Text('资源使用'),
              enabled: true,
              selected: SelectedItem.resourceUsage == selected,
              onTap: () {
                state.handleClickEvent(SelectedItem.resourceUsage);
                setState(() {
                  if (selected == SelectedItem.resourceUsage) {
                    toggled = !toggled;
                  } else {
                    toggled = false;
                    selected = SelectedItem.resourceUsage;
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('资源负载'),
              trailing: _toggleArrow(SelectedItem.resourceLoad),
              enabled: true,
              selected:
                  selectedMap[SelectedItem.resourceLoad].contains(selected),
              onTap: () {
                // state.handleClickEvent(SelectedItem.resourceLoad);
                setState(() {
                  if (selectedMap[SelectedItem.resourceLoad].contains(selected)) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = SelectedItem.resourceLoad;
                  }
                });
              },
            ),
            if (selectedMap[SelectedItem.resourceLoad].contains(selected) && toggled) ...[
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.data_usage),
                  title: Text('资源负载图'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.resourceLoadChart);
                    setState(() {
                      selected = SelectedItem.resourceLoadChart;
                    });
                  },
                ),
              ),
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.people),
                  title: Text('人力列表'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.resourceLoadHumanTable);
                    setState(() {
                      selected = SelectedItem.resourceLoadHumanTable;
                    });
                  },
                ),
              ),
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.devices_outlined),
                  title: Text('设备列表'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.resourceLoadEquipmentTable);
                    setState(() {
                      selected = SelectedItem.resourceLoadEquipmentTable;
                    });
                  },
                ),
              ),
            ],
            ListTile(
              leading: Icon(Icons.menu),
              title: Text('订单详情'),
              trailing: _toggleArrow(SelectedItem.orderDetail),
              enabled: true,
              selected:
                  selectedMap[SelectedItem.orderDetail].contains(selected),
              onTap: () {
                // state.handleClickEvent(SelectedItem.orderDetail);
                setState(() {
                  if (selectedMap[SelectedItem.orderDetail].contains(selected)) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = SelectedItem.orderDetail;
                  }
                });
              },
            ),
            if (selectedMap[SelectedItem.orderDetail].contains(selected) && toggled) ...[
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.pivot_table_chart),
                  title: Text('订单甘特图'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.orderDetailChart);
                    setState(() {
                      selected = SelectedItem.orderDetailChart;
                    });
                  },
                ),
              ),
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('订单列表'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.orderDetailTable);
                    setState(() {
                      selected = SelectedItem.orderDetailTable;
                    });
                  },
                ),
              ),
            ],
            ListTile(
              leading: Icon(Icons.grid_view),
              title: Text('排程详情'),
              trailing: _toggleArrow(SelectedItem.scheduleDetail),
              enabled: true,
              selected:
                  selectedMap[SelectedItem.scheduleDetail].contains(selected),
              onTap: () {
                // state.handleClickEvent(SelectedItem.scheduleDetail);
                setState(() {
                  if (selectedMap[SelectedItem.scheduleDetail].contains(selected)) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = SelectedItem.scheduleDetail;
                  }
                });
              },
            ),
            if (selectedMap[SelectedItem.scheduleDetail].contains(selected) && toggled) ...[
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.line_style),
                  title: Text('订单计划表'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.scheduleDetailOrderPlanTable);
                    setState(() {
                      selected = SelectedItem.scheduleDetailOrderPlanTable;
                    });
                  },
                ),
              ),
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.featured_play_list),
                  title: Text('订单-生产单关系表'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.scheduleDetailOrderProductionTable);
                    setState(() {
                      selected = SelectedItem.scheduleDetailOrderProductionTable;
                    });
                  },
                ),
              ),
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.featured_play_list_outlined),
                  title: Text('生产单列表'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.scheduleDetailProductionTable);
                    setState(() {
                      selected = SelectedItem.scheduleDetailProductionTable;
                    });
                  },
                ),
              ),
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.view_list_outlined),
                  title: Text('生产单-资源关系表'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(SelectedItem.scheduleDetailProductionResourceTable);
                    setState(() {
                      selected = SelectedItem.scheduleDetailProductionResourceTable;
                    });
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
