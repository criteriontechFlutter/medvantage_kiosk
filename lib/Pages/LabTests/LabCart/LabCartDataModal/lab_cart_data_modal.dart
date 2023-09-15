class LabCartDataModal {
  String? cartId;
  String? name;
  String? pathologyName;
  String? pathologyId;
  List<PackageTestList>? packageTestList;
  List<CartAmount>? cartAmount;
  String? pathalogyAddress;
  double? price;

  LabCartDataModal(
      {this.cartId,
        this.name,
        this.pathologyName,
        this.pathologyId,
        this.packageTestList,
        this.cartAmount,
        this.pathalogyAddress,
        this.price});

  LabCartDataModal.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    name = json['name'];
    pathologyName = json['pathologyName'];
    pathologyId = json['pathologyId'];
    if (json['packageTestList'] != null) {
      packageTestList = <PackageTestList>[];
      json['packageTestList'].forEach((v) {
        packageTestList!.add(PackageTestList.fromJson(v));
      });
    }
    if (json['cartAmount'] != null) {
      cartAmount = <CartAmount>[];
      json['cartAmount'].forEach((v) {
        cartAmount!.add(CartAmount.fromJson(v));
      });
    }
    pathalogyAddress = json['pathalogyAddress'];
    price = double.parse(json['price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['name'] = this.name;
    data['pathologyName'] = this.pathologyName;
    data['pathologyId'] = this.pathologyId;
    if (this.packageTestList != null) {
      data['packageTestList'] =
          this.packageTestList!.map((v) => v.toJson()).toList();
    }
    if (this.cartAmount != null) {
      data['cartAmount'] = this.cartAmount!.map((v) => v.toJson()).toList();
    }
    data['pathalogyAddress'] = this.pathalogyAddress;
    data['price'] = this.price;
    return data;
  }
}

class PackageTestList {
  String? testName;

  PackageTestList({this.testName});

  PackageTestList.fromJson(Map<String, dynamic> json) {
    testName = json['testName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['testName'] = this.testName;
    return data;
  }
}

class CartAmount {
  double? totalAmount;
  int? totalItem;

  CartAmount({this.totalAmount, this.totalItem});

  CartAmount.fromJson(Map<String, dynamic> json) {
    totalAmount = double.parse(json['totalAmount'].toString());
    totalItem = json['totalItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['totalAmount'] = this.totalAmount;
    data['totalItem'] = this.totalItem;
    return data;
  }
}