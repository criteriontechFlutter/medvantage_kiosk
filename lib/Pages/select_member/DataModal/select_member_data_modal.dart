class SelectMemberDataModal{
  int ?id;
  String? name;
  String ?age;
  String ?profilePhotoPath;
  int ?primaryStatus;
  int? memberId;
  String? pid;
  String? gender;


  SelectMemberDataModal({
    this.id,
    this.name,
    this.age,
    this.profilePhotoPath,
    this.primaryStatus,
    this.memberId,
    this.pid,
    this.gender,
}) ;
  factory SelectMemberDataModal.fromJson(Map<String, dynamic> json) =>
      SelectMemberDataModal(
        id: json['id'],
        name: json['name'],
      //  name: (json['name']),
        age: json['age'],
        profilePhotoPath: json['profilePhotoPath'],
          primaryStatus:json['primaryStatus'],
        memberId: json['memberId'],
        pid: json['pid'],
        gender: json['gender'],
      );

}