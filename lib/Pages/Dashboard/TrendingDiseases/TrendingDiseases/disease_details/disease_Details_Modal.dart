
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get.dart';

import '../../trending_disease_controller.dart';
import 'disease_Details_Controller.dart';


class DiseaseDetailsModal{

  DiseaseDetailsController controller=Get.put(DiseaseDetailsController());

  TrendingDiseaseController controller2 =Get.put(TrendingDiseaseController());

  UserData userData=UserData();
  RawData rawData=RawData();

  getDepartmentId(context, String index) async {

    var body={
      "problemId":index,
      "userId":userData.getUserMemberId,
    };
    var data=await rawData.api('diseaseDepartmentList', body, context,token: true,isNewBaseUrl: true,newBaseUrl:"http://182.156.200.179:332/api/v1.0/Knowmed/" );
    if(data['responseCode']==1){
      controller.updateDepartmentList=data['responseValue'];
    }else{
      alertToast(context, data['responseMessage']);
    }
  }

  diseaseDetails(context, String index)async{
    controller.updateShowNoData=false;
    var body={
      "userId":UserData().getUserMemberId.toString(),
      "departmentId":controller.getDepartmentID.toString(),
      "problemId":index,
      //"departmentId":"15",

    };
    var data=await rawData.api('diseaseReport', body, context,token: true,isNewBaseUrl: true,newBaseUrl:"http://182.156.200.179:332/api/v1.0/Knowmed/");
    controller.updateShowNoData=true;
    if(data['responseCode']==1){
      controller.updateDiseaseDetailsList=data['responseValue'];
    }else{
      alertToast(context, data['responseMessage']);
    }
  }






}