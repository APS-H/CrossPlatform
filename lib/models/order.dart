class OrderProgress {
  String id; //订单号
  List<Progress> crafts; //工艺信息
  OrderProgress(this.id, this.crafts);
}

class Progress {
  String name; //工艺
  double percent;

  Progress(this.name, this.percent);
}

class Order {
  Order(this.id, this.productID, this.productCount, this.deliveryDate);

  Order.fromJson(Map<String, dynamic> json)
      : id = json['orderId'],
        productID = json['stockId'],
        productCount = json['orderAmount'],
        deliveryDate = DateTime.parse(json['dayOfDelivery']);

  String id; // 订单编号
  String productID; // 物料/产品编号
  int productCount; // 物料/产品数量
  DateTime deliveryDate; // 交付日期

  bool selected = false;
}
