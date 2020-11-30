import 'package:crossplatform/widgets/gantt_chart/load_demo_page.dart';
import 'package:flutter/material.dart';

class ResourceLoadChart extends StatefulWidget {
  @override
  _ResourceLoadChartState createState() => _ResourceLoadChartState();
}

class _ResourceLoadChartState extends State<ResourceLoadChart> {
  @override
  Widget build(BuildContext context) {
    return LoadDemoPage();
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

