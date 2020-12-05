class OrderData {
  String id; //订单号
  List<ProgressData> crafts; //工艺信息
  bool delay; //是否延期
  String deal; //约定交期
  String expc; //预计交期
  OrderData(this.id, this.crafts, this.delay);
}

class ProgressData {
  String name; //工艺
  double percent;

  ProgressData(this.name, this.percent);
}
