
import 'package:digi_doctor/Pages/Login%20Through%20OTP/data%20modal/user_data_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpLoginController extends GetxController {

  Rx<TextEditingController> phoneNumberC = TextEditingController().obs;
  Rx<TextEditingController> otpC = TextEditingController().obs;


  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> guardianC = TextEditingController().obs;
  Rx<TextEditingController> idC = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> yearController = TextEditingController().obs;
  Rx<TextEditingController> idController = TextEditingController().obs;/// new
  Rx<TextEditingController> stateController = TextEditingController().obs;/// new
  Rx<TextEditingController> districtController = TextEditingController().obs;/// new
  Rx<TextEditingController> addressController = TextEditingController().obs;/// new
  Rx<TextEditingController> genderController = TextEditingController().obs;
  Rx<TextEditingController> dobUnitId = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirth = TextEditingController().obs;
  Rx<TextEditingController> addrsController = TextEditingController().obs;
  Rx<TextEditingController> selectedGenderC = TextEditingController().obs;
  Rx<TextEditingController> passwordC = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordC = TextEditingController().obs;
  Rx<TextEditingController> heightC = TextEditingController().obs;
  Rx<TextEditingController> weightC = TextEditingController().obs;

  String otpval='';
  get getOtpval=> otpval;
  set updateOtpVal(val){
    otpval=val;
    update();
  }

  final formKeyOtp = GlobalKey<FormState>().obs;

  List gender = [
    {
      'gen' : 'Male' ,
      'id' : '1'
    },
    {
      'gen' : 'Female',
      'id' : '2'
    },
  ];
  List dobType  =[
    {
      "id":1,
      "name":"Year"
    },
    {
      "id":2,
      "name":"Month"
    },
    {
      "id":3,
      "name":"Day"
    },
  ];

  List identity = [
    {
      'id':'1',
      'name':'Passport'
    },
    {
      'id':'2',
      'name':'Adhar card'
    },
    {
      'id':'3',
      'name':'Pan card'
    },
    {
      'id':'4',
      'name':'Voter Id'
    },
  ];

  String identityId='';
  String get getIdentityId=>identityId;
  set updateIdentityId(String val){
    identityId = val;
    update();
  }

  List<UsersDataModal> usersList=[];
  List<UsersDataModal> get  getUsersList => usersList;
  set updateUsersList(List<UsersDataModal> val) {
    usersList = val;
    update();
  }



  List countryList =[];
  get getCountry => countryList;
  set updateCountry(List val){
    countryList=val;
    update();
  }


  List stateList =[];
  get getStateList => stateList;
  set updateState(List val){
    stateList=val;
    update();
  }

  int stateId =0;
  get getStateId => stateId;
  set updateStateId(int val){
    stateId=val;
    update();
  }



  List cityList =[];
  get getCityList => cityList;
  set updateCity(List val){
    cityList=val;
    update();
  }

  int cityId =0;
  get getCityId => cityId;
  set updateCityId(int val){
    cityId=val;
    update();
  }

  bool isChecked = false;
  get getIsChecked=>isChecked;
  set updateIsChecked(val){
    isChecked=val;
    update();
  }




}