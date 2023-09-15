class RadiologyReportsData {
  int? id;
  String? result;
  String? resultRemark;
  int? billID;
  String? billNo;
  int? sampleCollectionMainID;
  int? itemID;
  String? itemName;
  String? displayOrder;
  int? categoryID;
  int? isCultureSterile;
  String? testTime;
  String? collectionDate;

  RadiologyReportsData(
      {this.id,
        this.result,
        this.resultRemark,
        this.billID,
        this.billNo,
        this.sampleCollectionMainID,
        this.itemID,
        this.itemName,
        this.displayOrder,
        this.categoryID,
        this.isCultureSterile,
        this.testTime,
        this.collectionDate});

  RadiologyReportsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result = json['result']??"NA";
    resultRemark = json['resultRemark']??"";
    billID = json['billID'];
    billNo = json['billNo']??"NA";
    sampleCollectionMainID = json['sampleCollectionMainID'];
    itemID = json['itemID'];
    itemName = json['itemName']??"";
    displayOrder = json['displayOrder'];
    categoryID = json['categoryID'];
    isCultureSterile = json['isCultureSterile'];
    testTime = json['testTime']??"NA";
    collectionDate = json['collectionDate']??"NA";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['result'] = this.result;
    data['resultRemark'] = this.resultRemark;
    data['billID'] = this.billID;
    data['billNo'] = this.billNo;
    data['sampleCollectionMainID'] = this.sampleCollectionMainID;
    data['itemID'] = this.itemID;
    data['itemName'] = this.itemName;
    data['displayOrder'] = this.displayOrder;
    data['categoryID'] = this.categoryID;
    data['isCultureSterile'] = this.isCultureSterile;
    data['testTime'] = this.testTime;
    data['collectionDate'] = this.collectionDate;
    return data;
  }
}
