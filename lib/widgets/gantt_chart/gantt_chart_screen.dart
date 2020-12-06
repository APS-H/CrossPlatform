import 'package:crossplatform/common/helpers.dart';
import 'package:crossplatform/models/mock.dart';
import 'package:crossplatform/models/product.dart';
import 'package:crossplatform/models/resource.dart';
import 'package:flutter/material.dart';
import 'product_gantt_page.dart';
import 'dart:math';

class GranttChartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GranttChartScreenState();
  }
}

class GranttChartScreenState extends State<GranttChartScreen>
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

class GanttChart extends StatelessWidget {
  final AnimationController animationController;
  final DateTime fromDate;
  final DateTime toDate;
  final List<ResourceUsage> data;

  final _ganttHeaderBarHeight = 40.0;

  int viewRange;
  int viewRangeToFitScreen = 6;
  Animation<double> width;

  GanttChart(
      {this.animationController, this.fromDate, this.toDate, this.data}) {
    viewRange = toDate.difference(fromDate).inHours;
  }

  Color randomColorGenerator() {
    var r = new Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 0.75);
  }

  int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
    if (projectStartedAt.compareTo(fromDate) <= 0) {
      return 0;
    } else
      return projectStartedAt.difference(fromDate).inHours;
  }

  int calculateRemainingWidth(
      DateTime projectStartedAt, DateTime projectEndedAt) {
    int projectLength = projectEndedAt.difference(projectStartedAt).inHours;
    if (projectStartedAt.compareTo(fromDate) >= 0 &&
        projectStartedAt.compareTo(toDate) <= 0) {
      if (projectLength <= viewRange)
        return projectLength;
      else
        return viewRange - projectStartedAt.difference(fromDate).inHours;
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isBefore(fromDate)) {
      return 0;
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isBefore(toDate)) {
      return projectLength - projectStartedAt.difference(fromDate).inHours;
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isAfter(toDate)) {
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
        chartBars.add(Container(
          decoration: BoxDecoration(
              color: color.withAlpha(100),
              borderRadius: BorderRadius.circular(10.0)),
          height: 30.0,
          width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
          margin: EdgeInsets.only(
              left: calculateDistanceToLeftBorder(usedTimeList[i].startTime) *
                  chartViewWidth /
                  viewRangeToFitScreen,
              top: i == 0 ? 4.0 : 2.0,
              bottom: i == usedTimeList.length - 1 ? 4.0 : 2.0),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '${usedTimeList[i].product}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ));
      }
    }

    return chartBars;
  }

  //渲染头部时间信息
  Widget buildHeader(double chartViewWidth, Color color) {
    List<Widget> headerItems = new List();
    DateTime tempDate = fromDate;
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
    var chartBars =
        buildChartBars(resource.usedTimeList, chartViewWidth, color);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductGanttPage()),
          );
        },
        child: Container(
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
                            height: (chartBars.length == 0 ? 1 : chartBars.length) * 34.0 + 4.0,
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
        ));
  }

  List<Widget> buildChartContent(double chartViewWidth, BuildContext context) {
    return [
      ...data.map((e) => buildChartForEachResource(e, chartViewWidth, context))
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
