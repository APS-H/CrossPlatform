import 'dart:convert';

import 'package:crossplatform/apis/client.dart';
import 'package:crossplatform/models/resource.dart';

void getAllHumanResources(handler) {
  sendGetRequest('/hr/all?pageNum=1&pageSize=100').then(
    (value) {
      List<dynamic> list = jsonDecode(value);
      return list;
    },
  ).then((List<dynamic> value) {
    return [...value.map((e) => Resource.fromJson(e))];
  }).then((value) => handler(value));
}

void getAllEquipmentResources(handler) {
  sendGetRequest('/equipment/all?pageNum=1&pageSize=100').then(
    (value) {
      List<dynamic> list = jsonDecode(value);
      return list;
    },
  ).then((List<dynamic> value) {
    return [...value.map((e) => Resource.fromJson(e))];
  }).then((value) => handler(value));
}
