import 'package:crossplatform/common/labels.dart';
import 'package:crossplatform/layout/adaptive.dart';
import 'package:crossplatform/widgets/drawer.dart';
import 'package:crossplatform/widgets/order_detail.dart';
import 'package:crossplatform/widgets/resource_load.dart';
import 'package:crossplatform/widgets/resource_usage.dart';
import 'package:crossplatform/widgets/schedule_detail.dart';
import 'package:crossplatform/widgets/settings.dart';
import 'package:flutter/material.dart';

const appBarDesktopHeight = 56.0;

class HomePage extends StatefulWidget {
  const HomePage();

  static HomePageState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedHomePage>()
        .data;
  }

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  SelectedItem selected = SelectedItem.placeholder;

  void handleClickEvent(SelectedItem item) {
    setState(() {
      selected = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = isDisplayDesktop(context);
    dynamic body = Text('data');
    switch (selected) {
      case SelectedItem.placeholder:
        body = Text('');
        break;
      case SelectedItem.timeSetting:
        body = SettingPage();
        break;
      case SelectedItem.resourceUsage:
        body = ResourceUsage();
        break;
      case SelectedItem.resourceLoadChart:
        body = ResourceLoadChart();
        break;
      case SelectedItem.resourceLoadHumanTable:
        body = ResourceLoadHumanTable();
        break;
      case SelectedItem.resourceLoadEquipmentTable:
        body = ResourceLoadEquipmentTable();
        break;
      case SelectedItem.orderDetailChart:
        body = OrderDetailChart();
        break;
      case SelectedItem.orderDetailTable:
        body = OrderDetailTable();
        break;
      case SelectedItem.scheduleDetailOrderPlanTable:
        body = ScheduleDetailOrderPlanTable();
        break;
      case SelectedItem.scheduleDetailOrderProductionTable:
        body = ScheduleDetailOrderProductionTable();
        break;
      case SelectedItem.scheduleDetailProductionTable:
        body = ScheduleDetailProductionTable();
        break;
      case SelectedItem.scheduleDetailProductionResourceTable:
        body = ScheduleDetailProductionResourceTable();
        break;
      case SelectedItem.resourceLoad:
      case SelectedItem.orderDetail:
      case SelectedItem.scheduleDetail:
        body = null;
        break;
    }

    if (isDesktop) {
      return _InheritedHomePage(
        child: Row(
          children: [
            SideDrawer(),
            const VerticalDivider(width: 1),
            Expanded(
              child: Scaffold(
                appBar: const AdaptiveAppBar(
                  isDesktop: true,
                ),
                body: SafeArea(
                  child: Padding(
                    padding: isDesktop
                        ? const EdgeInsets.all(0)
                        : const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                    child: body,
                  ),
                ),
              ),
            ),
          ],
        ),
        data: this,
      );
    } else {
      return Scaffold(
        appBar: const AdaptiveAppBar(),
        body: body,
        // drawer: SideDrawer(),
      );
    }
  }
}

class _InheritedHomePage extends InheritedWidget {
  _InheritedHomePage({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final HomePageState data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({
    Key key,
    this.isDesktop = false,
  }) : super(key: key);

  final bool isDesktop;

  @override
  Size get preferredSize => isDesktop
      ? const Size.fromHeight(appBarDesktopHeight)
      : const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: !isDesktop,
      title: Text('APSH - 时间设置'),
      actions: [
        if (!isDesktop)
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: settingsButtonText,
            onPressed: () {},
          ),
      ],
    );
  }
}
