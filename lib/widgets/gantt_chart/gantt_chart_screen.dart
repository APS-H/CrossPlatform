import 'package:crossplatform/common/helpers.dart';
import 'package:crossplatform/models/product.dart';
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
  DateTime fromDate = DateTime(2018, 1, 1);
  DateTime toDate = DateTime(2018, 1, 2);

  List<Product> usersInChart;
  List<Resource> projectsInChart;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: Duration(microseconds: 2000), vsync: this);
    animationController.forward();

    projectsInChart = resources;
    usersInChart = products;
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
              resources: projectsInChart,
              products: usersInChart,
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
  final List<Resource> resources;
  final List<Product> products;

  final _ganttHeaderBarHeight = 40.0;

  int viewRange;
  int viewRangeToFitScreen = 6;
  Animation<double> width;

  GanttChart({
    this.animationController,
    this.fromDate,
    this.toDate,
    this.resources,
    this.products,
  }) {
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
      List<Resource> data, double chartViewWidth, Color color) {
    List<Widget> chartBars = new List();

    for (int i = 0; i < data.length; i++) {
      var remainingWidth =
          calculateRemainingWidth(data[i].startTime, data[i].endTime);
      if (remainingWidth > 0) {
        chartBars.add(Container(
          decoration: BoxDecoration(
              color: color.withAlpha(100),
              borderRadius: BorderRadius.circular(10.0)),
          height: 30.0,
          width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
          margin: EdgeInsets.only(
              left: calculateDistanceToLeftBorder(data[i].startTime) *
                  chartViewWidth /
                  viewRangeToFitScreen,
              top: i == 0 ? 4.0 : 2.0,
              bottom: i == data.length - 1 ? 4.0 : 2.0),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              data[i].name,
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

  Widget buildChartForEachProduct(List<Resource> resourceData,
      double chartViewWidth, Product product, BuildContext context) {
    Color color = randomColorGenerator();
    var chartBars = buildChartBars(resourceData, chartViewWidth, color);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductGanttPage()),
          );
        },
        child: Container(
          height: chartBars.length * 34.0 + _ganttHeaderBarHeight + 4.0,
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
                            height: chartBars.length * 34.0 + 4.0,
                            color: color.withAlpha(100),
                            child: Center(
                              child: RotatedBox(
                                quarterTurns:
                                    chartBars.length * 34.0 + 4.0 > 50 ? 0 : 0,
                                child: Text(
                                  product.name,
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
    List<Widget> chartContent = new List();

    products.forEach((product) {
      List<Resource> resourcesOfProduct = resources
          .where((resource) => resource.products.indexOf(product.id) != -1)
          .toList();

      if (resourcesOfProduct.length > 0) {
        chartContent.add(buildChartForEachProduct(
            resourcesOfProduct, chartViewWidth, product, context));
      }
    });

    return chartContent;
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

var products = [
  Product(id: 1, name: '产品1'),
  Product(id: 2, name: '产品2'),
  Product(id: 3, name: '产品3'),
  Product(id: 4, name: '产品4'),
  Product(id: 5, name: '产品5'),
];

var resources = [
  Resource(
      id: 1,
      name: 'Line 1',
      startTime: DateTime(2018, 1, 1, 7, 0),
      endTime: DateTime(2018, 1, 1, 9, 0),
      products: [1]),
  Resource(
      id: 2,
      name: 'Line 1',
      startTime: DateTime(2018, 1, 1, 9, 0),
      endTime: DateTime(2018, 1, 1, 17, 0),
      products: [2]),
  Resource(
      id: 3,
      name: 'Line 1',
      startTime: DateTime(2018, 1, 1, 18, 0),
      endTime: DateTime(2018, 1, 1, 21, 0),
      products: [3]),
  Resource(
      id: 4,
      name: 'Line 1',
      startTime: DateTime(2018, 1, 1, 21, 0),
      endTime: DateTime(2018, 1, 1, 23, 0),
      products: [4]),
  Resource(
      id: 5,
      name: 'Line 4',
      startTime: DateTime(2018, 1, 1, 9, 0),
      endTime: DateTime(2018, 1, 1, 11, 0),
      products: [3]),
  Resource(
      id: 6,
      name: '李四',
      startTime: DateTime(2018, 1, 1, 7, 0),
      endTime: DateTime(2018, 1, 1, 9, 0),
      products: [1]),
  Resource(
      id: 7,
      name: '李四',
      startTime: DateTime(2018, 1, 1, 9, 0),
      endTime: DateTime(2018, 1, 1, 17, 0),
      products: [2]),
  Resource(
      id: 8,
      name: '李四',
      startTime: DateTime(2018, 1, 1, 21, 0),
      endTime: DateTime(2018, 1, 1, 23, 0),
      products: [5]),
  Resource(
      id: 9,
      name: '小明',
      startTime: DateTime(2018, 1, 1, 9, 0),
      endTime: DateTime(2018, 1, 1, 11, 0),
      products: [3]),
  Resource(
      id: 10,
      name: '小明',
      startTime: DateTime(2018, 1, 1, 18, 0),
      endTime: DateTime(2018, 1, 1, 19, 0),
      products: [3]),
  Resource(
      id: 11,
      name: '张三',
      startTime: DateTime(2018, 1, 1, 19, 0),
      endTime: DateTime(2018, 1, 1, 21, 0),
      products: [3]),
  Resource(
      id: 12,
      name: '张三',
      startTime: DateTime(2018, 1, 1, 21, 0),
      endTime: DateTime(2018, 1, 1, 23, 0),
      products: [4]),
];
