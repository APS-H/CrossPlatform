import 'package:crossplatform/models/schedule.dart';

Store store;

class Store {
  // schedule
  List<OrderPlan> orderPlans = [];
  List<OrderProduction> orderProductions = [];
  List<Production> productions = [];
  List<ProductionResource> productionResources = [];
}
