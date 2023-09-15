

import 'package:digi_doctor/Pages/LabTests/AllPackages/DataModal/all_packages_data_modal.dart';
import 'package:get/get.dart';

class AllPackagesController extends GetxController{
  List allPackages=[].obs;

  List<AllPackageDataModal> get getAllPackages=>List<AllPackageDataModal>.from(
      allPackages.map((e) => AllPackageDataModal.fromJson(e))
  );


  set updateAllPackages(List val){
    allPackages=val[0]['packageDetails'];
    //  popularPackage=val[0]['popularpackage'];
    update();
  }

  RxInt pathalogyId=0.obs;
  int get getPathalogyId=>pathalogyId.value;
  set updatePathalogyId(int val) {
    pathalogyId.value = val;
    update();
  }

  RxInt packageId=0.obs;
  int get getPackageId=>pathalogyId.value;
  set updatePackageId(int val) {
    packageId.value = val;
    update();
  }


}