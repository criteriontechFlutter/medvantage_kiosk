


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

class ProblemName {
  int? id;
  String? problemName;
  String? isVisible;

  ProblemName({this.id, this.problemName, this.isVisible});

  ProblemName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    problemName = json['problemName'];
    isVisible = json['isVisible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['problemName'] = this.problemName;
    data['isVisible'] = this.isVisible;
    return data;
  }
}

