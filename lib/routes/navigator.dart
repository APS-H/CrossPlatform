import 'package:crossplatform/common/labels.dart';
import 'package:crossplatform/widgets/order_detail.dart';
import 'package:crossplatform/widgets/resource_load.dart';
import 'package:crossplatform/widgets/resource_usage.dart';
import 'package:crossplatform/widgets/schedule_detail.dart';
import 'package:flutter/material.dart';

class NavTarget {
  NavTarget(this.title, this.page);

  String title;
  Widget page;
}

class DrawerNavigator {
  Map<NavItem, NavTarget> routes;

  DrawerNavigator() {
    this.routes = {
      NavItem.placeholder: NavTarget(
        "首页",
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "APSH - 高级排程系统 by H组\nPowered by flutter",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            Container(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                childAspectRatio: 1.3,
                padding: EdgeInsets.fromLTRB(30, 200, 30, 200),
                children: List.generate(
                  6,
                  (index) => Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/example_$index.png"),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              homePicSemanticLabel[index],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      NavItem.resourceUsage: NavTarget("资源使用", ResourceUsageGantt()),
      NavItem.resourceLoadChart: NavTarget("资源负载 - 资源负载图", ResourceLoadChart()),
      NavItem.resourceLoadHumanTable:
          NavTarget("资源负载 - 人力列表", HumanResourceTable()),
      NavItem.resourceLoadEquipmentTable:
          NavTarget("资源负载 - 设备列表", EquipmentResourceTable()),
      NavItem.orderDetailChart: NavTarget("订单详情 - 订单甘特图", OrderProgressChart()),
      NavItem.orderDetailTable: NavTarget("订单详情 - 订单列表", OrderTable()),
      NavItem.scheduleDetailOrderPlanTable:
          NavTarget("排程详情 - 订单计划表", ScheduleDetailOrderPlanTable()),
      NavItem.scheduleDetailOrderProductionTable:
          NavTarget("排程详情 - 订单生产单关系表", ScheduleDetailOrderProductionTable()),
      NavItem.scheduleDetailProductionTable:
          NavTarget("排程详情 - 生产单列表", ScheduleDetailProductionTable()),
      NavItem.scheduleDetailProductionResourceTable:
          NavTarget("排程详情 - 生产单资源关系表", ScheduleDetailProductionResourceTable()),
      NavItem.resourceLoad: NavTarget("资源负载", null),
      NavItem.orderDetail: NavTarget("订单详情", null),
      NavItem.scheduleDetail: NavTarget("排程详情", null),
    };
  }

  NavTarget of(NavItem url) {
    return this.routes[url];
  }
}

enum NavItem {
  placeholder,
  resourceUsage,
  resourceLoad,
  resourceLoadChart,
  resourceLoadHumanTable,
  resourceLoadEquipmentTable,
  orderDetail,
  orderDetailChart,
  orderDetailTable,
  scheduleDetail,
  scheduleDetailOrderPlanTable,
  scheduleDetailOrderProductionTable,
  scheduleDetailProductionTable,
  scheduleDetailProductionResourceTable,
}

final navigateMap = {
  NavItem.placeholder: [NavItem.placeholder],
  NavItem.resourceUsage: [NavItem.resourceUsage],
  NavItem.resourceLoad: [
    NavItem.resourceLoad,
    NavItem.resourceLoadChart,
    NavItem.resourceLoadEquipmentTable,
    NavItem.resourceLoadHumanTable
  ],
  NavItem.orderDetail: [
    NavItem.orderDetail,
    NavItem.orderDetailChart,
    NavItem.orderDetailTable
  ],
  NavItem.scheduleDetail: {
    NavItem.scheduleDetail,
    NavItem.scheduleDetailOrderPlanTable,
    NavItem.scheduleDetailOrderProductionTable,
    NavItem.scheduleDetailProductionResourceTable,
    NavItem.scheduleDetailProductionTable
  }
};
