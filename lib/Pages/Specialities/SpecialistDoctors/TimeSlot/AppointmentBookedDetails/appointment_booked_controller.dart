import 'package:get/get.dart';

class AppointmentBookedController extends GetxController{

  bool _isVitalSend = false;
  get getIsVitalSend => _isVitalSend;
  set updateIsVitalSend(bool val){
    _isVitalSend = val;
    update();
  }

  List addDocumentList=[];
  get getAddDocumentList=>addDocumentList;
  addDocumentInList( val,docType){
    addDocumentList.add({'docFile':val, 'img':docType});
    print('MyyyyyyyyyyyyyyyyyyyyyyyyList'
        +addDocumentList.toString());
    update();
  }

}