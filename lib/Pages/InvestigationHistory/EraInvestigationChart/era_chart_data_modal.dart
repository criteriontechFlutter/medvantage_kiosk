
class EraChartDatass {
  int? subTestID;
  String? subTestName;
  double? subTestValue;
  int? unit;
  double? min;
  double? max;
  String? billDate;
  String? createdDate;

  EraChartDatass(
      {this.subTestID,
        this.subTestName,
        this.subTestValue,
        this.unit,
        this.min,
        this.max,
        this.billDate,
        this.createdDate});

  EraChartDatass.fromJson(Map<String, dynamic> json) {
    subTestID = json['subTestID'];
    subTestName = json['subTestName'];
    subTestValue = _getDouble(json['subTestValue'].toString());
    unit = json['unit'];
    min = double.parse(json['min'].toString());
    max = double.parse(json['max'].toString());
    billDate = json['billDate'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subTestID'] = this.subTestID;
    data['subTestName'] = this.subTestName;
    data['subTestValue'] = this.subTestValue;
    data['unit'] = this.unit;
    data['min'] = this.min;
    data['max'] = this.max;
    data['billDate'] = this.billDate;
    data['createdDate'] = this.createdDate;
    return data;
  }
}


double _getDouble(String val){

  try {
    return double.parse(val);
  }
  catch(e){
    return 0.0;
  }
}
