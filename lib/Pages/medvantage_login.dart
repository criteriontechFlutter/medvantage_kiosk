
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppManager/app_color.dart';
import '../Localization/app_localization.dart';

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

   logOut(context)async{
    print('asdfghjkl');
     ApplicationLocalizations localization =
     Provider.of<ApplicationLocalizations>(context, listen: false);
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.remove('DataKey');
     checkUser();
     final snackBar = SnackBar(
       duration: const Duration(seconds: 10),
       backgroundColor:AppColor.green,
       content:   Text(localization.getLocaleData.loggedOutSuccessfully.toString()),
       action: SnackBarAction(
         textColor: Colors.white,
         label: 'Ok',
         onPressed: () {
         },
       ),
     );
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}