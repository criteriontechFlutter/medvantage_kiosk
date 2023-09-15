// class TopSpecialitiesDataModal {
//   int id;
//   String specialityName;
//   String imagePath;
//   String description;
//   int noOfDoctors;
//
//
//   TopSpecialitiesDataModal({
//     required this.id,
//     required this.specialityName,
//     required this.imagePath,
//     required this.description,
//     required this.noOfDoctors,
//   });
//
//   factory TopSpecialitiesDataModal.fromJson(Map<String, dynamic> json) =>
//       TopSpecialitiesDataModal(
//         id: json['id'],
//         specialityName: json['specialityName'],
//         imagePath: json['imagePath'],
//         description: (json['description']),
//         noOfDoctors: (json['noOfDoctors']),
//       );
//
//
// }


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


