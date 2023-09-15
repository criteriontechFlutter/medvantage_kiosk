import 'dart:convert';

class TestInfoDataModal {
  String? subTest;
  String? overView;
  String? patientPreperation;
  String? resultInterpretation;
  String? remark;
  List<TestReason>? testReason;

  TestInfoDataModal(
      {this.subTest,
        this.overView,
        this.patientPreperation,
        this.resultInterpretation,
        this.remark,
        this.testReason});

  TestInfoDataModal.fromJson(Map<String, dynamic> json) {
    subTest = json['subTest']??'';
    overView = json['overView']??'No overview available';
    patientPreperation = json['patientPreperation']??'No data availble for preparation';
    resultInterpretation = json['resultInterpretation']??'No result available';
    remark = json['remark']??"No remark available";
    if (json['testReason'] != null) {
      testReason = <TestReason>[];
      jsonDecode(json['testReason']).forEach((v) {
        testReason!.add(TestReason.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subTest'] = this.subTest;
    data['overView'] = this.overView;
    data['patientPreperation'] = this.patientPreperation;
    data['resultInterpretation'] = this.resultInterpretation;
    data['remark'] = this.remark;
    if (this.testReason != null) {
      data['testReason'] = this.testReason!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestReason {
  String? testReason;

  TestReason({this.testReason});

  TestReason.fromJson(Map<String, dynamic> json) {
    testReason = (json['testReason']??"No data available for test reason");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testReason'] = this.testReason;
    return data;
  }
}
