
class NLP_data_modal {
  Disease? disease;
  String? conFun;
  HtoHindi? htoHindi;
  HtoHindi? htoEnglish;

  NLP_data_modal({this.disease, this.conFun, this.htoHindi, this.htoEnglish});

  NLP_data_modal.fromJson(Map json) {
    disease =
    json['disease'] != null ? Disease.fromJson(json['disease']) : null;
    //conFun = json['conFun'];
    htoHindi = json['htoHindi'] != null
        ? HtoHindi.fromJson(json['htoHindi'])
        : null;
    htoEnglish = json['htoEnglish'] != null
        ? HtoHindi.fromJson(json['htoEnglish'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (disease != null) {
      data['disease'] = disease!.toJson();
    }
    data['conFun'] = conFun;
    if (htoHindi != null) {
      data['htoHindi'] = htoHindi!.toJson();
    }
    if (htoEnglish != null) {
      data['htoEnglish'] = htoEnglish!.toJson();
    }
    return data;
  }
}

class Disease {
  List<FinalDiseaseList>? finalDiseaseList;
  List<Null>? bodyOrgan;
  List<DMW>? dMW;
  List<Mg>? mg;
  List<Condition>? condition;
  List<Portion>? portion;

  Disease(
      {this.finalDiseaseList,
        this.bodyOrgan,
        this.dMW,
        this.mg,
        this.condition,
        this.portion});

  Disease.fromJson(Map<String, dynamic> json) {
    if (json['finalDiseaseList'] != null ||json['finalDiseaseList'].toString().isNotEmpty) {
      finalDiseaseList = <FinalDiseaseList>[];
      json['finalDiseaseList'].forEach((v) {
        finalDiseaseList!.add(FinalDiseaseList.fromJson(v));
      });
    }
    // if (json['bodyOrgan'] != null) {
    //   bodyOrgan = <Null>[];
    //   json['bodyOrgan'].forEach((v) {
    //     bodyOrgan!.add(Null.fromJson(v));
    //   });
    // }
    if (json['dMW'] != null) {
      dMW = <DMW>[];
      json['dMW'].forEach((v) {
        dMW!.add(DMW.fromJson(v));
      });
    }
    // if (json['mg'] != null) {
    //   mg = <Mg>[];
    //   json['mg'].forEach((v) {
    //     mg!.add(Mg.fromJson(v));
    //   });
    // }
    // if (json['condition'] != null) {
    //   condition = <Condition>[];
    //   json['condition'].forEach((v) {
    //     condition!.add(Condition.fromJson(v));
    //   });
    // }
    // if (json['portion'] != null) {
    //   portion = <Portion>[];
    //   json['portion'].forEach((v) {
    //     portion!.add(Portion.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (finalDiseaseList != null) {
      data['finalDiseaseList'] =
          finalDiseaseList!.map((v) => v.toJson()).toList();
    }
    // if (bodyOrgan != null) {
    //   data['bodyOrgan'] = bodyOrgan!.map((v) => v.toJson()).toList();
    // }
    if (dMW != null) {
      data['dMW'] = dMW!.map((v) => v.toJson()).toList();
    }
    // if (mg != null) {
    //   data['mg'] = mg!.map((v) => v.toJson()).toList();
    // }
    // if (condition != null) {
    //   data['condition'] = condition!.map((v) => v.toJson()).toList();
    // }
    // if (portion != null) {
    //   data['portion'] = portion!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class FinalDiseaseList {
  int? id;
  String? problemNames;

  FinalDiseaseList({this.id, this.problemNames});

  FinalDiseaseList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    problemNames = json['problemNames'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['problemNames'] = problemNames;
    return data;
  }
}

class DMW {
  int? days;

  DMW({this.days});

  DMW.fromJson(Map<String, dynamic> json) {
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['days'] = days;
    return data;
  }
}

class Mg {
  // List<Null>? mgValue;
  //
  // Mg({this.mgValue});
  //
  // Mg.fromJson(Map<String, dynamic> json) {
  //   if (json['mgValue'] != null) {
  //     mgValue = <Null>[];
  //     json['mgValue'].forEach((v) {
  //       mgValue!.add(new Null.fromJson(v));
  //     });
  //   }
  // }


}

class Condition {
  // List<Null>? condValue;
  //
  // Condition({this.condValue});
  //
  // Condition.fromJson(Map<String, dynamic> json) {
  //   if (json['condValue'] != null) {
  //     condValue = <Null>[];
  //     json['condValue'].forEach((v) {
  //       condValue!.add(new Null.fromJson(v));
  //     });
  //   }
  // }


}

class Portion {
  // List<Null>? portValue;
  //
  // Portion({this.portValue});
  //
  // Portion.fromJson(Map<String, dynamic> json) {
  //   if (json['portValue'] != null) {
  //     portValue = <Null>[];
  //     json['portValue'].forEach((v) {
  //       portValue!.add(new Null.fromJson(v));
  //     });
  //   }
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.portValue != null) {
  //     data['portValue'] = this.portValue!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class HtoHindi {
  Data? data;

  HtoHindi({this.data});

  HtoHindi.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Translations>? translations;

  Data({this.translations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  String? translatedText;

  Translations({this.translatedText});

  Translations.fromJson(Map<String, dynamic> json) {
    translatedText = json['translatedText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['translatedText'] = translatedText;
    return data;
  }
}
