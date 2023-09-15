

class PackageDetails {
  String? packageId;
  String? packageName;
  String? description;
  String? noOfTests;
  String? packagePrice;
  String? mrp;
  String? cartStatus;
  List<GroupDetails>? groupDetails;
  String? discountPerc;
  String? pathologyName;
  String? labAddress;

  PackageDetails(
      {this.packageId,
        this.packageName,
        this.description,
        this.noOfTests,
        this.packagePrice,
        this.mrp,
        this.cartStatus,
        this.groupDetails,
        this.discountPerc,
        this.pathologyName,
        this.labAddress});

  PackageDetails.fromJson(Map json) {
    packageId = json['packageId'];
    packageName = json['packageName'];
    description = json['description'];
    noOfTests = json['noOfTests'];
    packagePrice = json['packagePrice'];
    mrp = json['mrp'];
    cartStatus = json['cartStatus'];
    if (json['groupDetails'] != null) {
      groupDetails = <GroupDetails>[];
      json['groupDetails'].forEach((v) {
        groupDetails!.add(GroupDetails.fromJson(v));
      });
    }
    discountPerc = json['discountPerc'];
    pathologyName = json['pathologyName'];
    labAddress = json['labAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['packageId'] = this.packageId;
    data['packageName'] = this.packageName;
    data['description'] = this.description;
    data['noOfTests'] = this.noOfTests;
    data['packagePrice'] = this.packagePrice;
    data['mrp'] = this.mrp;
    data['cartStatus'] = this.cartStatus;
    if (this.groupDetails != null) {
      data['groupDetails'] = this.groupDetails!.map((v) => v.toJson()).toList();
    }
    data['discountPerc'] = this.discountPerc;
    data['pathologyName'] = this.pathologyName;
    data['labAddress'] = this.labAddress;
    return data;
  }
}

class GroupDetails {
  String? groupName;
  List<TestDetails>? testDetails;

  GroupDetails({this.groupName, this.testDetails});

  GroupDetails.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    if (json['testDetails'] != null) {
      testDetails = <TestDetails>[];
      json['testDetails'].forEach((v) {
        testDetails!.add(TestDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['groupName'] = this.groupName;
    if (this.testDetails != null) {
      data['testDetails'] = this.testDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestDetails {
  String? testName;

  TestDetails({this.testName});

  TestDetails.fromJson(Map<String, dynamic> json) {
    testName = json['testName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['testName'] = this.testName;
    return data;
  }
}
