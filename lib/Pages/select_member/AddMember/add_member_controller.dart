




import '../../../Localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddMemberController extends GetxController{
 var file=''.obs;
  final formKey=GlobalKey<FormState>().obs;
  Rx<TextEditingController> nameController=TextEditingController().obs;
  Rx<TextEditingController> mobileController=TextEditingController().obs;
  Rx<TextEditingController> addressController=TextEditingController().obs;
  Rx<TextEditingController> genderController=TextEditingController().obs;
  Rx<TextEditingController> dateController=TextEditingController().obs;
  Rx<TextEditingController> emailController=TextEditingController().obs;




  String profilePhotoPath='';
  get getProfilePhotoPath=>profilePhotoPath;
  set updateProfilePhotoPath(String val){
    profilePhotoPath=val;
    update();
  }

  RxInt genderId=0.obs;
  int get getGenderId=>genderId.value;
  set updateGenderId(int val) {
    genderId.value = val;
    update();

  }
  getGender(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return [
      {
        'id':1,
        'gender':localization.getLocaleData.male.toString()
      },

      {
        'id':2,
        'gender':localization.getLocaleData.female.toString()
      }
    ];
  }

}