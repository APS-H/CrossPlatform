import 'package:crossplatform/models/order.dart';
import 'package:crossplatform/models/resource.dart';
import 'package:crossplatform/models/schedule.dart';

Store store;

class Store {
  // order
  List<Order> orders = [];

  // resource
  List<Resource> humanResources = [];
  List<Resource> equipmentResource = [];

  // schedule
  List<OrderPlan> orderPlans = [];
  List<OrderProduction> orderProductions = [];
  List<Production> productions = [];
  List<ProductionResource> productionResources = [];
}
