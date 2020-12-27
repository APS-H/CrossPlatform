import 'package:crossplatform/apis/client.dart';
import 'dart:convert';

import 'package:crossplatform/models/schedule.dart';

void getPlanTable(handler) {
  sendGetRequest('/schedule/plan-table?pageSize=100&pageNum=1').then(
    (value) {
      List<dynamic> list = jsonDecode(value);
      return list;
    },
  ).then((List<dynamic> value) {
    return [...value.map((e) => OrderPlan.fromJson(e))];
  }).then((value) => handler(value));
}

void getOrderProductionTable(handler) {
  sendGetRequest('/schedule/order-production-table?pageSize=100&pageNum=1')
      .then(
    (value) {
      List<dynamic> list = jsonDecode(value);
      return list;
    },
  ).then((List<dynamic> value) {
    return [...value.map((e) => OrderProduction.fromJson(e))];
  }).then((value) => handler(value));
}

void getProductionTable(handler) {
  sendGetRequest('/schedule/production-table?pageSize=100&pageNum=1').then(
    (value) {
      List<dynamic> list = jsonDecode(value);
      return list;
    },
  ).then((List<dynamic> value) {
    return [...value.map((e) => Production.fromJson(e))];
  }).then((value) => handler(value));
}

void getProductionResourceTable(handler) {
  sendGetRequest('/schedule/production-resource-table?pageSize=100&pageNum=1')
      .then((value) {
    List<dynamic> list = jsonDecode(value);
    return list;
  }).then((List<dynamic> value) {
    return [...value.map((e) => ProductionResource.fromJson(e))];
  }).then((value) => handler(value));
}
