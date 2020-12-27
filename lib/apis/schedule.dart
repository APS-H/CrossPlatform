import 'package:crossplatform/apis/client.dart';
import 'dart:convert';

import 'package:crossplatform/models/schedule.dart';

void getPlanTable() {
  sendGetRequest(
          'http://localhost:8080/schedule/plan-table?pageSize=100&pageNum=1')
      .then(
    (value) {
      List<dynamic> list = jsonDecode(value);
      return list;
    },
  ).then((List<dynamic> value) {
    for (dynamic el in value) {
      print('$el\n');
      Map map = jsonDecode(el);
      print(OrderPlan.fromJson(map));
    }
  });
  // print(res);
}
