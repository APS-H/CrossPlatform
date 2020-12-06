import 'package:crossplatform/models/order.dart';
import 'package:crossplatform/models/resource.dart';
import 'package:crossplatform/models/schedule.dart';
import 'package:crossplatform/models/shift.dart';
import 'package:flutter/material.dart';

final shiftMap = {
  0: Shift("早班", TimeOfDay(hour: 7, minute: 0), TimeOfDay(hour: 19, minute: 0)),
  1: Shift("晚班", TimeOfDay(hour: 19, minute: 0), TimeOfDay(hour: 7, minute: 0)),
  2: Shift(
      "全天", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 23, minute: 59)),
};

final List<Resource> humanResources = <Resource>[
  Resource("10组-陈  云（5）", 5, 0, [1, 2, 3, 4, 5]),
  Resource("11组-张  娟（4）", 4, 0, [1, 2, 3, 4, 5]),
  Resource("12组-姚兰（5）", 5, 1, [1, 2, 3, 4, 5]),
  Resource("13组-刘燕（3）", 3, 0, [1, 2, 3, 4, 5]),
  Resource("14组-周  清（4）", 4, 0, [1, 2, 3, 4, 5]),
  Resource("15组-李娟（5）", 5, 1, [1, 2, 3, 4, 5]),
  Resource("16组-朱美（4）", 4, 1, [1, 2, 3, 4, 5]),
  Resource("17组-吴凤（4）", 4, 0, [1, 2, 3, 4, 5]),
  Resource("18组-芮  娜（3）", 3, 1, [1, 2, 3, 4, 5]),
  Resource("19组-王  秀（3）", 3, 1, [1, 2, 3, 4, 5]),
  Resource("1组-彭慧（5）", 5, 1, [1, 2, 3, 4, 5]),
  Resource("20组-王梅（4）", 4, 1, [1, 2, 3, 4, 5]),
  Resource("21组-陈花（4）", 4, 0, [1, 2, 3, 4, 5]),
  Resource("22组-陈霞（3）", 3, 0, [1, 2, 3, 4, 5]),
  Resource("23组-吴凤（4）", 3, 1, [1, 2, 3, 4, 5]),
  Resource("24组-张 娟1（3）", 3, 0, [1, 2, 3, 4, 5]),
  Resource("26组-杨  丽（5）", 5, 0, [1, 2, 3, 4, 5]),
  Resource("27组-徐燕（5）", 5, 0, [1, 2, 3, 4, 5]),
  Resource("28组-杜珍（4）", 4, 1, [1, 2, 3, 4, 5]),
  Resource("2组-丁梅（3）", 3, 1, [1, 2, 3, 4, 5]),
  Resource("30组-陈  梅（4）", 4, 1, [1, 2, 3, 4, 5]),
  Resource("31组-史玲（4）", 4, 1, [1, 2, 3, 4, 5]),
  Resource("33组-许萍（5）", 5, 0, [1, 2, 3, 4, 5]),
  Resource("36组-谢霞（4）", 4, 0, [1, 2, 3, 4, 5]),
  Resource("39组-刘  霞（3）", 3, 0, [1, 2, 3, 4, 5]),
  Resource("3组-李翠（4）", 4, 0, [1, 2, 3, 4, 5]),
  Resource("40组-高燕（5）", 5, 0, [1, 2, 3, 4, 5]),
  Resource("4组-赵勤（3）", 3, 0, [1, 2, 3, 4, 5]),
  Resource("6组-李  倩（4）", 4, 1, [1, 2, 3, 4, 5]),
  Resource("7组-黄娣（4）", 4, 0, [1, 2, 3, 4, 5]),
  Resource("8组-张萍（4）", 4, 0, [1, 2, 3, 4, 5]),
  Resource("9组-张敏（5）", 5, 0, [1, 2, 3, 4, 5]),
  Resource("UKK组-王娣（6）", 6, 0, [1, 2, 3, 4, 5]),
  Resource("5组-童玲（5）", 5, 0, [1, 2, 3, 4, 5]),
];

final List<Resource> equipmentResource = <Resource>[
  Resource("line01", 3, 2, [1, 2, 3, 4, 5]),
  Resource("line02", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line03", 3, 2, [1, 2, 3, 4, 5]),
  Resource("line04", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line05", 5, 2, [1, 2, 3, 4, 5]),
  Resource("line06", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line07", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line08", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line10", 3, 2, [1, 2, 3, 4, 5]),
  Resource("line11", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line12", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line14", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line15", 1, 2, [1, 2, 3, 4, 5]),
  Resource("line17", 3, 2, [1, 2, 3, 4, 5]),
  Resource("line18", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line19", 3, 2, [1, 2, 3, 4, 5]),
  Resource("line20", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line30", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line31", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line32", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line33", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line34", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line35", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line36", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line37", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line38", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line39", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line40", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line41", 4, 2, [1, 2, 3, 4, 5]),
  Resource("line42", 5, 2, [1, 2, 3, 4, 5]),
  Resource("line43", 1, 2, [1, 2, 3, 4, 5]),
  Resource("弹片机(3)", 3, 2, [1, 2, 3, 4, 5, 6, 7]),
  Resource("电阻测试机(2)", 2, 2, [1, 2, 3, 4, 5, 6, 7]),
  Resource("移印机(1)", 1, 2, [1, 2, 3, 4, 5, 6, 7]),
  Resource("自动包装机(2)", 2, 2, [1, 2, 3, 4, 5, 6, 7]),
  Resource("高电压测试机(5)", 5, 2, [1, 2, 3, 4, 5, 6, 7])
];

final List<OrderProgress> ordersProgress = <OrderProgress>[
  OrderProgress('418575', [
    Progress('装配', 1),
  ]),
  OrderProgress('418577', [
    Progress('装配', 1),
  ]),
  OrderProgress('764486', [
    Progress('装配', 0.6),
  ]),
  OrderProgress('762904', [
    Progress('装配', 0.23),
    Progress('测试', 0.18),
  ]),
  OrderProgress('418477', [
    Progress('装配', 0.23),
    Progress('测试', 0),
  ]),
  OrderProgress('418006', [
    Progress('装配', 0.20),
    Progress('测试', 0.18),
  ]),
];

final List<Order> orders = <Order>[
  Order("418477", "3246515", 7700, DateTime(2018, 11, 9)),
  Order("418006", "1413036", 44600, DateTime(2018, 11, 9)),
  Order("764486", "1413036", 30000, DateTime(2018, 11, 9)),
  Order("418575", "3246515", 8400, DateTime(2018, 11, 9)),
  Order("418351", "3247967", 100, DateTime(2018, 11, 9)),
  Order("764374", "3247967", 200, DateTime(2018, 11, 14)),
  Order("418483", "3246418", 3200, DateTime(2018, 11, 14)),
  Order("418322", "3048823", 6000, DateTime(2018, 11, 14)),
  Order("763623", "3213124", 100, DateTime(2018, 11, 14)),
  Order("417642", "3213124", 1500, DateTime(2018, 11, 15)),
  Order("418194", "3005840", 200, DateTime(2018, 11, 15)),
  Order("762904", "3005840", 4800, DateTime(2018, 11, 15)),
  Order("414837", "3005837", 6400, DateTime(2018, 11, 15)),
  Order("418433", "3246418", 5500, DateTime(2018, 11, 15)),
  Order("418652", "3048823", 5000, DateTime(2018, 11, 16)),
  Order("762917", "3050015", 8100, DateTime(2018, 11, 19)),
  Order("764104", "3211498", 4000, DateTime(2018, 11, 19)),
  Order("764104", "3211498", 1900, DateTime(2018, 11, 20)),
  Order("764310", "3211498", 2100, DateTime(2018, 11, 20)),
  Order("764098", "3209248", 1620, DateTime(2018, 11, 21)),
  Order("764087", "3000607", 3400, DateTime(2018, 11, 22)),
  Order("417194", "3000607", 500, DateTime(2018, 11, 22)),
  Order("763131", "3050015", 2700, DateTime(2018, 11, 23)),
  Order("417174", "3059786", 11400, DateTime(2018, 12, 5)),
  Order("762485", "3209248", 1980, DateTime(2018, 12, 16)),
  Order("762838", "1302215", 21000, DateTime(2018, 12, 7)),
  Order("417830", "3031238", 5000, DateTime(2018, 12, 18)),
  Order("416621", "3036466", 3250, DateTime(2018, 12, 20)),
];

final List<ResourceLoad> resources = <ResourceLoad>[
  ResourceLoad('Frozen yogurt', ResourceType.humanResource,
      [159, 6.0, 24, 4.0, 87, 14, 1]),
  ResourceLoad('Ice cream sandwich', ResourceType.humanResource,
      [237, 9.0, 37, 4.3, 129, 8, 1]),
  ResourceLoad(
      'Eclair', ResourceType.humanResource, [262, 16.0, 24, 6.0, 337, 6, 7]),
  ResourceLoad(
      'Cupcake', ResourceType.humanResource, [305, 3.7, 67, 4.3, 413, 3, 8]),
  ResourceLoad('Gingerbread', ResourceType.humanResource,
      [356, 16.0, 49, 3.9, 327, 7, 16]),
  ResourceLoad(
      'Jelly bean', ResourceType.humanResource, [375, 0.0, 94, 0.0, 50, 0, 0]),
  ResourceLoad(
      'Lollipop', ResourceType.humanResource, [392, 0.2, 98, 0.0, 38, 0, 2]),
  ResourceLoad(
      'Honeycomb', ResourceType.humanResource, [408, 3.2, 87, 6.5, 562, 0, 45]),
  ResourceLoad(
      'Donut', ResourceType.humanResource, [452, 25.0, 51, 4.9, 326, 2, 22]),
  ResourceLoad(
      'KitKat', ResourceType.humanResource, [518, 26.0, 65, 7.0, 54, 12, 6]),
  ResourceLoad('Frozen yogurt with sugar', ResourceType.humanResource,
      [168, 6.0, 26, 4.0, 87, 14, 1]),
  ResourceLoad('Ice cream sandwich with sugar', ResourceType.humanResource,
      [246, 9.0, 39, 4.3, 129, 8, 1]),
  ResourceLoad('Eclair with sugar', ResourceType.humanResource,
      [271, 16.0, 26, 6.0, 337, 6, 7]),
  ResourceLoad('Cupcake with sugar', ResourceType.humanResource,
      [314, 3.7, 69, 4.3, 413, 3, 8]),
  ResourceLoad('Gingerbread with sugar', ResourceType.humanResource,
      [345, 16.0, 51, 3.9, 327, 7, 16]),
  ResourceLoad('Jelly bean with sugar', ResourceType.humanResource,
      [364, 0.0, 96, 0.0, 50, 0, 0]),
  ResourceLoad('Lollipop with sugar', ResourceType.humanResource,
      [401, 0.2, 100, 0.0, 38, 0, 2]),
  ResourceLoad('Honeycomb with sugar', ResourceType.humanResource,
      [417, 3.2, 89, 6.5, 562, 0, 45]),
  ResourceLoad('Donut with sugar', ResourceType.humanResource,
      [461, 25.0, 53, 4.9, 326, 2, 22]),
  ResourceLoad('KitKat with sugar', ResourceType.humanResource,
      [527, 26.0, 67, 7.0, 54, 12, 6]),
  ResourceLoad('Frozen yogurt with honey', ResourceType.humanResource,
      [223, 6.0, 36, 4.0, 87, 14, 1]),
  ResourceLoad('Ice cream sandwich with honey', ResourceType.humanResource,
      [301, 9.0, 49, 4.3, 129, 8, 1]),
  ResourceLoad('Eclair with honey', ResourceType.humanResource,
      [326, 16.0, 36, 6.0, 337, 6, 7]),
  ResourceLoad('Cupcake with honey', ResourceType.humanResource,
      [369, 3.7, 79, 4.3, 413, 3, 8]),
  ResourceLoad('Gingerbread with honey', ResourceType.humanResource,
      [420, 16.0, 61, 3.9, 327, 7, 16]),
  ResourceLoad('Jelly bean with honey', ResourceType.humanResource,
      [439, 0.0, 106, 0.0, 50, 0, 0]),
  ResourceLoad('Lollipop with honey', ResourceType.humanResource,
      [456, 0.2, 110, 0.0, 38, 0, 2]),
  ResourceLoad('Honeycomb with honey', ResourceType.humanResource,
      [472, 3.2, 99, 6.5, 562, 0, 45]),
  ResourceLoad('Donut with honey', ResourceType.humanResource,
      [516, 25.0, 63, 4.9, 326, 2, 22]),
  ResourceLoad('KitKat with honey', ResourceType.humanResource,
      [582, 26.0, 77, 7.0, 54, 12, 6]),
  ResourceLoad('Frozen yogurt with milk', ResourceType.humanResource,
      [262, 8.4, 36, 12.0, 194, 44, 1]),
  ResourceLoad('Ice cream sandwich with milk', ResourceType.equipmentResource,
      [339, 11.4, 49, 12.3, 236, 38, 1]),
  ResourceLoad('Eclair with milk', ResourceType.equipmentResource,
      [365, 18.4, 36, 14.0, 444, 36, 7]),
  ResourceLoad('Cupcake with milk', ResourceType.equipmentResource,
      [408, 6.1, 79, 12.3, 520, 33, 8]),
  ResourceLoad('Gingerbread with milk', ResourceType.equipmentResource,
      [459, 18.4, 61, 11.9, 434, 37, 16]),
  ResourceLoad('Jelly bean with milk', ResourceType.equipmentResource,
      [478, 2.4, 106, 8.0, 157, 30, 0]),
  ResourceLoad('Lollipop with milk', ResourceType.equipmentResource,
      [495, 2.6, 110, 8.0, 145, 30, 2]),
  ResourceLoad('Honeycomb with milk', ResourceType.equipmentResource,
      [511, 5.6, 99, 14.5, 669, 30, 45]),
  ResourceLoad('Donut with milk', ResourceType.equipmentResource,
      [555, 27.4, 63, 12.9, 433, 32, 22]),
  ResourceLoad('KitKat with milk', ResourceType.equipmentResource,
      [621, 28.4, 77, 15.0, 161, 42, 6]),
  ResourceLoad('Coconut slice and frozen yogurt',
      ResourceType.equipmentResource, [318, 21.0, 31, 5.5, 96, 14, 7]),
  ResourceLoad('Coconut slice and ice cream sandwich',
      ResourceType.equipmentResource, [396, 24.0, 44, 5.8, 138, 8, 7]),
  ResourceLoad('Coconut slice and eclair', ResourceType.equipmentResource,
      [421, 31.0, 31, 7.5, 346, 6, 13]),
  ResourceLoad('Coconut slice and cupcake', ResourceType.equipmentResource,
      [464, 18.7, 74, 5.8, 422, 3, 14]),
  ResourceLoad('Coconut slice and gingerbread', ResourceType.equipmentResource,
      [515, 31.0, 56, 5.4, 316, 7, 22]),
  ResourceLoad('Coconut slice and jelly bean', ResourceType.equipmentResource,
      [534, 15.0, 101, 1.5, 59, 0, 6]),
  ResourceLoad('Coconut slice and lollipop', ResourceType.equipmentResource,
      [551, 15.2, 105, 1.5, 47, 0, 8]),
  ResourceLoad('Coconut slice and honeycomb', ResourceType.equipmentResource,
      [567, 18.2, 94, 8.0, 571, 0, 51]),
  ResourceLoad('Coconut slice and donut', ResourceType.equipmentResource,
      [611, 40.0, 58, 6.4, 335, 2, 28]),
  ResourceLoad('Coconut slice and KitKat', ResourceType.equipmentResource,
      [677, 41.0, 72, 8.5, 63, 12, 12]),
];

final List<OrderPlan> orderPlans = <OrderPlan>[
  OrderPlan(764098, "764098", 1620, [
    Schedule(
      7640981,
      270,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    ),
    Schedule(
      7640983,
      270,
      DateTime(2018, 11, 07, 13, 00),
      DateTime(2018, 11, 07, 19, 00),
    ),
    Schedule(
      7640980,
      270,
      DateTime(2018, 11, 07, 19, 00),
      DateTime(2018, 11, 08, 01, 00),
    ),
    Schedule(
      7640984,
      270,
      DateTime(2018, 11, 08, 01, 00),
      DateTime(2018, 11, 08, 07, 00),
    ),
    Schedule(
      7640985,
      270,
      DateTime(2018, 11, 08, 07, 00),
      DateTime(2018, 11, 08, 13, 00),
    ),
    Schedule(
      7640982,
      270,
      DateTime(2018, 11, 07, 13, 00),
      DateTime(2018, 11, 07, 19, 00),
    )
  ]),
  OrderPlan(762838, "762838", 21000, [
    Schedule(
      7628380,
      18750,
      DateTime(2018, 11, 07, 19, 00),
      DateTime(2018, 11, 07, 22, 00),
    )
  ]),
  OrderPlan(417830, "417830", 5000, [
    Schedule(
      4178301,
      1176,
      DateTime(2018, 11, 07, 13, 00),
      DateTime(2018, 11, 07, 19, 00),
    ),
    Schedule(
      4178304,
      196,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 08, 00),
    ),
    Schedule(
      4178302,
      1176,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    ),
    Schedule(
      4178303,
      1176,
      DateTime(2018, 11, 07, 13, 00),
      DateTime(2018, 11, 07, 19, 00),
    ),
    Schedule(
      4178300,
      1176,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    )
  ]),
  OrderPlan(414837, "414837", 6400, [
    Schedule(
      4148371,
      1428,
      DateTime(2018, 11, 07, 13, 00),
      DateTime(2018, 11, 07, 19, 00),
    ),
    Schedule(
      4148372,
      1428,
      DateTime(2018, 11, 08, 13, 00),
      DateTime(2018, 11, 08, 19, 00),
    ),
    Schedule(
      4148373,
      1428,
      DateTime(2018, 11, 09, 07, 00),
      DateTime(2018, 11, 09, 13, 00),
    ),
    Schedule(
      4148374,
      476,
      DateTime(2018, 11, 09, 13, 00),
      DateTime(2018, 11, 09, 15, 00),
    ),
    Schedule(
      4148370,
      1428,
      DateTime(2018, 11, 08, 07, 00),
      DateTime(2018, 11, 08, 13, 00),
    )
  ]),
  OrderPlan(762485, "762485", 1980, [
    Schedule(
      7624854,
      270,
      DateTime(2018, 11, 09, 07, 00),
      DateTime(2018, 11, 09, 13, 00),
    ),
    Schedule(
      7624856,
      270,
      DateTime(2018, 11, 08, 07, 00),
      DateTime(2018, 11, 08, 13, 00),
    ),
    Schedule(
      7624850,
      270,
      DateTime(2018, 11, 08, 19, 00),
      DateTime(2018, 11, 09, 01, 00),
    ),
    Schedule(
      7624852,
      270,
      DateTime(2018, 11, 08, 13, 00),
      DateTime(2018, 11, 08, 19, 00),
    ),
    Schedule(
      7624851,
      270,
      DateTime(2018, 11, 09, 01, 00),
      DateTime(2018, 11, 09, 07, 00),
    ),
    Schedule(
      7624857,
      90,
      DateTime(2018, 11, 08, 13, 00),
      DateTime(2018, 11, 08, 15, 00),
    ),
    Schedule(
      7624855,
      270,
      DateTime(2018, 11, 09, 13, 00),
      DateTime(2018, 11, 09, 19, 00),
    ),
    Schedule(
      7624853,
      270,
      DateTime(2018, 11, 08, 07, 00),
      DateTime(2018, 11, 08, 13, 00),
    )
  ]),
  OrderPlan(764310, "764310", 2100, [
    Schedule(
      7643101,
      500,
      DateTime(2018, 11, 07, 13, 00),
      DateTime(2018, 11, 07, 15, 00),
    ),
    Schedule(
      7643100,
      1500,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    )
  ]),
  OrderPlan(764104, "764104", 4000, [
    Schedule(
      7641042,
      1000,
      DateTime(2018, 11, 07, 19, 00),
      DateTime(2018, 11, 07, 23, 00),
    ),
    Schedule(
      7641041,
      1500,
      DateTime(2018, 11, 07, 19, 00),
      DateTime(2018, 11, 08, 01, 00),
    ),
    Schedule(
      7641040,
      1500,
      DateTime(2018, 11, 07, 13, 00),
      DateTime(2018, 11, 07, 19, 00),
    )
  ]),
  OrderPlan(417174, "417174", 11400, [
    Schedule(
      4171744,
      1878,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    ),
    Schedule(
      4171743,
      1878,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    ),
    Schedule(
      4171745,
      1878,
      DateTime(2018, 11, 07, 13, 00),
      DateTime(2018, 11, 07, 19, 00),
    ),
    Schedule(
      4171741,
      1878,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    ),
    Schedule(
      4171740,
      1878,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    ),
    Schedule(
      4171742,
      1878,
      DateTime(2018, 11, 07, 07, 00),
      DateTime(2018, 11, 07, 13, 00),
    )
  ]),
];

final List<OrderProduction> orderProductions = <OrderProduction>[
  OrderProduction("764098", "764098 1"),
  OrderProduction("764098", "764098 3"),
  OrderProduction("764098", "764098 0"),
  OrderProduction("764098", "764098 4"),
  OrderProduction("764098", "764098 5"),
  OrderProduction("764098", "764098 2"),
  OrderProduction("762838", "762838 0"),
  OrderProduction("417830", "417830 1"),
  OrderProduction("417830", "417830 4"),
  OrderProduction("417830", "417830 2"),
  OrderProduction("417830", "417830 3"),
  OrderProduction("417830", "417830 0"),
  OrderProduction("414837", "414837 1"),
  OrderProduction("414837", "414837 2"),
  OrderProduction("414837", "414837 3"),
  OrderProduction("414837", "414837 4"),
  OrderProduction("414837", "414837 0"),
  OrderProduction("762485", "762485 4"),
  OrderProduction("762485", "762485 6"),
  OrderProduction("762485", "762485 0"),
  OrderProduction("762485", "762485 2"),
  OrderProduction("762485", "762485 1"),
  OrderProduction("762485", "762485 7"),
  OrderProduction("762485", "762485 5"),
  OrderProduction("762485", "762485 3"),
  OrderProduction("764310", "764310 1"),
  OrderProduction("764310", "764310 0"),
  OrderProduction("764104", "764104 2"),
  OrderProduction("764104", "764104 1"),
  OrderProduction("764104", "764104 0"),
  OrderProduction("417174", "417174 4"),
  OrderProduction("417174", "417174 3"),
  OrderProduction("417174", "417174 5"),
  OrderProduction("417174", "417174 1"),
  OrderProduction("417174", "417174 0"),
  OrderProduction("417174", "417174 2"),
];

final List<Production> productions = <Production>[
  Production("764098 1", 38, [
    Task("764098 1", 3209248, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
  Production("764098 3", 37, [
    Task("764098 3", 3209248, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 11, 00))
  ]),
  Production("764098 0", 40, [
    Task("764098 0", 3209248, DateTime(2018, 11, 07, 11, 00),
        DateTime(2018, 11, 07, 17, 00))
  ]),
  Production("764098 4", 39, [
    Task("764098 4", 3209248, DateTime(2018, 11, 07, 17, 00),
        DateTime(2018, 11, 07, 23, 00))
  ]),
  Production("764098 5", 42, [
    Task("764098 5", 3209248, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00))
  ]),
  Production("764098 2", 41, [
    Task("764098 2", 3209248, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 11, 00))
  ]),
  Production("762838 0", 43, [
    Task("762838 0", 1302215, DateTime(2018, 11, 07, 11, 00),
        DateTime(2018, 11, 07, 14, 00))
  ]),
  Production("417830 1", 45, [
    Task("417830 1", 3031238, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 11, 00))
  ]),
  Production("417830 4", 48, [
    Task("417830 4", 3031238, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 00, 00))
  ]),
  Production("417830 2", 47, [
    Task("417830 2", 3031238, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
  Production("417830 3", 46, [
    Task("417830 3", 3031238, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 11, 00))
  ]),
  Production("417830 0", 44, [
    Task("417830 0", 3031238, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
  Production("414837 1", 49, [
    Task("414837 1", 3005837, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 11, 00))
  ]),
  Production("414837 2", 50, [
    Task("414837 2", 3005837, DateTime(2018, 11, 08, 05, 00),
        DateTime(2018, 11, 08, 11, 00))
  ]),
  Production("414837 3", 51, [
    Task("414837 3", 3005837, DateTime(2018, 11, 08, 23, 00),
        DateTime(2018, 11, 09, 05, 00))
  ]),
  Production("414837 4", 52, [
    Task("414837 4", 3005837, DateTime(2018, 11, 09, 05, 00),
        DateTime(2018, 11, 09, 07, 00))
  ]),
  Production("414837 0", 53, [
    Task("414837 0", 3005837, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00))
  ]),
  Production("762485 4", 61, [
    Task("762485 4", 3209248, DateTime(2018, 11, 08, 23, 00),
        DateTime(2018, 11, 09, 05, 00))
  ]),
  Production("762485 6", 57, [
    Task("762485 6", 3209248, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00))
  ]),
  Production("762485 0", 59, [
    Task("762485 0", 3209248, DateTime(2018, 11, 08, 11, 00),
        DateTime(2018, 11, 08, 17, 00))
  ]),
  Production("762485 2", 54, [
    Task("762485 2", 3209248, DateTime(2018, 11, 08, 05, 00),
        DateTime(2018, 11, 08, 11, 00))
  ]),
  Production("762485 1", 55, [
    Task("762485 1", 3209248, DateTime(2018, 11, 08, 17, 00),
        DateTime(2018, 11, 08, 23, 00))
  ]),
  Production("762485 7", 58, [
    Task("762485 7", 3209248, DateTime(2018, 11, 08, 05, 00),
        DateTime(2018, 11, 08, 07, 00))
  ]),
  Production("762485 5", 60, [
    Task("762485 5", 3209248, DateTime(2018, 11, 09, 05, 00),
        DateTime(2018, 11, 09, 11, 00))
  ]),
  Production("762485 3", 56, [
    Task("762485 3", 3209248, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00))
  ]),
  Production("764310 1", 63, [
    Task("764310 1", 3211498, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 07, 00))
  ]),
  Production("764310 0", 62, [
    Task("764310 0", 3211498, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
  Production("764104 2", 65, [
    Task("764104 2", 3211498, DateTime(2018, 11, 07, 11, 00),
        DateTime(2018, 11, 07, 15, 00))
  ]),
  Production("764104 1", 66, [
    Task("764104 1", 3211498, DateTime(2018, 11, 07, 11, 00),
        DateTime(2018, 11, 07, 17, 00))
  ]),
  Production("764104 0", 64, [
    Task("764104 0", 3211498, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 11, 00))
  ]),
  Production("764104 2", 65, [
    Task("764104 2", 3211498, DateTime(2018, 11, 07, 11, 00),
        DateTime(2018, 11, 07, 15, 00))
  ]),
  Production("764104 1", 66, [
    Task("764104 1", 3211498, DateTime(2018, 11, 07, 11, 00),
        DateTime(2018, 11, 07, 17, 00))
  ]),
  Production("764104 0", 64, [
    Task("764104 0", 3211498, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 11, 00))
  ]),
  Production("417174 4", 72, [
    Task("417174 4", 3059786, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
  Production("417174 3", 68, [
    Task("417174 3", 3059786, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
  Production("417174 5", 69, [
    Task("417174 5", 3059786, DateTime(2018, 11, 07, 05, 00),
        DateTime(2018, 11, 07, 11, 00))
  ]),
  Production("417174 1", 67, [
    Task("417174 1", 3059786, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
  Production("417174 0", 70, [
    Task("417174 0", 3059786, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
  Production("417174 2", 71, [
    Task("417174 2", 3059786, DateTime(2018, 11, 06, 23, 00),
        DateTime(2018, 11, 07, 05, 00))
  ]),
];

final List<ProductionResource> productionResources = <ProductionResource>[
  ProductionResource("764098 1",
      [ResourceUsed("40组-高燕（5）", 0, 1), ResourceUsed("line350", 1, 1)]),
  ProductionResource("764098 3",
      [ResourceUsed("40组-高燕（5）", 0, 1), ResourceUsed("line351", 1, 1)]),
  ProductionResource("764098 0",
      [ResourceUsed("15组-李娟（5）", 0, 1), ResourceUsed("line350", 1, 1)]),
  ProductionResource("764098 4",
      [ResourceUsed("15组-李娟（5）", 0, 1), ResourceUsed("line352", 1, 1)]),
  ProductionResource("764098 5",
      [ResourceUsed("26组-杨  丽（5）", 0, 1), ResourceUsed("line350", 1, 1)]),
  ProductionResource("764098 2",
      [ResourceUsed("26组-杨  丽（5）", 0, 1), ResourceUsed("line350", 1, 1)]),
  ProductionResource("762838 0",
      [ResourceUsed("30组-陈  梅(4)", 0, 1), ResourceUsed("line430", 1, 1)]),
  ProductionResource("417830 1",
      [ResourceUsed("10组-陈  云（5）", 0, 1), ResourceUsed("line061", 1, 1)]),
  ProductionResource("417830 4",
      [ResourceUsed("27组-徐燕(5)", 0, 1), ResourceUsed("line061", 1, 1)]),
  ProductionResource("417830 2",
      [ResourceUsed("26组-杨  丽（5）", 0, 1), ResourceUsed("line062", 1, 1)]),
  ProductionResource("417830 3",
      [ResourceUsed("27组-徐燕(5)", 0, 1), ResourceUsed("line060", 1, 1)]),
  ProductionResource("417830 0",
      [ResourceUsed("10组-陈  云（5）", 0, 1), ResourceUsed("line060", 1, 1)]),
  ProductionResource("414837 1", [
    ResourceUsed("39组-刘  霞（3）", 0, 1),
    ResourceUsed("4组-赵勤（3）", 0, 1),
    ResourceUsed("line110", 1, 1)
  ]),
  ProductionResource("414837 2", [
    ResourceUsed("24组-张 娟1（3）", 0, 1),
    ResourceUsed("39组-刘  霞（3）", 0, 1),
    ResourceUsed("line111", 1, 1)
  ]),
  ProductionResource("414837 3", [
    ResourceUsed("24组-张 娟1（3）", 0, 1),
    ResourceUsed("39组-刘  霞（3）", 0, 1),
    ResourceUsed("line110", 1, 1)
  ]),
  ProductionResource("414837 4", [
    ResourceUsed("24组-张 娟1（3）", 0, 1),
    ResourceUsed("39组-刘  霞（3）", 0, 1),
    ResourceUsed("line110", 1, 1)
  ]),
  ProductionResource("414837 0", [
    ResourceUsed("24组-张 娟1（3）", 0, 1),
    ResourceUsed("39组-刘  霞（3）", 0, 1),
    ResourceUsed("line110", 1, 1)
  ]),
  ProductionResource("762485 4",
      [ResourceUsed("26组-杨  丽（5）", 0, 1), ResourceUsed("line350", 1, 1)]),
  ProductionResource("762485 6",
      [ResourceUsed("40组-高燕（5）", 0, 1), ResourceUsed("line353", 1, 1)]),
  ProductionResource("762485 0",
      [ResourceUsed("15组-李娟（5）", 0, 1), ResourceUsed("line351", 1, 1)]),
  ProductionResource("762485 2",
      [ResourceUsed("26组-杨  丽（5）", 0, 1), ResourceUsed("line351", 1, 1)]),
  ProductionResource("762485 1",
      [ResourceUsed("15组-李娟（5）", 0, 1), ResourceUsed("line350", 1, 1)]),
  ProductionResource("762485 7",
      [ResourceUsed("27组-徐燕(5)", 0, 1), ResourceUsed("line350", 1, 1)]),
  ProductionResource("762485 5",
      [ResourceUsed("26组-杨  丽（5）", 0, 1), ResourceUsed("line351", 1, 1)]),
  ProductionResource("762485 3",
      [ResourceUsed("27组-徐燕(5)", 0, 1), ResourceUsed("line352", 1, 1)]),
  ProductionResource("764310 1",
      [ResourceUsed("11组-张  娟（4）", 0, 1), ResourceUsed("line140", 1, 1)]),
  ProductionResource("764310 0",
      [ResourceUsed("11组-张  娟（4）", 0, 1), ResourceUsed("line140", 1, 1)]),
  ProductionResource("764104 2",
      [ResourceUsed("23组-吴凤（4）", 0, 1), ResourceUsed("line143", 1, 1)]),
  ProductionResource("764104 1",
      [ResourceUsed("1组-彭慧 (5)", 0, 1), ResourceUsed("line142", 1, 1)]),
  ProductionResource("764104 0",
      [ResourceUsed("24组-张 娟1（3）", 0, 1), ResourceUsed("line141", 1, 1)]),
  ProductionResource("417174 4",
      [ResourceUsed("8组-张萍（4）", 0, 1), ResourceUsed("line340", 1, 1)]),
  ProductionResource("417174 3", [
    ResourceUsed("4组-赵勤（3）", 0, 1),
    ResourceUsed("7组-黄娣（4）", 0, 1),
    ResourceUsed("line333", 1, 1)
  ]),
  ProductionResource("417174 5", [
    ResourceUsed("13组-刘燕（3）", 0, 1),
    ResourceUsed("14组-周  清（4）", 0, 1),
    ResourceUsed("line330", 1, 1)
  ]),
  ProductionResource("417174 1",
      [ResourceUsed("36组-谢霞(4)", 0, 1), ResourceUsed("line331", 1, 1)]),
  ProductionResource("417174 0", [
    ResourceUsed("13组-刘燕（3）", 0, 1),
    ResourceUsed("14组-周  清（4）", 0, 1),
    ResourceUsed("line330", 1, 1)
  ]),
  ProductionResource("417174 2", [
    ResourceUsed("24组-张 娟1（3）", 0, 1),
    ResourceUsed("39组-刘  霞（3）", 0, 1),
    ResourceUsed("line332", 1, 1)
  ]),
];

final List<ResourceUsage> resourceUsageList = <ResourceUsage>[
  ResourceUsage("line01-0", "line01", 1, []),
  ResourceUsage("line02-0", "line02", 1, []),
  ResourceUsage("line03-0", "line03", 1, []),
  ResourceUsage("line04-0", "line04", 1, []),
  ResourceUsage("line05-0", "line05", 1, []),
  ResourceUsage("line06-0", "line06", 1, []),
  ResourceUsage("line07-0", "line07", 1, []),
  ResourceUsage("line08-0", "line08", 1, []),
  ResourceUsage("line10-0", "line10", 1, []),
  ResourceUsage("line11,0", "line11", 1, []),
  ResourceUsage("line12-0", "line12", 1, []),
  ResourceUsage("line14-0", "line14", 1, []),
  ResourceUsage("line15-0", "line15", 1, []),
  ResourceUsage("line17-0", "line17", 1, []),
  ResourceUsage("line18-0", "line18", 1, []),
  ResourceUsage("line19-0", "line19", 1, []),
  ResourceUsage("line20-0", "line20", 1, []),
  ResourceUsage("line30-0", "line30", 1, []),
  ResourceUsage("line31-0", "line31", 1, []),
  ResourceUsage("line32-0", "line32", 1, []),
  ResourceUsage("line33-0", "line33", 1, []),
  ResourceUsage("line34-0", "line34", 1, []),
  ResourceUsage("line35-0", "line35", 1, []),
  ResourceUsage("line36-0", "line36", 1, []),
  ResourceUsage("line37-0", "line37", 1, []),
  ResourceUsage("line38-0", "line38", 1, []),
  ResourceUsage("line39-0", "line39", 1, []),
  ResourceUsage("line40-0", "line40", 1, []),
  ResourceUsage("line41-0", "line41", 1, []),
  ResourceUsage("line42-0", "line42", 1, []),
  ResourceUsage("line43-0", "line43", 1, []),
  ResourceUsage("弹片机(3)-0", "弹片机(3)", 1, []),
  ResourceUsage("弹片机(3)-1", "弹片机(3)", 1, []),
  ResourceUsage("弹片机(3)-2", "弹片机(3)", 1, []),
  ResourceUsage("电阻测试机(2)-0", "电阻测试机(2)", 1, []),
  ResourceUsage("电阻测试机(2)-1", "电阻测试机(2)", 1, []),
  ResourceUsage("移印机(1)-0", "移印机(1)", 1, []),
  ResourceUsage("自动包装机(2)-0", "自动包装机(2)", 1, []),
  ResourceUsage("自动包装机(2)-1", "自动包装机(2)", 1, []),
  ResourceUsage("高电压测试机(5)-0", "高电压测试机(5)", 1, []),
  ResourceUsage("高电压测试机(5)-1", "高电压测试机(5)", 1, []),
  ResourceUsage("高电压测试机(5)-2", "高电压测试机(5)", 1, []),
  ResourceUsage("高电压测试机(5)-3", "高电压测试机(5)", 1, []),
  ResourceUsage("高电压测试机(5)-4", "高电压测试机(5)", 1, []),
  ResourceUsage("10组-陈  云（5）", "10组-陈  云（5）", 0, []),
  ResourceUsage("11组-张  娟（4）", "11组-张  娟（4）", 0, []),
  ResourceUsage("12组-姚兰（5）", "12组-姚兰（5）", 0, []),
  ResourceUsage("13组-刘燕（3）", "13组-刘燕（3）", 0, []),
  ResourceUsage("14组-周  清（4）", "14组-周  清（4）", 0, []),
  ResourceUsage("15组-李娟（5）", "15组-李娟（5）", 0, [
    UsedTime(764098, DateTime(2018, 11, 07, 17, 00),
        DateTime(2018, 11, 07, 23, 00), false),
    UsedTime(762485, DateTime(2018, 11, 08, 11, 00),
        DateTime(2018, 11, 08, 17, 00), false)
  ]),
  ResourceUsage("16组-朱美（4）", "16组-朱美（4）", 0, []),
  ResourceUsage("17组-吴凤（4）", "17组-吴凤（4）", 0, []),
  ResourceUsage("18组-芮  娜（3）", "18组-芮  娜（3）", 0, []),
  ResourceUsage("19组-王  秀（3）", "19组-王  秀（3）", 0, []),
  ResourceUsage("1组-彭慧 (5)", "1组-彭慧 (5)", 0, []),
  ResourceUsage("20组-王梅（4）", "20组-王梅（4）", 0, []),
  ResourceUsage("21组-陈花（4）", "21组-陈花（4）", 0, []),
  ResourceUsage("22组-陈霞（3）", "22组-陈霞（3）", 0, []),
  ResourceUsage("23组-吴凤（4）", "23组-吴凤（4）", 0, []),
  ResourceUsage("24组-张 娟1（3）", "24组-张 娟1（3）", 0, [
    UsedTime(414837, DateTime(2018, 11, 08, 05, 00),
        DateTime(2018, 11, 08, 11, 00), false),
    UsedTime(414837, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00), false)
  ]),
  ResourceUsage("26组-杨  丽（5）", "26组-杨  丽（5）", 0, [
    UsedTime(764098, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00), false),
    UsedTime(762485, DateTime(2018, 11, 08, 05, 00),
        DateTime(2018, 11, 08, 11, 00), false)
  ]),
  ResourceUsage("27组-徐燕(5)", "27组-徐燕(5)", 0, [
    UsedTime(762485, DateTime(2018, 11, 08, 05, 00),
        DateTime(2018, 11, 08, 07, 00), false),
    UsedTime(762485, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00), false)
  ]),
  ResourceUsage("28组-杜珍(4)", "28组-杜珍(4)", 0, []),
  ResourceUsage("2组-丁梅（3）", "2组-丁梅（3）", 0, []),
  ResourceUsage("30组-陈  梅(4)", "30组-陈  梅(4)", 0, []),
  ResourceUsage("31组-史玲(4)", "31组-史玲(4)", 0, []),
  ResourceUsage("33组-许萍（5）", "33组-许萍（5）", 0, []),
  ResourceUsage("36组-谢霞(4)", "36组-谢霞(4)", 0, []),
  ResourceUsage("39组-刘  霞（3）", "39组-刘  霞（3）", 0, [
    UsedTime(414837, DateTime(2018, 11, 08, 05, 00),
        DateTime(2018, 11, 08, 11, 00), false),
    UsedTime(414837, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00), false)
  ]),
  ResourceUsage("3组-李翠 (4)", "3组-李翠 (4)", 0, []),
  ResourceUsage("40组-高燕（5）", "40组-高燕（5）", 0, [
    UsedTime(762485, DateTime(2018, 11, 07, 23, 00),
        DateTime(2018, 11, 08, 05, 00), false)
  ]),
  ResourceUsage("4组-赵勤（3）", "4组-赵勤（3）", 0, []),
  ResourceUsage("6组-李  倩（4）", "6组-李  倩（4）", 0, []),
  ResourceUsage("7组-黄娣（4）", "7组-黄娣（4）", 0, []),
  ResourceUsage("8组-张萍（4）", "8组-张萍（4）", 0, []),
  ResourceUsage("9组-张敏（5）", "9组-张敏（5）", 0, []),
  ResourceUsage("UKK组-王娣（6）", "UKK组-王娣（6）", 0, []),
  ResourceUsage("﻿5组-童玲 (5)", "﻿5组-童玲 (5)", 0, []),
];
