import 'dart:convert';

class NewTestDetailDataModal {
  int? itemID;
  String? itemName;
  String? testTime;
  String? collectionDate;
  int? displayOrder;
  List<SubTest>? subTest;
  bool isContainerOpen=false;

  NewTestDetailDataModal(
      {this.itemID,
        this.itemName,
        this.testTime,
        this.collectionDate,
        this.displayOrder,
        this.subTest,required this.isContainerOpen
      });

  NewTestDetailDataModal.fromJson(Map<String, dynamic> json) {
    itemID = json['itemID'];
    itemName = json['itemName']??'';
    testTime = json['testTime']??'';
    collectionDate = json['collectionDate']??'';
    displayOrder = json['displayOrder'];
    if (json['subTest'] != null) {
      subTest = <SubTest>[];
      jsonDecode(json['subTest']).forEach((v) {
        subTest!.add(SubTest.fromJson(v));
      });
    }
    isContainerOpen;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['itemID'] = this.itemID;
    data['itemName'] = this.itemName;
    data['testTime'] = this.testTime;
    data['collectionDate'] = this.collectionDate;
    data['displayOrder'] = this.displayOrder;
    if (this.subTest != null) {
      data['subTest'] = this.subTest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubTest {
  int? id;
  String? subTestName;
  String? finalResultStatus;
  String? result;
  String? resultRemark;
  String? unitname;
  bool? isNormalResult;
  String? normalRange;

  SubTest(
      {this.id,
        this.subTestName,
        this.finalResultStatus,
        this.result,
        this.resultRemark,
        this.unitname,
        this.isNormalResult,
        this.normalRange});

  SubTest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subTestName = json['subTestName'];
    finalResultStatus = json['finalResultStatus'];
    result = json['result']??'--';
    resultRemark = json['resultRemark'];
    unitname = json['unitname'];
    isNormalResult = json['isNormalResult'];
    normalRange = json['normalRange']??'--';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['subTestName'] = this.subTestName;
    data['finalResultStatus'] = this.finalResultStatus;
    data['result'] = this.result;
    data['resultRemark'] = this.resultRemark;
    data['unitname'] = this.unitname;
    data['isNormalResult'] = this.isNormalResult;
    data['normalRange'] = this.normalRange;
    return data;
  }
}
