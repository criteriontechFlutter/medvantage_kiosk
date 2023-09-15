


class TopSpecialitiesDataModal {
  int? id;
  String? departmentName;
  String? code;
  bool? status;
  int? userId;

  TopSpecialitiesDataModal(
      {this.id, this.departmentName, this.code, this.status, this.userId});

  TopSpecialitiesDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentName = json['departmentName'];
    code = json['code'];
    status = json['status'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['departmentName'] = this.departmentName;
    data['code'] = this.code;
    data['status'] = this.status;
    data['userId'] = this.userId;
    return data;
  }
}