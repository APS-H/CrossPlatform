enum ResourceType { humanResource, equipmentResource }

class ResourceLoad {
  ResourceLoad(this.name, this.type, this.loadList);

  final String name; // 资源名称
  final ResourceType type; // 资源类型
  final List<double> loadList; // 资源负载列表

  bool selected = false;
}

class Resource {
  Resource(this.name, this.count, this.shift, this.workDays);

  String name;
  int count;
  int shift;
  List<int> workDays;

  bool selected = false;
}

class ResourceUsage {
  ResourceUsage(
      this.resourceID, this.resourceName, this.resourceType, this.usedTimeList);

  String resourceID;
  String resourceName;
  int resourceType;
  List<UsedTime> usedTimeList;
}

class UsedTime {
  UsedTime(this.product, this.startTime, this.endTime, this.isDelayed);

  int product;
  DateTime startTime;
  DateTime endTime;
  bool isDelayed;
}
