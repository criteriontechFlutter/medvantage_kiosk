
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class UserData extends GetxController {
  final userData = GetStorage('user');


  // final userProfileData = GetStorage('profile');
  // Map<String, dynamic> get getUserProfileData => userProfileData.read('userProfileData') ?? {};


  String get getUserToken => (userData.read('userToken')) ?? '';
  Map<String, dynamic> get getUserData => userData.read('userData') ?? {};

  String get getUserName =>(userData.read("userName"))??'';
  String get getListneUrl =>(userData.read("listenurl"))??'';

  // String get getUserTypeString =>  userData.read('userType');
  // UserType get getUser Type =>  userData.read('userType')!=""? (
  //     userData.read('userType').toString()=="UserType.ambulance"? UserType.ambulance:
  //     userData.read('userType').toString()=="UserType.doctor"? UserType.doctor:
  //     userData.read('userType').toString()=="UserType.clinic"? UserType.clinic:
  //     UserType.ambulance
  // ):  UserType.ambulance;



  // user data
  // String get getStudentId => getUserData.isNotEmpty ? getUserData['Student_Id'].toString():'';
  // String get getStudentDevId => getUserData.isNotEmpty ? getUserData['Student_Dev_Id'].toString():'';
  // String get getStudentName => getUserData.isNotEmpty ? getUserData['Student_Name'].toString():'';
  // String get getRollNo => getUserData.isNotEmpty ? getUserData['Roll_No'].toString():'';
  // String get getClassGroupId => getUserData.isNotEmpty ? getUserData['Class_Group_Id'].toString():'';
  // String get getCourseId => getUserData.isNotEmpty ? getUserData['Courseid'].toString():'';
  // String get getInstitutionId => getUserData.isNotEmpty ? getUserData['institutionid'].toString():'';
  // String get getInstitution => getUserData.isNotEmpty ? getUserData['institution'].toString():'';
  // String get getMobileNumber => getUserData.isNotEmpty ? getUserData['Mo_No'].toString():'';
  // String get getMobileNumberSelf => getUserData.isNotEmpty ? getUserData['Mo_No_Self'].toString():'';
  // String get getPassword => getUserData.isNotEmpty ? getUserData['Password'].toString():'';
  // String get getStatus => getUserData.isNotEmpty ? getUserData['status'].toString():'';
  // String get getSemId => getUserData.isNotEmpty ? getUserData['semid'].toString():'';

  //List get getDoctorTimeDetails=> getUserData.isNotEmpty ? jsonDecode(getUserData['timeDetails'].toString()):[];
  //List get getDoctorClinicDetails => getUserData.isNotEmpty?jsonDecode(getUserData['clinicDetails'].toString()):[];


  //String get getDoctorUpdatedProfilePhoto => getUserProfileData.isNotEmpty ? getUserProfileData['filePath'].toString():'';









  addToken(String val) async{
    await userData.write('userToken', val);
    update();
  }

  addUserData(Map val) async {
    await userData.write('userData', val);
    update();
  }

  addUserName(String username) async{
   await userData.write('userName', username);
    update();
  }

  addListenUrl(String url) async {
    await userData.write('listenurl', url);
    update();
  }


  addHeadAssigned(List val) async {
    await userData.write('headAssigned', val);
    update();
  }

  // set updateUserType(UserType val) {
  //    userData.write('userType', val.toString());
  //   update();
  // }

  removeUserData() async{
    await userData.remove('userData');
    await userData.remove('userToken');
    await userData.remove('headAssigned');
    update();
  }


  // Map<String, dynamic> get getSignUpData => userData.read('signUp') ?? {};
  // addSignUpData(Map val)async{
  //   userData.write('signUp', val);
  // }
  // addUserProfileData(Map val) async {
  //   await userProfileData.write('userProfileData', val);
  //   update();
  // }


}




