import 'package:crossplatform/models/resource.dart';

class OrderPlan {
  OrderPlan(this.id, this.orderId, this.productNum, this.schedules);

  int id;
  String orderId;
  int productNum;
  List<Schedule> schedules;
}

class OrderProduction {
  OrderProduction(this.orderID, this.productionID);

  String orderID;
  String productionID;
}

class Production {
  Production(this.id, this.productionID, this.tasks);

  String id;
  int productionID;
  List<Task> tasks;
}

class ProductionResource {
  ProductionResource(this.productionID, this.resources);

  String productionID;
  List<ResourceUsed> resources;
}

class Schedule {
  Schedule(this.id, this.productNum, this.startTime, this.endTime);

  int id;
  int productNum;
  DateTime startTime;
  DateTime endTime;
}

class Task {
  Task(this.id, this.task, this.startTime, this.endTime);

  String id;

  // 当前生产任务对应的产品（物料编号/产品编号）
  int task;
  DateTime startTime;
  DateTime endTime;
}

class ResourceUsed {
  ResourceUsed(this.resourceID, this.resourceType, this.resourceNum);

  String resourceID;
  int resourceType;
  int resourceNum;
}
