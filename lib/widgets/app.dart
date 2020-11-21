import '../common/options.dart';
import '../routes/routes.dart';
import '../themes/apsh_theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApshApp extends StatelessWidget {
  const ApshApp({
    Key key,
    this.initialRoute,
  }) : super(key: key);

  final String initialRoute;

  @override
  Widget build(BuildContext context) => ModelBinding(
        initialModel: AppOptions(
          themeMode: ThemeMode.system,
          platform: defaultTargetPlatform,
        ),
        child: Builder(
          builder: (context) => MaterialApp(
            restorationScopeId: 'rootApsh',
            title: 'Advanced Planning and Scheduling by H',
            themeMode: AppOptions.of(context).themeMode,
            theme: ApshThemeData.lightThemeData.copyWith(
              platform: AppOptions.of(context).platform,
            ),
            darkTheme: ApshThemeData.darkThemeData.copyWith(
              platform: AppOptions.of(context).platform,
            ),
            initialRoute: initialRoute,
            onGenerateRoute: RouteConfiguration.onGenerateRoute,
          ),
        ),
      );
}
