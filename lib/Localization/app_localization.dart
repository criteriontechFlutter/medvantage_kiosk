import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_class.dart';



class ApplicationLocalizations  extends ChangeNotifier {
  Language? language;
  Lang? localeData;

  ApplicationLocalizations(
      {
        this.language,
        this.localeData,
      });



  Language get getLanguage=>language??Language.english;
  Lang get getLocaleData=>localeData??Lang();




  static Future<Language> fetchLanguage() async{
    final prefs = await SharedPreferences.getInstance();
    return Language.values.byName(prefs.getString("language")??'english');

  }

  void updateLanguage(Language val) async{
    String localeData=val.name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language",localeData);
    language=await fetchLanguage();
    load(getLanguage);
    notifyListeners();
  }



  static Future<Lang> fetchLocaleData() async{
    final prefs = await SharedPreferences.getInstance();
    return Lang.fromJson(jsonDecode(prefs.getString("localeData")??'{}'));

  }

  void updateLocaleData(Lang val) async{
    print("herrerewewr${val.toJson()}");
    String localeD=jsonEncode(
        val.toJson()
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("localeData",localeD);
    localeData=await fetchLocaleData();

    notifyListeners();
  }


  Future<Lang> load(Language lang) async {
    String data = await rootBundle.loadString(getDataPathFromLanguage(lang));
    final jsonResult = json.decode(data);
    Lang localizedStrings = Lang.fromJson(jsonResult);
    //  var localizedStrings = jsonResult.map((key, value) => MapEntry(key, value.toString()));
    updateLocaleData(localizedStrings);
    return localizedStrings;
  }



// String? translate(String jsonkey) {
//   return localizedStrings[jsonkey];
// }

//**

  List<Language> listOfLanguages=[
  Language.english,
  Language.hindi,
  Language.urdu,
  Language.bengali,
  Language.marathi,
  Language.arabic
];


}


String getLanguageInRealLanguage(Language lang){
  print("LogoFaheem$lang");
  switch(lang){
    case Language.english:  return "English"+' ( '+"इंग्लिश"+' )';
    case Language.hindi:  return "Hindi"+' ( '+"हिन्दी"+' )';
    case Language.urdu:  return "Urdu"+' ( '+"اردو"+' )';
    case Language.bengali:  return "Bengali"+' ( '+"বাংলা"+' )';
    case Language.marathi:  return "Marathi"+' ( '+"मराठी"+' )';
    case Language.arabic:  return "Arabic"+' ( '+"عربى"+' )';

  }
}

String getLanguageInRealLanguageForChange(String lang){
  print("objectAni"+lang.toString());
  String value="";
  switch(lang){
    case "Language.english":
      value= "English"+' ( '+"इंग्लिश"+' )';
      break;
    case "Language.hindi":
      value= "Hindi"+' ( '+"हिन्दी"+' )';
      break;
    case "Language.urdu":
      value= "Urdu"+' ( '+"اردو"+' )';
      break;
    case "Language.bengali":
      value= "Bengali"+' ( '+"বাংলা"+' )';
      break;
    case "Language.marathi":
      value= "Marathi"+' ( '+"मराठी"+' )';
      break;
    case "Language.arabic":
      value= "arabic"+' ( '+"عربى"+' )';
  }
  print("objectAniemsh"+value.toString());
  return value;
}



String getDataPathFromLanguage(Language lang){
  String fullPath= "assets/language/${lang.name}.json";
  return fullPath;
}

enum Language{
  english,
  hindi,
  urdu,
  bengali,
  marathi,
  arabic
}





