
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Localization/app_localization.dart';
import 'DataModal/hospital_data_modal.dart';

class HospitalController extends GetxController{

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();

  }



  List getHomeGrid(context){

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return [

      {
        'tittle' : localization.getLocaleData.findDoctorsBy.toString(),
        'sub_tittle' : localization.getLocaleData.doctors.toString(),
        'image': 'assets/doctor_home.png',
        'color':AppColor.primaryColor,


      },
      {
        'tittle' : localization.getLocaleData.findDoctorsBy.toString(),
        'sub_tittle' : localization.getLocaleData.services.toString(),
        'image': 'assets/cough_home.png',
        'color':AppColor.randomShades2,

      },
      {
        'tittle' : localization.getLocaleData.lab.toString(),
        'sub_tittle' : localization.getLocaleData.speciality.toString(),
        'image': 'assets/flask_home.png',
        'color':AppColor.darkOrange,


      },
      {
        'tittle' : localization.getLocaleData.digi.toString(),
        'sub_tittle' : localization.getLocaleData.reviews.toString(),
        'image': 'assets/medicine_home.png',
        'color':AppColor.buttonColor,


      }
    ];
  }

  RxInt homeGridIndex=0.obs;
  int get getHomeGridIndex=>homeGridIndex.value;
  set updateHomeGridIndex(int val) {
    homeGridIndex.value = val;
    update();

  }


  RxInt hospitalId=0.obs;
  int get getHospitalId=>hospitalId.value;
  set updateHospitalId(int val) {
    hospitalId.value = val;
    update();

  }


  List doctorList = [].obs;
  List specialityList=[].obs;
  List clinicDetails=[].obs;

  List<DoctorListModal> get getDoctorList=>List<DoctorListModal>.from(
      doctorList.map((element) => DoctorListModal.fromJson(element))
  );
  List<SpecialityListDataModal> get getSpecialityList=>List<SpecialityListDataModal>.from(
      specialityList.map((element) => SpecialityListDataModal.fromJson(element))
  );
  List<ClinicDetailsDataModal> get getClinicDetails=>List<ClinicDetailsDataModal>.from(
      clinicDetails.map((element)=>ClinicDetailsDataModal.fromJson(element))
  );

  set updateDoctorList(List val){
    doctorList=val[0]['doctorList'];
    specialityList=val[0]['specialityList'];
    clinicDetails=val[0]['clinicDetails'];
    update();
  }

// List<ClinicDetailsModal> get getSpecialityList=>List<ClinicDetailsModal>.from(
// specialityList.map((element) => ClinicDetailsModal.fromJson(element))
// );
// set updateSpecialityList(List val){
//   specialityList=val;
//   update();
// }


  // RxString location = ''.obs;
  //
  //   get getLocation => location.isEmpty?'Unknown,Location':location;
  //
  //   set updateLocation(String val){
  //     location.value = val;
  //     update();
  //   }


RxString docList='Doctors'.obs;
 String get getDocList=>docList.value;
  set updateDocList(String val){
    docList.value=val;
    update();
  }

}