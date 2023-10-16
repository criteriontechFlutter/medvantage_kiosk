class LDepartmentDataModal {
  String? id;
  String? departmentName;
  String? categoryId;
  String? categoryName;
  bool? status;
  String? userId;

  LDepartmentDataModal(
      {this.id,
        this.departmentName,
        this.categoryId,
        this.categoryName,
        this.status,
        this.userId});

  LDepartmentDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentName = json['departmentName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    status = json['status'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['departmentName'] = this.departmentName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['status'] = this.status;
    data['userId'] = this.userId;
    return data;
  }
}


class LocationDataModal {
  String? id;
  String? locationId;
  String? deptId;
  String? buildingName;
  String? floorName;
  String? roomNumber;
  String? departMentName;

  LocationDataModal(
      {this.id,
        this.locationId,
        this.deptId,
        this.buildingName,
        this.floorName,
        this.roomNumber,
        this.departMentName});

  LocationDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['locationId'];
    deptId = json['deptId'];
    buildingName = json['buildingName'];
    floorName = json['floorName'];
    roomNumber = json['roomNumber'];
    departMentName = json['departMentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['locationId'] = this.locationId;
    data['deptId'] = this.deptId;
    data['buildingName'] = this.buildingName;
    data['floorName'] = this.floorName;
    data['roomNumber'] = this.roomNumber;
    data['departMentName'] = this.departMentName;
    return data;
  }
}
