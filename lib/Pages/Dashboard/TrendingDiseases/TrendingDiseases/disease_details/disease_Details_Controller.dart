import 'package:get/get.dart';
import 'disease_Details_DataModal.dart';

class DiseaseDetailsController extends GetxController{

  List diseaseDetailsList=[];
  List subOverview=[].obs;

  List <DiseaseDetailsDataModal> get getMedicineDetailsList => List <DiseaseDetailsDataModal>.from(
      diseaseDetailsList.map((element) => DiseaseDetailsDataModal.fromJson(element))
  );

  set updateDiseaseDetailsList(List val){
try {
  diseaseDetailsList =val;
  subOverview =val.isEmpty?[]:val[0]['subOverview'];
}
catch(e){

}
    update();
  }



  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  List departmentList=[].obs;
  List get getDepartmentList=>departmentList;
  set updateDepartmentList(List val){
    departmentList=val;
    updateDepartmentID=val.isNotEmpty? val[0]['departmentId']:0;
    print('departmentIddepartmentIddepartmentId'+ val[0].toString());
    update();
  }

  RxInt departmentID=0.obs;
  int? get getDepartmentID=>departmentID.value;
  set updateDepartmentID(int val){
    departmentID.value=val;
    update();
  }

}