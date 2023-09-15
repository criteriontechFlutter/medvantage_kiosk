
import 'package:digi_doctor/services/firebase_service/fireBaseService.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
// import 'package:his/Modal/assigned_head.dart';



class UserData extends GetxController {
  final userData = GetStorage('user');




  String get getUserToken => (userData.read('userToken')) ?? '';
  bool get getAdmitted => (userData.read('admitted')) ?? false;
  String get getUserLocation => (userData.read('location')) ?? 'Unknown,Location';
  Map<String, dynamic> get getUserData => userData.read('userData') ?? {};
  // List<AssignedHead> get getHeadAssigned => (
  //     userData.read('headAssigned')==null?
  //         []:
  //     List<AssignedHead>.from(
  //         userData.read('headAssigned').map((element) => AssignedHead.fromJson(element))
  //     )
  // );


  String get getUserId => getUserData.isNotEmpty ? getUserData['id'].toString():'';
  String get getUserLoginId => getUserData.isNotEmpty ? getUserData['userLoginId'].toString():'';
  String get getUserName => getUserData.isNotEmpty ? getUserData['name'].toString():'';
  String get getUserMobileNo => getUserData.isNotEmpty ? getUserData['mobileNo'].toString():'';
  String get getUserEmailId => getUserData.isNotEmpty ? getUserData['emailId'].toString():'';
  String get getUserServiceProviderType => getUserData.isNotEmpty ? getUserData['serviceProviderType'].toString():'';
  String get getUserProfilePhotoPath => getUserData.isNotEmpty ? getUserData['profilePhotoPath']??''.toString():'';
  String get getUserPrimaryStatus => getUserData.isNotEmpty ? getUserData['primaryStatus'].toString():'';
  String get getUserCountryId => getUserData.isNotEmpty ? getUserData['countryId'].toString():'';
  String get getUserStateId => getUserData.isNotEmpty ? getUserData['stateId'].toString():'';
  String get getUserDistrictId => getUserData.isNotEmpty ? getUserData['districtId'].toString():'';
  String get getUserCountryName => getUserData.isNotEmpty ? getUserData['countryName'].toString():'';
  String get getUserStateName => getUserData.isNotEmpty ? getUserData['stateName'].toString():'';
  String get getUserCityName => getUserData.isNotEmpty ? getUserData['cityName'].toString():'';
  String get getUserPinCode => getUserData.isNotEmpty ? getUserData['pinCode'].toString():'';
  String get getUserAddress => getUserData.isNotEmpty ? getUserData['address'].toString():'';
  String get getUserIsEraUser => getUserData.isNotEmpty ? getUserData['isEraUser'].toString():'';
  String get getUserCountryCallingCode => getUserData.isNotEmpty ? getUserData['countryCallingCode'].toString():'';
  String get getUserClinicDetails => getUserData.isNotEmpty ? getUserData['clinicDetails'].toString():'';
  String get getUserDoctorsCount => getUserData.isNotEmpty ? getUserData['doctorsCount'].toString():'';
  String get getUserIsCovid => getUserData.isNotEmpty ? getUserData['isCovid'].toString():'';
  String get getUserGender => getUserData.isNotEmpty ? getUserData['gender'].toString():'';
  String get getUserDob => getUserData.isNotEmpty ? getUserData['dob'].toString():'';
  String get getUserIsExists => getUserData.isNotEmpty ? getUserData['isExists'].toString():'';
  String get getUserUniqueNo => getUserData.isNotEmpty ? getUserData['uniqueNo'].toString():'';
  String get getUserServiceProviderTypeId => getUserData.isNotEmpty ? getUserData['serviceProviderTypeId'].toString():'';
  String get getUserIsProfileCompleted => getUserData.isNotEmpty ? getUserData['isProfileCompleted'].toString():'';
  String get getUserClinicName => getUserData.isNotEmpty ? getUserData['clinicName'].toString():'';
  String get getUserRegistrationNo => getUserData.isNotEmpty ? getUserData['registrationNo'].toString():'';
  String get getUserWorkDescription => getUserData.isNotEmpty ? getUserData['workDescription'].toString():'';
  String get getUserFollowUpDuration => getUserData.isNotEmpty ? getUserData['followUpDuration'].toString():'';
  String get getUserCartItems => getUserData.isNotEmpty ? getUserData['cartItems'].toString():'';
  String get getUserPid => getUserData.isNotEmpty ? getUserData['pid'].toString():'';
  String get getUserMemberId => getUserData.isNotEmpty ? getUserData['memberId'].toString():'';
  int get getGardianRelationId =>  int.parse((getUserData.isNotEmpty ?getUserData['gardianRelationId']??0:0).toString());
  String get getGardianName => getUserData.isNotEmpty ? getUserData['gardianName'].toString():'';
  String get getHeight => getUserData.isNotEmpty ? getUserData['height'].toString():'';
  String get getWeight => getUserData.isNotEmpty ? getUserData['weight'].toString():'';
  int get getIsPrivate => int.parse((getUserData.isNotEmpty ? getUserData['isPrivate'].toString():0).toString());
  String get getLang =>  (userData.read('lang')) ?? 'English';


  addToken(String val) async{
    await userData.write('userToken', val);
    update();
  }

  addUserData(Map val) async {
    await userData.write('userData', val);
    update();
  }


  addLocation(String val) async {
    await userData.write('location', val);
    update();
  }
  addAdmittedData(bool val) async {
    await userData.write('admitted', val);
    update();
  }

  addLanguage(String val) async {
    await userData.write("lang", val);
  }

  removeUserData() async{
    await userData.remove('userData');
    await userData.remove('userToken');
    await userData.remove('location');
    await FireBaseService().deleteToken();
  }

  removeAdmittedData() async{
    await userData.remove('admitted');
  }





}


