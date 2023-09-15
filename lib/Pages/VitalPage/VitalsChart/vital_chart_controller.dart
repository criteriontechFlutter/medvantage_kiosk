
import 'package:get/get.dart';

import '../DataModal/vital_history_data_model.dart';




class VitalChartController extends GetxController{

  List data= [].obs;
  List vitalList = [].obs;

  List<VitalDataModel> get getVitalData => List<VitalDataModel>.from(
      data.map((element) => VitalDataModel.fromJson(element))
  );

  List<VitalChartData> get getChartData => List<VitalChartData>.from(
      vitalList.map((element) => VitalChartData.fromJson(element))
  );


//filter list for Diastolic data
  List<VitalChartData>  get getDiastolic=>List<VitalChartData>.from(
      (
          vitalList.where(( element) => element['vitalName']=='Dias').toList()
      )
          .map((element) => VitalChartData.fromJson(element))
  );

  //filter list for Systolic data
  List<VitalChartData>  get getSystolic=>List<VitalChartData>.from(
      (
          vitalList.where(( element) => element['vitalName']=='Sys').toList()
      )
          .map((element) => VitalChartData.fromJson(element))
  );

  //filter list for BP data
  List<VitalChartData>  get getBp=>List<VitalChartData>.from(
      (
          vitalList.where(( element) => element['vitalName']=='BP').toList()
      )
          .map((element) => VitalChartData.fromJson(element))
  );




  set updateVitalData(List val){
    vitalList.clear();
    data = val;
    for(int i=0;i<getVitalData.length;i++){

      for(int j=0;j<getVitalData[i].vitalDetails!.length;j++){
        vitalList.add({
          'vitalDate': getVitalData[i].vitalDate,
          'vitalDateForGraph':getVitalData[i].vitalDateForGraph,
          'vitalName':getVitalData[i].vitalDetails![j].vitalName,
          'vitalValue':getVitalData[i].vitalDetails![j].vitalValue,
        });
      }
    }
    update();
  }
Map selectVitals = {}.obs;

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);

  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

}