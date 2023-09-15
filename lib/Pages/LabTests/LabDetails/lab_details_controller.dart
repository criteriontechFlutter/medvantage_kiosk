


import 'package:get/get.dart';

import 'DataModal/lab_details_data_modal.dart';
import 'DataModal/lab_review_data_modal.dart';
import 'DataModal/popular_package_data_modal.dart';
import 'DataModal/popular_test_data_modal.dart';

class LabDetailsController extends GetxController{
  RxBool showNoTopData=false.obs;
  bool get getShowNoTopData=>(showNoTopData.value);
  set updateShowNoTopData(bool val){
    showNoTopData.value=val;
    update();
  }

 // RxInt pathologyId=0.obs;
 //  int get getPathologyId=>pathologyId.value;
 //  set updatePathologyId(int val){
 //    pathologyId.value=val;
 //    update();
 //  }
  RxInt pathalogyId=0.obs;
  int get getPathalogyId=>pathalogyId.value;
  set updatePathalogyId(int val) {
    pathalogyId.value = val;
    update();
  }

  RxInt packageId=0.obs;
  int get getPackageId=>packageId.value;
  set updatePackageId(int val) {
    packageId.value = val;
    update();
  }


List labDetails=[].obs;
  List<LabDetailsDataModal> get getLabDetails=>List<LabDetailsDataModal>.from(
      labDetails.map((e) =>LabDetailsDataModal.fromJson(e) )
  );


  List popularTest=[].obs;
  List<PopularTestDataModal>get getPopularTest=>List<PopularTestDataModal>.from(
      popularTest.map((e) => PopularTestDataModal.fromJson(e))
  );

  List popularPackage=[].obs;
  List<PopularPackageDataModal>get getPopularPackage=>List<PopularPackageDataModal>.from(
      popularPackage.map((e) => PopularPackageDataModal.fromJson(e))
  );

  List labReview=[].obs;
  List<LabReviewDataModal>get getLabReview=>List<LabReviewDataModal>.from(
      labReview.map((e) => LabReviewDataModal.fromJson(e))
  );
  set updatePackageAndTestLabWise(List val){
    labDetails=val[0]['labDetails'];
    popularTest=val[0]['popularTest'];
    popularPackage=val[0]['popularpackage'];
    labReview=val[0]['labReview'];
    update();

  }



}