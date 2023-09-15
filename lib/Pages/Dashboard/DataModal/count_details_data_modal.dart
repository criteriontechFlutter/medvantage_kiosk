class CountDetailsDataModal{
  int?doctorsCount;
  int?hospitalCount;
  int?userCount;
  String?description;

  CountDetailsDataModal({
    this.doctorsCount,
    this.hospitalCount,
    this.userCount,
    this.description
  });
  factory CountDetailsDataModal.fromJson(Map<String,dynamic>json)=>
      CountDetailsDataModal(
          doctorsCount: json['doctorsCount'],
          hospitalCount: json['hospitalCount'],
          userCount: json['userCount'],
          description: json['description']
      );
}