import 'package:crossplatform/common/labels.dart';
import 'package:crossplatform/routes/navigator.dart';
import 'package:crossplatform/widgets/drawer.dart';
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
  NavItem selected = NavItem.placeholder;
  DrawerNavigator navigator;

  @override
  void initState() {
    navigator = DrawerNavigator();
    super.initState();
  }

  void handleClickEvent(NavItem item) {
    setState(() {
      selected = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navTarget = navigator.of(selected);
    return _InheritedHomePage(
      child: Row(
        children: [
          SideDrawer(),
          const VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(
              appBar: AdaptiveAppBar(
                isDesktop: true,
                title: navTarget.title,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: navTarget.page,
                ),
              ),
            ),
          ),
        ],
      ),
      data: this,
    );
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
    this.title = "高级排程系统",
  }) : super(key: key);

  final bool isDesktop;
  final String title;

  @override
  Size get preferredSize => isDesktop
      ? const Size.fromHeight(appBarDesktopHeight)
      : const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: !isDesktop,
      title: Text('APSH - $title'),
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
