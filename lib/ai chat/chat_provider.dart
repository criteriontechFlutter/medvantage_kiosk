
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Localization/app_localization.dart';

class ChatProvider extends ChangeNotifier{
  ScrollController ctr = ScrollController();

  TextEditingController chatTextC= TextEditingController();
  void _scrollDown() {
    ctr.animateTo(
      ctr.position.maxScrollExtent+150,
      duration: const Duration(milliseconds: 400),
      curve: Curves.bounceIn,
    );
  }

  List<Chat> students = [

  ];


  List suggestions=[
    'where is blood bank?',
    'where is reception?',
    'what are OPD timings?',
  ];

  Future<void>   chatData(context,String? text,bool? pop)async {
    print('11111111111111111111');



    // if (chatTextC.value.text.toString() == '') {
    // } else {
    students.add(Chat(message: text ?? '', isAi: false));
    chatTextC.clear();
    var body = {};

    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    var code = 'en';
    if(localization.getLanguage.toString()=='Language.english'){
      print('english');
      code = 'en';
    }else if(localization.getLanguage.toString()=='Language.hindi'){
      print('hindi');
      code = 'hi';
    }else if(localization.getLanguage.toString()=='Language.urdu'){
      print('urdu');
      code = 'ur-IN';
    }else if(localization.getLanguage.toString()=='Language.bengali'){
      print('bengali');
      code = 'bn-IN';
    }else if(localization.getLanguage.toString()=='Language.marathi'){
      print('marathi');
      code = 'mr-IN';
    }else if(localization.getLanguage.toString()=='Language.arabic'){
      print('arabic');
      code = 'ar-SA';
    }else{
      code = 'en-IN';
    }
    var data = await RawData().api('?getinfoText=$text&languageCode=$code', body,
        context, isNewBaseUrl: true,
        newBaseUrl: 'http://172.16.19.162:8000/knoemedGPT/getinfo/v1/',
        token: true);
    var recievedText = data['getinfoResponse'];
    students.add(Chat(message: recievedText ?? '', isAi: true));
    if (kDebugMode) {
      print(data.toString());
    }
    notifyListeners();
    var studentsmap = students.map((e) {
      return {
        "message": e.message,
        "isAi": e.isAi
      };
    }).toList();
    print(studentsmap);
    if(pop==true){
      Navigator.pop(context);
    }
    _scrollDown();
  }
}




class Chat{
  bool isAi;
  String message;

  Chat({
    required this.isAi,
    required this.message,
  });
}