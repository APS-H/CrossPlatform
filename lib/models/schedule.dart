class OrderPlan {
  OrderPlan(this.id, this.orderId, this.productNum, this.schedules);

  OrderPlan.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderId = json['orderNo'],
        productNum = json['productNum'],
        schedules = [...json['schedules'].map((s) => Schedule.fromJson(s))];

  int id;
  String orderId;
  int productNum;
  List<Schedule> schedules;
}

class OrderProduction {
  OrderProduction(this.orderID, this.productionID);

  String orderID;
  String productionID;

  OrderProduction.fromJson(Map<String, dynamic> json)
      : orderID = json['orderId'],
        productionID = json['productionId'];
}

class Production {
  Production(this.productionID, this.id, this.tasks);

  Production.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productionID = json['productionNo'],
        tasks = [...json['tasks'].map((s) => Task.fromJson(s))];

  int id;
  String productionID;
  List<Task> tasks;
}

class ProductionResource {
  ProductionResource(this.productionID, this.resources);

  ProductionResource.fromJson(Map<String, dynamic> json)
      : productionID = json['productionId'],
        resources = [...json['resources'].map((s) => ResourceUsed.fromJson(s))];

  String productionID;
  List<ResourceUsed> resources;
}

class Schedule {
  Schedule(this.id, this.productNum, this.startTime, this.endTime);

  Schedule.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productNum = json['productNum'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']);

  int id;
  int productNum;
  DateTime startTime;
  DateTime endTime;
}

class Task {
  Task(this.id, this.task, this.startTime, this.endTime);

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        task = json['task'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']);

  String id;

  // 当前生产任务对应的产品（物料编号/产品编号）
  int task;
  DateTime startTime;
  DateTime endTime;
}

class ResourceUsed {
  ResourceUsed(this.resourceID, this.resourceType, this.resourceNum);

  ResourceUsed.fromJson(Map<String, dynamic> json)
      : resourceID = json['resourceId'],
        resourceType = json['resourceType'],
        resourceNum = json['resourceNum'];

  String resourceID;
  int resourceType;
  int resourceNum;
}
