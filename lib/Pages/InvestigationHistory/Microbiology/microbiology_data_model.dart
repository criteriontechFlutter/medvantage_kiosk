
class MicrobiologyDataModel {
  String? collectionDateFormatted;
  String? createdDate;
  int? subCategoryID;
  String? subCategoryName;
  int? categoryID;
  String? categoryName;
  String? itemName;
  int? type;
  int? testCount;
  String? labReportNo;
  String? radioReportLink;

  MicrobiologyDataModel(
      {this.collectionDateFormatted,
        this.createdDate,
        this.subCategoryID,
        this.subCategoryName,
        this.categoryID,
        this.categoryName,
        this.itemName,
        this.type,
        this.testCount,
        this.labReportNo,
        this.radioReportLink});

  MicrobiologyDataModel.fromJson(Map<String, dynamic> json) {
    collectionDateFormatted = json['collectionDateFormatted'];
    createdDate = json['createdDate'];
    subCategoryID = json['subCategoryID'];
    subCategoryName = json['subCategoryName'];
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    itemName = json['itemName'];
    type = json['type'];
    testCount = json['testCount'];
    labReportNo = json['labReportNo']==''?"--":json['labReportNo']??"--";
    radioReportLink = json['radioReportLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['collectionDateFormatted'] = this.collectionDateFormatted;
    data['createdDate'] = this.createdDate;
    data['subCategoryID'] = this.subCategoryID;
    data['subCategoryName'] = this.subCategoryName;
    data['categoryID'] = this.categoryID;
    data['categoryName'] = this.categoryName;
    data['itemName'] = this.itemName;
    data['type'] = this.type;
    data['testCount'] = this.testCount;
    data['labReportNo'] = this.labReportNo;
    data['radioReportLink'] = this.radioReportLink;
    return data;
  }
}



