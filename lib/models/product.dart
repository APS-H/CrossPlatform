class Product {
  int id;
  String name;

  Product({this.id, this.name});
}

class Resource {
  int id;
  String name;
  DateTime startTime;
  DateTime endTime;
  List<int> products;

  Resource(
      {this.id, this.name, this.startTime, this.endTime, this.products});
}