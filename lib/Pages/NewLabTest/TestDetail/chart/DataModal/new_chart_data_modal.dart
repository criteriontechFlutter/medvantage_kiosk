class NewGraphDataModal {
  int? subTestID;
  String? subTestName;
  String? subTestValue;
  double? min;
  double? max;
  int? unit;
  String? billDate;
  String? createdDate;

  NewGraphDataModal(
      {this.subTestID,
        this.subTestName,
        this.subTestValue,
        this.min,
        this.max,
        this.unit,
        this.billDate,
        this.createdDate});

  NewGraphDataModal.fromJson(Map<String, dynamic> json) {
    subTestID = json['subTestID'];
    subTestName = json['subTestName'];

    String subtest=json['subTestValue'].toString().replaceAll("?", "").replaceAll("NA", "").replaceAll("null", "");
    subTestValue = subtest==""? '0':subtest;
    min = json['min']??0.0;
    max = json['max']??0.0;
    unit = json['unit'];
    billDate = json['billDate']??'';
    createdDate = json['createdDate']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subTestID'] = this.subTestID;
    data['subTestName'] = this.subTestName;
    data['subTestValue'] = this.subTestValue;
    data['min'] = this.min;
    data['max'] = this.max;
    data['unit'] = this.unit;
    data['billDate'] = this.billDate;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
