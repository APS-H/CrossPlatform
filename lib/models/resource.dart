class ResourceLoad {
  ResourceLoad(this.name, this.loadList);

  final String name; // 资源名称
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
