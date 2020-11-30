import 'package:crossplatform/widgets/gantt_chart/progress_demo_page.dart';
import 'package:flutter/material.dart';

class OrderDetailChart extends StatefulWidget {
  @override
  _OrderDetailChartState createState() => _OrderDetailChartState();
}

class _OrderDetailChartState extends State<OrderDetailChart> {
  @override
  Widget build(BuildContext context) {
    return ProgressDemoPage();
  }
}

class OrderDetailTable extends StatefulWidget {
  @override
  _OrderDetailTableState createState() => _OrderDetailTableState();
}

class _OrderDetailTableState extends State<OrderDetailTable> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Order Detail Table'));
  }
}


