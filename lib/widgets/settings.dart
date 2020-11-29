import 'package:crossplatform/layout/adaptive.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: TimeSetting(),
          ),
        ),
      );
    } else {
      return null;
    }
  }
}

class TimeSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('时间设置'));
  }
}
