import 'dart:math';

import 'package:crossplatform/common/helpers.dart';
import 'package:crossplatform/models/mock.dart';
import 'package:crossplatform/models/resource.dart';
import 'package:flutter/material.dart';

class ResourceUsageGantt extends StatefulWidget {
  @override
  _ResourceUsageGanttState createState() => _ResourceUsageGanttState();
}

class _ResourceUsageGanttState extends State<ResourceUsageGantt>
    with TickerProviderStateMixin {
  AnimationController animationController;

  //设置时间
  DateTime fromDate = DateTime(2018, 11, 7);
  DateTime toDate = DateTime(2018, 11, 12);

  List<ResourceUsage> _resourceUsageList;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: Duration(microseconds: 2000), vsync: this);
    animationController.forward();

    _resourceUsageList = resourceUsageList;
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text('GANTT CHART'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GanttChart(
              animationController: animationController,
              fromDate: fromDate,
              toDate: toDate,
              data: _resourceUsageList,
            ),
          ),
        ],
      ),
    );
  }
}

class GanttChart extends StatefulWidget {
  GanttChart({this.animationController, this.fromDate, this.toDate, this.data});

  final AnimationController animationController;
  final DateTime fromDate;
  final DateTime toDate;
  final List<ResourceUsage> data;

  @override
  _GanttChartState createState() => _GanttChartState();
}

class _GanttChartState extends State<GanttChart> {
  final _ganttHeaderBarHeight = 40.0;

  int selectedProduct;
  int viewRange;
  int viewRangeToFitScreen = 6;
  Animation<double> width;

  void initState() {
    viewRange = widget.toDate.difference(widget.fromDate).inHours;
    selectedProduct = -1;
    super.initState();
  }

  Color randomColorGenerator() {
    var r = new Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 0.75);
  }

  int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
    if (projectStartedAt.compareTo(widget.fromDate) <= 0) {
      return 0;
    } else
      return projectStartedAt.difference(widget.fromDate).inHours;
  }

  int calculateRemainingWidth(
      DateTime projectStartedAt, DateTime projectEndedAt) {
    int projectLength = projectEndedAt.difference(projectStartedAt).inHours;
    if (projectStartedAt.compareTo(widget.fromDate) >= 0 &&
        projectStartedAt.compareTo(widget.toDate) <= 0) {
      if (projectLength <= viewRange)
        return projectLength;
      else
        return viewRange - projectStartedAt.difference(widget.fromDate).inHours;
    } else if (projectStartedAt.isBefore(widget.fromDate) &&
        projectEndedAt.isBefore(widget.fromDate)) {
      return 0;
    } else if (projectStartedAt.isBefore(widget.fromDate) &&
        projectEndedAt.isBefore(widget.toDate)) {
      return projectLength -
          projectStartedAt.difference(widget.fromDate).inHours;
    } else if (projectStartedAt.isBefore(widget.fromDate) &&
        projectEndedAt.isAfter(widget.toDate)) {
      return viewRange;
    }
    return 0;
  }

  List<Widget> buildChartBars(
      List<UsedTime> usedTimeList, double chartViewWidth, Color color) {
    List<Widget> chartBars = new List();

    for (int i = 0; i < usedTimeList.length; i++) {
      var remainingWidth = calculateRemainingWidth(
          usedTimeList[i].startTime, usedTimeList[i].endTime);
      if (remainingWidth > 0) {
        chartBars.add(GestureDetector(
            onTap: () {
              this.setState(() {
                selectedProduct = selectedProduct == usedTimeList[i].product
                    ? -1
                    : usedTimeList[i].product;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: color.withAlpha(100),
                  borderRadius: BorderRadius.circular(10.0)),
              height: 30.0,
              width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
              margin: EdgeInsets.only(
                  left:
                      calculateDistanceToLeftBorder(usedTimeList[i].startTime) *
                          chartViewWidth /
                          viewRangeToFitScreen,
                  top: i == 0 ? 4.0 : 2.0,
                  bottom: i == usedTimeList.length - 1 ? 4.0 : 2.0),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '产品${usedTimeList[i].product}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            )));
      }
    }

    return chartBars;
  }

  //渲染头部时间信息
  Widget buildHeader(double chartViewWidth, Color color) {
    List<Widget> headerItems = new List();
    DateTime tempDate = widget.fromDate;
    headerItems.add(Container(
      width: chartViewWidth / viewRangeToFitScreen,
      child: new Text(
        'NAME',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    ));

    for (int i = 0; i < viewRange; i++) {
      headerItems.add(Container(
        width: chartViewWidth / viewRangeToFitScreen,
        child: Text(
          dateTimeString(tempDate),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ));
      tempDate = tempDate.add(Duration(hours: 1));
    }

    return Container(
      height: _ganttHeaderBarHeight,
      color: color.withAlpha(100),
      child: Row(children: headerItems),
    );
  }

  //渲染时间段边界
  Widget buildGrid(double chartViewWidth) {
    List<Widget> gridColumns = new List();

    for (int i = 0; i <= viewRange; i++) {
      gridColumns.add(Container(
        decoration: BoxDecoration(
            border: Border(
                right:
                    BorderSide(color: Colors.grey.withAlpha(100), width: 1.0))),
        width: chartViewWidth / viewRangeToFitScreen,
        //height: 300.0,
      ));
    }

    return Row(
      children: gridColumns,
    );
  }

  Widget buildChartForEachResource(
      ResourceUsage resource, double chartViewWidth, BuildContext context) {
    Color color = randomColorGenerator();
    List<UsedTime> usedTimeList = selectedProduct == -1
        ? resource.usedTimeList
        : [
            ...resource.usedTimeList
                .where((element) => element.product == selectedProduct)
          ];
    var chartBars = buildChartBars(usedTimeList, chartViewWidth, color);
    return Container(
      height: (chartBars.length == 0 ? 1 : chartBars.length) * 34.0 +
          _ganttHeaderBarHeight +
          4.0,
      child: ListView(
        physics: new ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Stack(fit: StackFit.loose, children: [
            buildGrid(chartViewWidth),
            buildHeader(chartViewWidth, color),
            Container(
              margin: EdgeInsets.only(top: _ganttHeaderBarHeight),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: chartViewWidth / viewRangeToFitScreen,
                        height: (chartBars.length == 0 ? 1 : chartBars.length) *
                                34.0 +
                            4.0,
                        color: color.withAlpha(100),
                        child: Center(
                          child: RotatedBox(
                            quarterTurns:
                                chartBars.length * 34.0 + 4.0 > 50 ? 0 : 0,
                            child: Text(
                              resource.resourceID,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: chartBars,
                      ),
                    ],
                  ),
                  // TODO :
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  List<Widget> buildChartContent(double chartViewWidth, BuildContext context) {
    return [
      ...widget.data
          .where((usage) => selectedProduct == -1
              ? true
              : usage.usedTimeList.any((ut) => ut.product == selectedProduct))
          .map((e) => buildChartForEachResource(e, chartViewWidth, context))
    ];
  }

  @override
  Widget build(BuildContext context) {
    var chartViewWidth = MediaQuery.of(context).size.width;
    var screenOrientation = MediaQuery.of(context).orientation;

    screenOrientation == Orientation.landscape
        ? viewRangeToFitScreen = 12
        : viewRangeToFitScreen = 6;

    return Container(
      child: MediaQuery.removePadding(
        child: ListView(children: buildChartContent(chartViewWidth, context)),
        removeTop: true,
        context: context,
      ),
    );
  }
}
