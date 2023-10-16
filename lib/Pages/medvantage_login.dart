
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedvantageLogin extends ChangeNotifier{

  saveLoginUserData(data)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('DataKey', data);
    checkUser();
}

checkUser()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
 var user=  prefs.getString('DataKey');
 if(user==null||user==''){
   updateLoggedIn=false;
 }else{
   updateLoggedIn=true;
 }
}

bool isLoggedIn=false;
  get getLoggedIn=>isLoggedIn;
  set updateLoggedIn(value){
    isLoggedIn=value;
    notifyListeners();
  }

   logOut()async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.remove('DataKey',);
     checkUser();
  }
}