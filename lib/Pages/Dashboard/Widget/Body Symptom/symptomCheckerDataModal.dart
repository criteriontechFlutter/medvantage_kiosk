class SymptomCheckerDataModal {
  int? id;
  String? regionName;
  String? organImagePath;

  SymptomCheckerDataModal({this.id, this.regionName, this.organImagePath});

  SymptomCheckerDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionName = json['regionName'];
    organImagePath = json['organImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['regionName'] = this.regionName;
    data['organImagePath'] = this.organImagePath;
    return data;
  }
}






//All symptoms by Alfhabet Data modal




class SymptomRelatedBodyPartDataModal {
  String? id;
  String? problemName;
  String? isVisible;

  SymptomRelatedBodyPartDataModal(
      {this.id, this.problemName, this.isVisible});

  SymptomRelatedBodyPartDataModal.fromJson(Map<String, dynamic> json) {
    id = (json['id']??'').toString();
    problemName = json['problemName'];
    isVisible = json['isVisible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['problemName'] = problemName;
    data['isVisible'] = isVisible;
    return data;
  }
}

 //Problem list data modal

class SuggestedProblemDataModal {
  int? id;
  String? problemName;
  String? isVisible;

  SuggestedProblemDataModal({this.id, this.problemName, this.isVisible});

  SuggestedProblemDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    problemName = json['problemName']??[];
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






//  Suggested unlocalized problem data modal

class SuggestedUnlocalizedProblemDataModal {
  int? id;
  String? problemName;

  SuggestedUnlocalizedProblemDataModal({this.id, this.problemName});

  SuggestedUnlocalizedProblemDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    problemName = json['problemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['problemName'] = this.problemName;
    return data;
  }
}



// Add Any Other Disease you Suffered from DataModal

class AddAnyOtherDiseaseDataModal {
  int? id;
  String? problemName;

  AddAnyOtherDiseaseDataModal({this.id, this.problemName});

  AddAnyOtherDiseaseDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    problemName = json['problemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['problemName'] = this.problemName;
    return data;
  }
}



// On Tap problem Symptoms Data Modal



class ProblemSymptomsDataModal {
  int? problemID;
  String? problemName;
  int? attributeID;
  String? attributeName;
  List<Attribute>? attribute;

  ProblemSymptomsDataModal(
      {
        this.problemID,
        this.problemName,
        this.attributeID,
        this.attributeName,
        this.attribute,
      });

  ProblemSymptomsDataModal.fromJson(Map<String, dynamic> json) {
    problemID = json['problemID'];
    problemName = json['problemName'];
    attributeID = json['attributeID'];
    attributeName = json['attributeName'];
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(new Attribute.fromJson(v));
      });
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['problemID'] = this.problemID;
    data['problemName'] = this.problemName;
    data['attributeID'] = this.attributeID;
    data['attributeName'] = this.attributeName;
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attribute {
  int? problemId;
  int? attributeValueId;
  int? attributeID;
  String? attributeValue;
  bool? isSelected;

  Attribute(
      {this.problemId,
        this.attributeValueId,
        this.attributeID,
        this.attributeValue,
        this.isSelected,

      });

  Attribute.fromJson(Map<String, dynamic> json) {
    problemId = json['problemId'];
    attributeValueId = json['attributeValueId'];
    attributeID = json['attributeID'];
    attributeValue = json['attributeValue'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['problemId'] = this.problemId;
    data['attributeValueId'] = this.attributeValueId;
    data['attributeID'] = this.attributeID;
    data['attributeValue'] = this.attributeValue;
    data['isSelected'] = this.isSelected;
    return data;
  }
}