import 'package:digi_doctor/Pages/LabTests/Details/DataModal/details_data_modal.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController{


  Map packageDetails={}.obs;
  PackageDetails get getPackageDetails=>PackageDetails.fromJson(packageDetails);

  set updateDetailsData(Map val){
    packageDetails=val;
    update();
  }
}