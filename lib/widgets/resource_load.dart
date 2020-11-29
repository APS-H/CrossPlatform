import 'package:flutter/material.dart';

class ResourceLoad extends StatefulWidget {
  @override
  _ResourceLoadState createState() => _ResourceLoadState();
}

class _ResourceLoadState extends State<ResourceLoad> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Resource Load'));
  }
}

class ResourceLoadChart extends StatefulWidget {
  @override
  _ResourceLoadChartState createState() => _ResourceLoadChartState();
}

class _ResourceLoadChartState extends State<ResourceLoadChart> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Resource Load Chart'));
  }
}

class ResourceLoadHumanTable extends StatefulWidget {
  @override
  _ResourceLoadHumanTableState createState() => _ResourceLoadHumanTableState();
}

class _ResourceLoadHumanTableState extends State<ResourceLoadHumanTable> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Resource Load Human Table'));
  }
}

class ResourceLoadEquipmentTable extends StatefulWidget {
  @override
  _ResourceLoadEquipmentTableState createState() => _ResourceLoadEquipmentTableState();
}

class _ResourceLoadEquipmentTableState extends State<ResourceLoadEquipmentTable> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Resource Load Equipment Table'));
  }
}

