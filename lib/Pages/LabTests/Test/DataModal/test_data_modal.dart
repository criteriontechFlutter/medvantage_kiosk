class TestDataModal {
  String? testName;
  double? price;
  int? id;
  String? description;
  double? mrp;
  String? type;
  double? discount;
  String? incartStatus;

  TestDataModal(
      {this.testName,
        this.price,
        this.id,
        this.description,
        this.mrp,
        this.type,
        this.discount,
        this.incartStatus});

  TestDataModal.fromJson(Map<String, dynamic> json) {
    testName = json['testName'];
    price = double.parse(json['price'].toString());
    id = json['id'];
    description = json['description'];
    mrp = double.parse(json['mrp'].toString());
    type = json['type'];
    discount = double.parse(json['discount'].toString());
    incartStatus = json['incartStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['testName'] = this.testName;
    data['price'] = this.price;
    data['id'] = this.id;
    data['description'] = this.description;
    data['mrp'] = this.mrp;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['incartStatus'] = this.incartStatus;
    return data;
  }
}
