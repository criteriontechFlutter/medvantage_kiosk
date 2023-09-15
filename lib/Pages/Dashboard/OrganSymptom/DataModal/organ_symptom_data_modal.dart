


class OrganSymptom {
  int? id;
  String? symptoms;
  bool? isSelected;

  OrganSymptom({this.id, this.symptoms, this.isSelected});

  OrganSymptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symptoms = json['symptoms'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['symptoms'] = this.symptoms;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
