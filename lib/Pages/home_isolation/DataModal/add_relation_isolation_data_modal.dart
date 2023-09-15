


class AddRelationIsolationDataModal {
  int? id;
  int? memberId;
  String? mobileNo;
  String? relation;
  bool? status;
  Null? userId;
  String? createdDate;

  AddRelationIsolationDataModal(
      {this.id,
        this.memberId,
        this.mobileNo,
        this.relation,
        this.status,
        this.userId,
        this.createdDate});

  AddRelationIsolationDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['memberId'];
    mobileNo = json['mobileNo'];
    relation = json['relation'];
    status = json['status'];
    userId = json['userId'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memberId'] = this.memberId;
    data['mobileNo'] = this.mobileNo;
    data['relation'] = this.relation;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['createdDate'] = this.createdDate;
    return data;
  }
}