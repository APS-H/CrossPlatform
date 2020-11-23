import 'package:crossplatform/common/labels.dart';
import 'package:crossplatform/layout/adaptive.dart';
import 'package:flutter/material.dart';

const appBarDesktopHeight = 128.0;

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = isDisplayDesktop(context);
    final body = SafeArea(
      child: Padding(
        padding: isDesktop
            ? const EdgeInsets.symmetric(horizontal: 72, vertical: 48)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'starterAppGenericHeadline',
              style: textTheme.headline3.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'starterAppGenericSubtitle',
              style: textTheme.subtitle1,
            ),
            const SizedBox(height: 48),
            Text(
              'starterAppGenericBody',
              style: textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return Row(
        children: [
          ListDrawer(),
          const VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(
              appBar: const AdaptiveAppBar(
                isDesktop: true,
              ),
              body: body,
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: const AdaptiveAppBar(),
        body: body,
        drawer: ListDrawer(),
      );
    }
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
      title: isDesktop ? null : Text('starterAppGenericTitle'),
      bottom: isDesktop
          ? PreferredSize(
              preferredSize: const Size.fromHeight(26),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                margin: const EdgeInsetsDirectional.fromSTEB(72, 0, 0, 22),
                child: Text(
                  'starterAppGenericTitle',
                  style: themeData.textTheme.headline6.copyWith(
                    color: themeData.colorScheme.onPrimary,
                  ),
                ),
              ),
            )
          : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: settingsButtonText,
          onPressed: () {},
        ),
      ],
    );
  }
}

class ListDrawer extends StatefulWidget {
  @override
  _ListDrawerState createState() => _ListDrawerState();
}

class _ListDrawerState extends State<ListDrawer> {
  static final numItems = 9;

  int selectedItem = 0;

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
            ...Iterable<int>.generate(numItems).toList().map((i) {
              return ListTile(
                enabled: true,
                selected: i == selectedItem,
                leading: const Icon(Icons.favorite),
                title: Text(
                  'starterAppDrawerItem(i + 1)',
                ),
                onTap: () {
                  setState(() {
                    selectedItem = i;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
