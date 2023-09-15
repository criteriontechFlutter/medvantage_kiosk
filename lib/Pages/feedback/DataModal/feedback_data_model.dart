import 'package:flutter/cupertino.dart';

class FeedbackDataModal {
  List<QuestionList>? questionList;
  List<DoctorList>? doctorList;
  List<NursingList>? nursingList;
  List<Table3>? table3;
  List<Table4>? table4;
  List<Table5>? table5;

  FeedbackDataModal(
      {this.questionList,
        this.doctorList,
        this.nursingList,
        this.table3,
        this.table4,
        this.table5});

  FeedbackDataModal.fromJson(Map<String, dynamic> json) {
    if (json['questionList'] != null) {
      questionList = <QuestionList>[];
      json['questionList'].forEach((v) {
        questionList!.add(new QuestionList.fromJson(v));
      });
    }
    if (json['doctorList'] != null) {
      doctorList = <DoctorList>[];
      json['doctorList'].forEach((v) {
        doctorList!.add(new DoctorList.fromJson(v));
      });
    }
    if (json['nursingList'] != null) {
      nursingList = <NursingList>[];
      json['nursingList'].forEach((v) {
        nursingList!.add(new NursingList.fromJson(v));
      });
    }
    if (json['table3'] != null) {
      table3 = <Table3>[];
      json['table3'].forEach((v) {
        table3!.add(new Table3.fromJson(v));
      });
    }
    if (json['table4'] != null) {
      table4 = <Table4>[];
      json['table4'].forEach((v) {
        table4!.add(new Table4.fromJson(v));
      });
    }
    if (json['table5'] != null) {
      table5 = <Table5>[];
      json['table5'].forEach((v) {
        table5!.add(new Table5.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionList != null) {
      data['questionList'] = this.questionList!.map((v) => v.toJson()).toList();
    }
    if (this.doctorList != null) {
      data['doctorList'] = this.doctorList!.map((v) => v.toJson()).toList();
    }
    if (this.nursingList != null) {
      data['nursingList'] = this.nursingList!.map((v) => v.toJson()).toList();
    }
    if (this.table3 != null) {
      data['table3'] = this.table3!.map((v) => v.toJson()).toList();
    }
    if (this.table4 != null) {
      data['table4'] = this.table4!.map((v) => v.toJson()).toList();
    }
    if (this.table5 != null) {
      data['table5'] = this.table5!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionList {
  int? id;
  String? question;
  bool? isExpendable;
  String? questionType;
  int? questionCategoryID;
  int? sNo;
  double?rating;
  TextEditingController? controller;

  QuestionList(
      {this.id,
        this.question,
        this.isExpendable,
        this.questionType,
        this.questionCategoryID,
        this.sNo,
        this.rating,
        this.controller,});

  QuestionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    isExpendable = json['isExpendable'];
    questionType = json['questionType'];
    questionCategoryID = json['questionCategoryID'];
    sNo = json['sNo'];
    rating=json['rating'];
    controller=json['controller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['isExpendable'] = this.isExpendable;
    data['questionType'] = this.questionType;
    data['questionCategoryID'] = this.questionCategoryID;
    data['sNo'] = this.sNo;
    data['rating']=this.rating;
    data['controller']=this.controller;
    return data;
  }
}

class DoctorList {
  int? id;
  String? doctorName;
  String? designationName;
  int? designationID;
  String? imagePath;
  String? empID;
  int? categoryId;

  DoctorList(
      {this.id,
        this.doctorName,
        this.designationName,
        this.designationID,
        this.imagePath,
        this.empID,
        this.categoryId});

  DoctorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorName = json['doctorName'];
    designationName = json['designationName'];
    designationID = json['designationID'];
    imagePath = json['imagePath'];
    empID = json['empID'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorName'] = this.doctorName;
    data['designationName'] = this.designationName;
    data['designationID'] = this.designationID;
    data['imagePath'] = this.imagePath;
    data['empID'] = this.empID;
    data['categoryId'] = this.categoryId;
    return data;
  }
}

class NursingList {
  int? id;
  String? nurseName;
  String? imagePath;
  String? empID;
  int? categoryId;
  double?rating;
  TextEditingController? controller;

  NursingList(
      {this.id, this.nurseName, this.imagePath, this.empID, this.categoryId,this.rating,this.controller,});

  NursingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nurseName = json['nurseName'];
    imagePath = json['imagePath'];
    empID = json['empID'];
    categoryId = json['categoryId'];
    rating=json['rating'];
    controller=json['controller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nurseName'] = this.nurseName;
    data['imagePath'] = this.imagePath;
    data['empID'] = this.empID;
    data['categoryId'] = this.categoryId;
    data['rating']=this.rating;
    data['controller']=this.controller;
    return data;
  }
}

class Table3 {
  int? id;
  String? cleaningEmployee;
  String? imagePath;
  String? empID;
  int? categoryId;

  Table3(
      {this.id,
        this.cleaningEmployee,
        this.imagePath,
        this.empID,
        this.categoryId});

  Table3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cleaningEmployee = json['cleaningEmployee'];
    imagePath = json['imagePath'];
    empID = json['empID'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cleaningEmployee'] = this.cleaningEmployee;
    data['imagePath'] = this.imagePath;
    data['empID'] = this.empID;
    data['categoryId'] = this.categoryId;
    return data;
  }
}

class Table4 {
  int? id;
  String? ayaWardBoy;
  String? imagePath;
  String? empID;
  int? categoryId;
  double?rating;
  TextEditingController? controller;

  Table4(
      {this.id, this.ayaWardBoy, this.imagePath, this.empID, this.categoryId,this.rating,this.controller,});

  Table4.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ayaWardBoy = json['ayaWardBoy'];
    imagePath = json['imagePath'];
    empID = json['empID'];
    categoryId = json['categoryId'];
    rating=json['rating'];
    controller=json['controller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ayaWardBoy'] = this.ayaWardBoy;
    data['imagePath'] = this.imagePath;
    data['empID'] = this.empID;
    data['categoryId'] = this.categoryId;
    data['rating']=this.rating;
    data['controller']=this.controller;
    return data;
  }
}

class Table5 {
  int? id;
  String? technician;
  String? imagePath;
  String? empID;
  int? categoryId;
  double?rating;
  TextEditingController? controller;

  Table5(
      {this.id, this.technician, this.imagePath, this.empID, this.categoryId,this.rating,this.controller,});

  Table5.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    technician = json['technician'];
    imagePath = json['imagePath'];
    empID = json['empID'];
    categoryId = json['categoryId'];
    rating=json['rating'];
    controller=json['controller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['technician'] = this.technician;
    data['imagePath'] = this.imagePath;
    data['empID'] = this.empID;
    data['categoryId'] = this.categoryId;
    data['rating']=this.rating;
    data['controller']=this.controller;
    return data;
  }
}
