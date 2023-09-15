


import 'dart:convert';

class ClinicalFeaturesDataModal {
  String? departmentId;
  String? departmentName;
  String? inputType;
  List<Concern>? concern;

  ClinicalFeaturesDataModal(
      {this.departmentId, this.departmentName, this.inputType, this.concern});

  ClinicalFeaturesDataModal.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId']??'';
    departmentName = json['departmentName']??'';
    inputType = json['inputType']??'';
    if (json['concern'] != null) {
      concern = <Concern>[];
      json['concern'].forEach((v) {
        concern!.add(Concern.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    data['inputType'] = this.inputType;
    if (this.concern != null) {
      data['concern'] = this.concern!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Concern {
  String? stageId;
  String? stage;
  List<Data>? data;

  Concern({this.stageId, this.stage, this.data});

  Concern.fromJson(Map<String, dynamic> json) {
    stageId = json['stageId']??'';
    stage = json['stage']??'';
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stageId'] = this.stageId;
    data['stage'] = this.stage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? problemName;

  Data({this.problemName});

  Data.fromJson(Map<String, dynamic> json) {
    problemName = json['problemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['problemName'] = this.problemName;
    return data;
  }
}



//Diagnostics  Data  Modal


class DiagnosticsDataModal {
  String? departmentId;
  String? departmentName;
  String? type;
  List<Investigation>? investigation;

  DiagnosticsDataModal(
      {this.departmentId, this.departmentName, this.type, this.investigation});

  DiagnosticsDataModal.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId']??'';
    departmentName = json['departmentName']??'';
    type = json['type']??'';
    if (json['investigation'] != null) {
      investigation = <Investigation>[];
      json['investigation'].forEach((v) {
        investigation!.add(Investigation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    data['type'] = this.type;
    if (this.investigation != null) {
      data['investigation'] =
          this.investigation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Investigation {
  String? stageId;
  String? stage;
  List<DiagnosticsData>? data;

  Investigation({this.stageId, this.stage, this.data});

  Investigation.fromJson(Map<String, dynamic> json) {
    stageId = json['stageId']??'';
    stage = json['stage']??'';
    if (json['data'] != null) {
      data = <DiagnosticsData>[];
      json['data'].forEach((v) {
        data!.add(DiagnosticsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stageId'] = this.stageId;
    data['stage'] = this.stage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiagnosticsData {
  String? testName;
  String? subTestName;
  String? propertyName;
  String? propertyValue;
  String? remarkValue;

  DiagnosticsData(
      {this.testName,
        this.subTestName,
        this.propertyName,
        this.propertyValue,
        this.remarkValue});

  DiagnosticsData.fromJson(Map<String, dynamic> json) {
    testName = json['testName']??'';
    subTestName = json['subTestName']??'';
    propertyName = json['propertyName']??'';
    propertyValue = json['propertyValue']??'';
    remarkValue = json['remarkValue']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['testName'] = this.testName;
    data['subTestName'] = this.subTestName;
    data['propertyName'] = this.propertyName;
    data['propertyValue'] = this.propertyValue;
    data['remarkValue'] = this.remarkValue;
    return data;
  }
}




// Treatment Data Modal



class TreatmentDataModal {
  String? subHeading;
  List<TreatmentData>? data;
 // List<TreatmentName>?treatmentName;

  TreatmentDataModal({this.subHeading, this.data,
    //this.treatmentName
  });

  TreatmentDataModal.fromJson(Map<String, dynamic> json) {
    subHeading = json['subHeading']??'';
    if (json['data'] != null) {
      data = <TreatmentData>[];
      json['data'].forEach((v) {
        data!.add(TreatmentData.fromJson(v));
      });
    }
    // if (json['data'] != null) {
    //   treatmentName = <TreatmentName>[];
    //   json['data'].forEach((v) {
    //     treatmentName!.add(new TreatmentName.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subHeading'] = this.subHeading;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TreatmentData {
  String? departmentId;
  String? departmentName;
  List<TreatmentType>? treatmentType;

  TreatmentData({this.departmentId, this.departmentName, this.treatmentType});

  TreatmentData.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId']??'';
    departmentName = json['departmentName']??'';
    if (json['treatmentType'] != null) {
      treatmentType = <TreatmentType>[];
      json['treatmentType'].forEach((v) {
        treatmentType!.add(TreatmentType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.treatmentType != null) {
      data['treatmentType'] =
          this.treatmentType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TreatmentType {
  List<MedTreatDataModel>? treatmentType;

  TreatmentType({this.treatmentType});
  factory TreatmentType.fromJson(Map<String, dynamic> json) =>
      TreatmentType(
          treatmentType: List<MedTreatDataModel>.from(
              jsonDecode((json["treatmentType"]=='')?[]:json["treatmentType"]).map((element) => MedTreatDataModel.fromJson(element))
                  //jsonDecode((json["treatmentType"]==null || json["treatmentType"] is String)?'[]':(json["treatmentType"]==null || json["treatmentType"] is List)?[]:json["treatmentType"]).map((element) => MedTreatDataModel.fromJson(element))
          )
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['treatmentType'] = this.treatmentType;
    return data;
  }
}


class MedTreatDataModel{
  int?medId;
  String?medName;
  MedTreatDataModel({
    this.medId,
    this.medName
});
  factory MedTreatDataModel.fromJson(Map<String, dynamic> json) =>
      MedTreatDataModel(
          medId: json['medicineID'],
        medName: json['mediicneName']??''
      );
}




class TreatDataModal{
  List<TList>? treatmentList;
  TreatDataModal({
    this.treatmentList,
});
  factory TreatDataModal.fromJson(Map<String, dynamic> json) =>
      TreatDataModal(
        treatmentList: json['treatmentList']??'',
      );
}
class TList{
  String? treatmentName;
  String? treatment;
  TList({
    this.treatmentName,
    this.treatment,
  });
  factory TList.fromJson(Map<String, dynamic> json) =>
      TList(
        treatmentName: json['treatmentName']??'',
        treatment: json['treatment']??'',
      );

}


// class TreatmentName {
//   String? treatmentName;
//   String? treatment;
//
//   TreatmentName({this.treatmentName, this.treatment});
//
//   TreatmentName.fromJson(Map<String, dynamic> json) {
//     treatmentName = json['treatmentName'];
//     treatment = json['treatment'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['treatmentName'] = this.treatmentName;
//     data['treatment'] = this.treatment;
//     return data;
//   }
// }


//Precaution Data modal


class PrecautionDataModal {
  String? subHeading;
  List<PrecautionData>? data;

  PrecautionDataModal({this.subHeading, this.data});

  PrecautionDataModal.fromJson(Map<String, dynamic> json) {
    subHeading = json['subHeading'];
    if (json['data'] != null) {
      data = <PrecautionData>[];
      json['data'].forEach((v) {
        data!.add(PrecautionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subHeading'] = this.subHeading;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrecautionData {
  int? departmentId;
  String? departmentName;
  List<PrecautionType>? precautionType;

  PrecautionData({this.departmentId, this.departmentName, this.precautionType});

  PrecautionData.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    departmentName = json['departmentName'];
    if (json['precautionType'] != null) {
      precautionType = <PrecautionType>[];
      json['precautionType'].forEach((v) {
        precautionType!.add(PrecautionType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.precautionType != null) {
      data['precautionType'] =
          this.precautionType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrecautionType {
  String? precautionType;

  PrecautionType({this.precautionType});

  PrecautionType.fromJson(Map<String, dynamic> json) {
    precautionType = json['precautionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['precautionType'] = this.precautionType;
    return data;
  }
}








//  Concerns Data Modal


class ConcernsDataModal {
  String? subHeading;
  List<ConcernsData>? data;

  ConcernsDataModal({this.subHeading, this.data});

  ConcernsDataModal.fromJson(Map<String, dynamic> json) {
    subHeading = json['subHeading']??'';
    if (json['data'] != null) {
      data = <ConcernsData>[];
      json['data'].forEach((v) {
        data!.add(ConcernsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subHeading'] = this.subHeading;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConcernsData {
  int? departmentId;
  String? departmentName;
  List<ConcernType>? precautionType;

  ConcernsData({this.departmentId, this.departmentName, this.precautionType});

  ConcernsData.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    departmentName = json['departmentName']??'';
    if (json['precautionType'] != null) {
      precautionType = <ConcernType>[];
      json['precautionType'].forEach((v) {
        precautionType!.add(ConcernType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.precautionType != null) {
      data['concernType'] = this.precautionType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConcernType {
  String? concernType;

  ConcernType({this.concernType});

  ConcernType.fromJson(Map<String, dynamic> json) {
    concernType = json['concernType']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['concernType'] = this.concernType;
    return data;
  }
}


//Diet data Modal


class DietDataModal {
  String? departmentId;
  String? departmentName;
  List<ProvisionalDiet>? provisionalDiet;

  DietDataModal({this.departmentId, this.departmentName, this.provisionalDiet});

  DietDataModal.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId']??'';
    departmentName = json['departmentName']??'';
    if (json['provisionalDiet'] != null) {
      provisionalDiet = <ProvisionalDiet>[];
      json['provisionalDiet'].forEach((v) {
        provisionalDiet!.add(ProvisionalDiet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.provisionalDiet != null) {
      data['provisionalDiet'] =
          this.provisionalDiet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProvisionalDiet {
  String? provisionalDiet;

  ProvisionalDiet({this.provisionalDiet});

  ProvisionalDiet.fromJson(Map<String, dynamic> json) {
    provisionalDiet = json['provisionalDiet']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['provisionalDiet'] = this.provisionalDiet;
    return data;
  }
}



//Related Disease Data Modal


class RelatedDiseaseDataModal {
  String? departmentId;
  String? departmentName;
  List<DifferentialDiagnosis>? differentialDiagnosis;

  RelatedDiseaseDataModal(
      {this.departmentId, this.departmentName, this.differentialDiagnosis});

  RelatedDiseaseDataModal.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId']??'';
    departmentName = json['departmentName']??'';
    if (json['differentialDiagnosis'] != null) {
      differentialDiagnosis = <DifferentialDiagnosis>[];
      json['differentialDiagnosis'].forEach((v) {
        differentialDiagnosis!.add(DifferentialDiagnosis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.differentialDiagnosis != null) {
      data['differentialDiagnosis'] =
          this.differentialDiagnosis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DifferentialDiagnosis {
  List<DDiagonosis>? differentialDiagnosis;

  DifferentialDiagnosis({this.differentialDiagnosis});

  DifferentialDiagnosis.fromJson(Map<String, dynamic> json) {
    if (json['differentialDiagnosis'] != null) {
      differentialDiagnosis = <DDiagonosis>[];
      jsonDecode(json['differentialDiagnosis']).forEach((v) {
        differentialDiagnosis!.add(DDiagonosis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.differentialDiagnosis != null) {
      data['differentialDiagnosis'] =
          this.differentialDiagnosis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DDiagonosis{
  int? problemId;
  String? problemName;

  DDiagonosis({
    this.problemId,
    this.problemName,
});

  DDiagonosis.fromJson(Map<String, dynamic> json) {
    problemId = json['problemId'] ?? '';
    problemName = json['problemName'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['problemId'] = this.problemId;
    data['problemName'] = this.problemName;
    return data;
  }
}


// Pathophysiology Data Modal


class PathophysiologyDataModal {
  String? departmentId;
  String? departmentName;
  List<Pathophysiology>? pathophysiology;

  PathophysiologyDataModal(
      {this.departmentId, this.departmentName, this.pathophysiology});

  PathophysiologyDataModal.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId']??'';
    departmentName = json['departmentName']??'';
    if (json['pathophysiology'] != null) {
      pathophysiology = <Pathophysiology>[];
      json['pathophysiology'].forEach((v) {
        pathophysiology!.add(Pathophysiology.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.pathophysiology != null) {
      data['pathophysiology'] =
          this.pathophysiology!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pathophysiology {
  String? pathophysiology;
  String? pathophysiologyAttachment;

  Pathophysiology({this.pathophysiology, this.pathophysiologyAttachment});

  Pathophysiology.fromJson(Map<String, dynamic> json) {
    pathophysiology = json['pathophysiology']??'';
    pathophysiologyAttachment = json['pathophysiologyAttachment']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pathophysiology'] = this.pathophysiology;
    data['pathophysiologyAttachment'] = this.pathophysiologyAttachment;
    return data;
  }
}




// Epidemiology Data Modal


class EpidemiologyDataModal {
  String? subHeading;
  List<EpidemiologyData>? data;

  EpidemiologyDataModal({this.subHeading, this.data});

  EpidemiologyDataModal.fromJson(Map<String, dynamic> json) {
    subHeading = json['subHeading']??'';
    if (json['data'] != null) {
      data = <EpidemiologyData>[];
      json['data'].forEach((v) {
        data!.add(EpidemiologyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subHeading'] = this.subHeading;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EpidemiologyData {
  String? departmentId;
  String? departmentName;
  List<Prognosis>? prognosis;

  EpidemiologyData({this.departmentId, this.departmentName, this.prognosis});

  EpidemiologyData.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId']??'';
    departmentName = json['departmentName']??'';
    if (json['prognosis'] != null) {
      prognosis = <Prognosis>[];
      json['prognosis'].forEach((v) {
        prognosis!.add(Prognosis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.prognosis != null) {
      data['prognosis'] = this.prognosis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prognosis {
  String? prognosis;

  Prognosis({this.prognosis});

  Prognosis.fromJson(Map<String, dynamic> json) {
    prognosis = json['prognosis']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['prognosis'] = this.prognosis;
    return data;
  }
}



// Metabolic Pathway Data Modal




class MetabolicPathwayDataModal {
  String? subHeading;
  List<MetabolicData>? data;

  MetabolicPathwayDataModal({this.subHeading, this.data});

  MetabolicPathwayDataModal.fromJson(Map<String, dynamic> json) {
    subHeading = json['subHeading']??'';
    if (json['data'] != null) {
      data = <MetabolicData>[];
      json['data'].forEach((v) {
        data!.add(MetabolicData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subHeading'] = this.subHeading;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetabolicData {
  String? departmentId;
  String? departmentName;
  List<MetabolicPathway>? metabolicPathway;

  MetabolicData({this.departmentId, this.departmentName, this.metabolicPathway});

  MetabolicData.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId']??'';
    departmentName = json['departmentName']??'';
    if (json['metabolicPathway'] != null) {
      metabolicPathway = <MetabolicPathway>[];
      json['metabolicPathway'].forEach((v) {
        metabolicPathway!.add(MetabolicPathway.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.metabolicPathway != null) {
      data['metabolicPathway'] =
          this.metabolicPathway!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetabolicPathway {
  String? metabolismName;
  String? cycleName;
  String? enzymeName;
  String? metaboliteName;
  String? disorderDescription;
  String? testDetails;
  String? treatmentDetails;
  String? tissue;
  String? biofluids;
  String? cellLocation;
  String? inheretance;
  String? prevalence;
  String? fate;
  String? feeder;

  MetabolicPathway(
      {this.metabolismName,
        this.cycleName,
        this.enzymeName,
        this.metaboliteName,
        this.disorderDescription,
        this.testDetails,
        this.treatmentDetails,
        this.tissue,
        this.biofluids,
        this.cellLocation,
        this.inheretance,
        this.prevalence,
        this.fate,
        this.feeder});

  MetabolicPathway.fromJson(Map<String, dynamic> json) {
    metabolismName = json['metabolismName']??'';
    cycleName = json['cycleName']??'';
    enzymeName = json['enzymeName']??'';
    metaboliteName = json['metaboliteName']??'';
    disorderDescription = json['disorderDescription']??'';
    testDetails = json['testDetails']??'';
    treatmentDetails = json['treatmentDetails']??'';
    tissue = json['tissue']??'';
    biofluids = json['biofluids']??'';
    cellLocation = json['cellLocation']??'';
    inheretance = json['inheretance']??'';
    prevalence = json['prevalence']??'';
    fate = json['fate']??'';
    feeder = json['feeder']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['metabolismName'] = this.metabolismName;
    data['cycleName'] = this.cycleName;
    data['enzymeName'] = this.enzymeName;
    data['metaboliteName'] = this.metaboliteName;
    data['disorderDescription'] = this.disorderDescription;
    data['testDetails'] = this.testDetails;
    data['treatmentDetails'] = this.treatmentDetails;
    data['tissue'] = this.tissue;
    data['biofluids'] = this.biofluids;
    data['cellLocation'] = this.cellLocation;
    data['inheretance'] = this.inheretance;
    data['prevalence'] = this.prevalence;
    data['fate'] = this.fate;
    data['feeder'] = this.feeder;
    return data;
  }
}

















class DiseaseDetailsDataModal {
  String? headingId;
  String? heading;
  dynamic body;
  String? reference;
  String? imagePath;
  List<SubOverview>? subOverview;
  List<TData>? treatment;


  DiseaseDetailsDataModal(
      {this.headingId,
        this.heading,
        this.body,
        this.imagePath,
        this.subOverview,
        this.treatment,
      });

  DiseaseDetailsDataModal.fromJson(Map<String, dynamic> json) {
    headingId = json['headingId']??'';
    heading = json['heading']??'';
    body = json['body'];
    imagePath = json['imagePath']??'';
    if (json['subOverview'] != null) {
      subOverview = <SubOverview>[];
      json['subOverview'].forEach((v) {
        subOverview!.add(SubOverview.fromJson(v));
      });
    }
    if (json['treatment'] != null) {
      treatment = <TData>[];
      json['treatment'].forEach((v) {
        treatment!.add(TData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['headingId'] = this.headingId;
    data['heading'] = this.heading;
    data['body'] = this.body;
    data['imagePath'] = this.imagePath;
    if (this.subOverview != null) {
      data['subOverview'] = this.subOverview!.map((v) => v.toJson()).toList();
    }
    if (this.treatment != null) {
      data['treatment'] = this.treatment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




class SubOverview {
  int? departmentId;
  String? departmentName;
  List<SubOverviewData>? subOverview;

  SubOverview({this.departmentId, this.departmentName, this.subOverview});

  SubOverview.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    departmentName = json['departmentName']??'';
    if (json['subOverview'] != null) {
      subOverview = <SubOverviewData>[];
      json['subOverview'].forEach((v) {
        subOverview!.add(SubOverviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    if (this.subOverview != null) {
      data['subOverview'] = this.subOverview!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubOverviewData {
  String? subOverview;

  SubOverviewData({this.subOverview});

  SubOverviewData.fromJson(Map<String, dynamic> json) {
    subOverview = json['subOverview']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subOverview'] = this.subOverview;
    return data;
  }
}

class TData{
  String? treatmentName;
  String? treatment;

  TData({
    this.treatmentName,
    this.treatment,
});
  TData.fromJson(Map<String, dynamic> json) {
    treatmentName = json['treatmentName']??'';
    treatment = json['treatment']??'';

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['treatmentName'] = this.treatmentName;
    data['treatment'] = this.treatment;
    return data;
  }

}

















// Dosing data Modal

class AdultDoseBody {
  String? doseHeading;
  String? doseSubHeading;
  List<AdultDose>? adultDose;
  List<PediatricDose>? pediatricDose;

  AdultDoseBody(
      {this.doseHeading,
        this.doseSubHeading,
        this.adultDose,
        this.pediatricDose});

  AdultDoseBody.fromJson(Map<String, dynamic> json) {
    doseHeading = json['doseHeading'];
    doseSubHeading = json['doseSubHeading'];
    if (json['adultDose'] != null) {
      adultDose = <AdultDose>[];
      json['adultDose'].forEach((v) {
        adultDose!.add(AdultDose.fromJson(v));
      });
    }

    if (json['pediatricDose'] != null) {
      pediatricDose = <PediatricDose>[];
      json['pediatricDose'].forEach((v) {
        pediatricDose!.add(PediatricDose.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['doseHeading'] = this.doseHeading;
    data['doseSubHeading'] = this.doseSubHeading;
    if (this.adultDose != null) {
      data['adultDose'] = this.adultDose!.map((v) => v.toJson()).toList();
    }
    if (this.pediatricDose != null) {
      data['pediatricDose'] =
          this.pediatricDose!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}




class PediatricDose {
  String? ailment;
  String? route;
  String? dose;
  String? formName;
  String? age;
  String? weight;

  PediatricDose(
      {this.ailment,
        this.route,
        this.dose,
        this.formName,
        this.age,
        this.weight});

  PediatricDose.fromJson(Map json) {
    ailment = json['ailment'];
    route = json['route'];
    dose = json['dose'];
    formName = json['formName'];
    age = json['age'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ailment'] = this.ailment;
    data['route'] = this.route;
    data['dose'] = this.dose;
    data['formName'] = this.formName;
    data['age'] = this.age;
    data['weight'] = this.weight;
    return data;
  }
}

class AdultDose {
  String? ailment;
  String? route;
  String? dose;
  String? formName;
  String? age;
  String? weight;

  AdultDose(
      {this.ailment,
        this.route,
        this.dose,
        this.formName,
        this.age,
        this.weight});

  AdultDose.fromJson(Map<String, dynamic> json) {
    ailment = json['ailment'];
    route = json['route'];
    dose = json['dose'];
    formName = json['formName'];
    age = json['age'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ailment'] = this.ailment;
    data['route'] = this.route;
    data['dose'] = this.dose;
    data['formName'] = this.formName;
    data['age'] = this.age;
    data['weight'] = this.weight;
    return data;
  }
}


// Side Effect Data Modal


// class SideEffectBody {
//   String? sideEffects;
//   int? sideEffectTypeId;
//   String? sideEffectType;
//   String? sideEffectColor;
//   String? isWatchable;
//   String? isLifeThreatening;
//
//   SideEffectBody(
//       {this.sideEffects,
//         this.sideEffectTypeId,
//         this.sideEffectType,
//         this.sideEffectColor,
//         this.isWatchable,
//         this.isLifeThreatening});
//
//   SideEffectBody.fromJson(Map<String, dynamic> json) {
//     sideEffects = json['sideEffects'];
//     sideEffectTypeId = json['sideEffectTypeId'];
//     sideEffectType = json['sideEffectType'];
//     sideEffectColor = json['sideEffectColor'];
//     isWatchable = json['isWatchable'];
//     isLifeThreatening = json['isLifeThreatening'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['sideEffects'] = this.sideEffects;
//     data['sideEffectTypeId'] = this.sideEffectTypeId;
//     data['sideEffectType'] = this.sideEffectType;
//     data['sideEffectColor'] = this.sideEffectColor;
//     data['isWatchable'] = this.isWatchable;
//     data['isLifeThreatening'] = this.isLifeThreatening;
//     return data;
//   }
// }




//Intraction Data Modal



class IntractionDataModal {
  List<InteractionWithMedicine>? interactionWithMedicine;
  List<InteractionWithMedicineGroup>? interactionWithMedicineGroup;
  List<InteractionWithNurient>? interactionWithNurient;
  List? interactionWithAddiquate;
  List? interactionWithProblem;

  IntractionDataModal(
      {this.interactionWithMedicine,
        this.interactionWithMedicineGroup,
        this.interactionWithNurient,
        this.interactionWithAddiquate,
        this.interactionWithProblem});

  IntractionDataModal.fromJson(Map<String, dynamic> json) {
    if (json['interactionWithMedicine'] != null) {
      interactionWithMedicine = <InteractionWithMedicine>[];
      json['interactionWithMedicine'].forEach((v) {
        interactionWithMedicine!.add(InteractionWithMedicine.fromJson(v));
      });
    }
    if (json['interactionWithMedicineGroup'] != null) {
      interactionWithMedicineGroup = <InteractionWithMedicineGroup>[];
      json['interactionWithMedicineGroup'].forEach((v) {
        interactionWithMedicineGroup!
            .add(InteractionWithMedicineGroup.fromJson(v));
      });
    }
    if (json['interactionWithNurient'] != null) {
      interactionWithNurient = <InteractionWithNurient>[];
      json['interactionWithNurient'].forEach((v) {
        interactionWithNurient!.add(InteractionWithNurient.fromJson(v));
      });
    }
    if (json['interactionWithAddiquate'] != null) {
      interactionWithAddiquate = <Null>[];
      json['interactionWithAddiquate'].forEach((v) {
        interactionWithAddiquate!.add(v);
      });
    }
    if (json['interactionWithProblem'] != null) {
      interactionWithProblem = <Null>[];
      json['interactionWithProblem'].forEach((v) {
        interactionWithProblem!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.interactionWithMedicine != null) {
      data['interactionWithMedicine'] =
          this.interactionWithMedicine!.map((v) => v.toJson()).toList();
    }
    if (this.interactionWithMedicineGroup != null) {
      data['interactionWithMedicineGroup'] =
          this.interactionWithMedicineGroup!.map((v) => v.toJson()).toList();
    }
    if (this.interactionWithNurient != null) {
      data['interactionWithNurient'] =
          this.interactionWithNurient!.map((v) => v.toJson()).toList();
    }
    if (this.interactionWithAddiquate != null) {
      data['interactionWithAddiquate'] =
          this.interactionWithAddiquate!.map((v) => v.toJson()).toList();
    }
    if (this.interactionWithProblem != null) {
      data['interactionWithProblem'] =
          this.interactionWithProblem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InteractionWithMedicine {
  String? interactionWithMedicine;
  String? isLifeThreatning;
  String? interactionNature;
  String? interactionEffect;
  String? suggestiveAction;
  String? doseModification;
  int? decreasedFrom;
  int? decreasedTo;

  InteractionWithMedicine(
      {this.interactionWithMedicine,
        this.isLifeThreatning,
        this.interactionNature,
        this.interactionEffect,
        this.suggestiveAction,
        this.doseModification,
        this.decreasedFrom,
        this.decreasedTo});

  InteractionWithMedicine.fromJson(Map<String, dynamic> json) {
    interactionWithMedicine = json['interactionWithMedicine'];
    isLifeThreatning = json['isLifeThreatning'];
    interactionNature = json['interactionNature'];
    interactionEffect = json['interactionEffect'];
    suggestiveAction = json['suggestiveAction'];
    doseModification = json['doseModification'];
    decreasedFrom = json['decreasedFrom'];
    decreasedTo = json['decreasedTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['interactionWithMedicine'] = this.interactionWithMedicine;
    data['isLifeThreatning'] = this.isLifeThreatning;
    data['interactionNature'] = this.interactionNature;
    data['interactionEffect'] = this.interactionEffect;
    data['suggestiveAction'] = this.suggestiveAction;
    data['doseModification'] = this.doseModification;
    data['decreasedFrom'] = this.decreasedFrom;
    data['decreasedTo'] = this.decreasedTo;
    return data;
  }
}

class InteractionWithMedicineGroup {
  String? interactionWithMedicineGroup;
  String? isLifeThreatning;
  String? interactionNature;
  String? interactionEffect;
  String? suggestiveAction;
  String? doseModification;
  int? decreasedFrom;
  int? decreasedTo;

  InteractionWithMedicineGroup(
      {this.interactionWithMedicineGroup,
        this.isLifeThreatning,
        this.interactionNature,
        this.interactionEffect,
        this.suggestiveAction,
        this.doseModification,
        this.decreasedFrom,
        this.decreasedTo});

  InteractionWithMedicineGroup.fromJson(Map<String, dynamic> json) {
    interactionWithMedicineGroup = json['interactionWithMedicineGroup'];
    isLifeThreatning = json['isLifeThreatning'];
    interactionNature = json['interactionNature'];
    interactionEffect = json['interactionEffect'];
    suggestiveAction = json['suggestiveAction'];
    doseModification = json['doseModification'];
    decreasedFrom = json['decreasedFrom'];
    decreasedTo = json['decreasedTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['interactionWithMedicineGroup'] = this.interactionWithMedicineGroup;
    data['isLifeThreatning'] = this.isLifeThreatning;
    data['interactionNature'] = this.interactionNature;
    data['interactionEffect'] = this.interactionEffect;
    data['suggestiveAction'] = this.suggestiveAction;
    data['doseModification'] = this.doseModification;
    data['decreasedFrom'] = this.decreasedFrom;
    data['decreasedTo'] = this.decreasedTo;
    return data;
  }
}

class InteractionWithNurient {
  String? interactionWithNutrient;
  String? isLifeThreatning;
  String? interactionNature;
  String? interactionEffect;
  String? suggestiveAction;
  String? doseModification;
  int? decreasedFrom;
  int? decreasedTo;

  InteractionWithNurient(
      {this.interactionWithNutrient,
        this.isLifeThreatning,
        this.interactionNature,
        this.interactionEffect,
        this.suggestiveAction,
        this.doseModification,
        this.decreasedFrom,
        this.decreasedTo});

  InteractionWithNurient.fromJson(Map<String, dynamic> json) {
    interactionWithNutrient = json['interactionWithNutrient'];
    isLifeThreatning = json['isLifeThreatning'];
    interactionNature = json['interactionNature'];
    interactionEffect = json['interactionEffect'];
    suggestiveAction = json['suggestiveAction'];
    doseModification = json['doseModification'];
    decreasedFrom = json['decreasedFrom'];
    decreasedTo = json['decreasedTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['interactionWithNutrient'] = this.interactionWithNutrient;
    data['isLifeThreatning'] = this.isLifeThreatning;
    data['interactionNature'] = this.interactionNature;
    data['interactionEffect'] = this.interactionEffect;
    data['suggestiveAction'] = this.suggestiveAction;
    data['doseModification'] = this.doseModification;
    data['decreasedFrom'] = this.decreasedFrom;
    data['decreasedTo'] = this.decreasedTo;
    return data;
  }
}



