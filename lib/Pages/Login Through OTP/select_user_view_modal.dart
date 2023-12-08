
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'data modal/user_data_modal.dart';

class SelectUserViewModal extends ChangeNotifier{
  String name ='';
  get getName => name;
  set updateName(val){
    name=val;
    notifyListeners();
  }

  onChangeUser(UsersDataModal user){
    final medvantageUser = GetStorage();
    medvantageUser.write('medvantageUserName', user.patientName.toString());
    medvantageUser.write('medvantageUserNumber', user.mobileNo.toString());
    medvantageUser.write('medvantageUserUHID', user.uhID.toString());
    medvantageUser.write('medvantageUserAge', user.age.toString());
    medvantageUser.write('medvantageUserGender', user.gender.toString());


    updateName = medvantageUser.read('medvantageUserName');
    var B = medvantageUser.read('medvantageUserUHID');
    print('${getName}data123');
    print('${B}data123');
  }

}