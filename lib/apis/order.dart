import 'dart:convert';

import 'package:crossplatform/apis/client.dart';
import 'package:crossplatform/models/order.dart';

void getAllOrders(handler) {
  sendGetRequest('/order/all?pageNum=1&pageSize=200').then(
        (value) {
      List<dynamic> list = jsonDecode(value);
      return list;
    },
  ).then((List<dynamic> value) {
    return [...value.map((e) => Order.fromJson(e))];
  }).then((value) => handler(value));
}
