import 'package:crossplatform/common/labels.dart';
import 'package:flutter/material.dart';

enum selectedItem {
  placeholder,
  timeSetting,
  resourceUsage,
  resourceLoad,
  orderDetail,
  scheduleDetail
}

class SideDrawer extends StatefulWidget {
  const SideDrawer();

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  dynamic selected = selectedItem.placeholder;
  dynamic toggled = false;

  Icon _toggleArrow(selectedItem currentItem) {
    if (currentItem == selected && toggled) {
      return Icon(Icons.keyboard_arrow_up);
    } else {
      return Icon(Icons.keyboard_arrow_down);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              selected: selectedItem.timeSetting == selected,
              onTap: () {
                setState(() {
                  if (selected == selectedItem.timeSetting) {
                    toggled = !toggled;
                  } else {
                    toggled = false;
                    selected = selectedItem.timeSetting;
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.file_copy_sharp),
              title: Text('资源使用'),
              enabled: true,
              selected: selectedItem.resourceUsage == selected,
              onTap: () {
                setState(() {
                  if (selected == selectedItem.resourceUsage) {
                    toggled = !toggled;
                  } else {
                    toggled = false;
                    selected = selectedItem.resourceUsage;
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('资源负载'),
              trailing: _toggleArrow(selectedItem.resourceLoad),
              enabled: true,
              selected: selectedItem.resourceLoad == selected,
              onTap: () {
                setState(() {
                  if (selected == selectedItem.resourceLoad) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = selectedItem.resourceLoad;
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.menu),
              title: Text('订单详情'),
              trailing: _toggleArrow(selectedItem.orderDetail),
              enabled: true,
              selected: selectedItem.orderDetail == selected,
              onTap: () {
                setState(() {
                  if (selected == selectedItem.orderDetail) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = selectedItem.orderDetail;
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.grid_view),
              title: Text('排程详情'),
              trailing: _toggleArrow(selectedItem.scheduleDetail),
              enabled: true,
              selected: selectedItem.scheduleDetail == selected,
              onTap: () {
                setState(() {
                  if (selected == selectedItem.scheduleDetail) {
                    toggled = !toggled;
                  } else {
                    toggled = true;
                    selected = selectedItem.scheduleDetail;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
