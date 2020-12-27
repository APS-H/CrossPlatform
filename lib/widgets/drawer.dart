import 'package:crossplatform/common/labels.dart';
import 'package:crossplatform/routes/navigator.dart';
import 'package:crossplatform/widgets/home.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer();

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  dynamic selected = NavItem.placeholder;
  dynamic toggled = false;

  Icon _toggleArrow(NavItem currentItem) {
    if (navigateMap[currentItem].contains(selected) && toggled) {
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
              enabled: true,
              subtitle: Text(
                drawerSubtitle,
                style: textTheme.bodyText2,
              ),
              onTap: () {
                state.handleClickEvent(NavItem.placeholder);
                setState(() {
                  if (selected == NavItem.placeholder) {
                    toggled = !toggled;
                  } else {
                    toggled = false;
                    selected = NavItem.placeholder;
                  }
                });
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.file_copy_sharp),
              title: Text('资源使用'),
              enabled: true,
              selected: NavItem.resourceUsage == selected,
              onTap: () {
                state.handleClickEvent(NavItem.resourceUsage);
                setState(() {
                  if (selected == NavItem.resourceUsage) {
                    toggled = !toggled;
                  } else {
                    toggled = false;
                    selected = NavItem.resourceUsage;
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('资源负载'),
              trailing: _toggleArrow(NavItem.resourceLoad),
              enabled: true,
              selected:
                  navigateMap[NavItem.resourceLoad].contains(selected),
              onTap: () {
                // state.handleClickEvent(SelectedItem.resourceLoad);
                setState(() {
                  if (navigateMap[NavItem.resourceLoad]
                      .contains(selected)) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = NavItem.resourceLoad;
                  }
                });
              },
            ),
            if (navigateMap[NavItem.resourceLoad].contains(selected) &&
                toggled) ...[
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.data_usage),
                  title: Text('资源负载图'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(NavItem.resourceLoadChart);
                    setState(() {
                      selected = NavItem.resourceLoadChart;
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
                    state.handleClickEvent(NavItem.resourceLoadHumanTable);
                    setState(() {
                      selected = NavItem.resourceLoadHumanTable;
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
                    state.handleClickEvent(
                        NavItem.resourceLoadEquipmentTable);
                    setState(() {
                      selected = NavItem.resourceLoadEquipmentTable;
                    });
                  },
                ),
              ),
            ],
            ListTile(
              leading: Icon(Icons.menu),
              title: Text('订单详情'),
              trailing: _toggleArrow(NavItem.orderDetail),
              enabled: true,
              selected:
                  navigateMap[NavItem.orderDetail].contains(selected),
              onTap: () {
                // state.handleClickEvent(SelectedItem.orderDetail);
                setState(() {
                  if (navigateMap[NavItem.orderDetail]
                      .contains(selected)) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = NavItem.orderDetail;
                  }
                });
              },
            ),
            if (navigateMap[NavItem.orderDetail].contains(selected) &&
                toggled) ...[
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.pivot_table_chart),
                  title: Text('订单甘特图'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(NavItem.orderDetailChart);
                    setState(() {
                      selected = NavItem.orderDetailChart;
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
                    state.handleClickEvent(NavItem.orderDetailTable);
                    setState(() {
                      selected = NavItem.orderDetailTable;
                    });
                  },
                ),
              ),
            ],
            ListTile(
              leading: Icon(Icons.grid_view),
              title: Text('排程详情'),
              trailing: _toggleArrow(NavItem.scheduleDetail),
              enabled: true,
              selected:
                  navigateMap[NavItem.scheduleDetail].contains(selected),
              onTap: () {
                // state.handleClickEvent(SelectedItem.scheduleDetail);
                setState(() {
                  if (navigateMap[NavItem.scheduleDetail]
                      .contains(selected)) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = NavItem.scheduleDetail;
                  }
                });
              },
            ),
            if (navigateMap[NavItem.scheduleDetail].contains(selected) &&
                toggled) ...[
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.line_style),
                  title: Text('订单计划表'),
                  enabled: true,
                  onTap: () {
                    state.handleClickEvent(
                        NavItem.scheduleDetailOrderPlanTable);
                    setState(() {
                      selected = NavItem.scheduleDetailOrderPlanTable;
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
                    state.handleClickEvent(
                        NavItem.scheduleDetailOrderProductionTable);
                    setState(() {
                      selected =
                          NavItem.scheduleDetailOrderProductionTable;
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
                    state.handleClickEvent(
                        NavItem.scheduleDetailProductionTable);
                    setState(() {
                      selected = NavItem.scheduleDetailProductionTable;
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
                    state.handleClickEvent(
                        NavItem.scheduleDetailProductionResourceTable);
                    setState(() {
                      selected =
                          NavItem.scheduleDetailProductionResourceTable;
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
