

import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/Pages/LabTests/Details/details_controller.dart';
import 'package:get/get.dart';

class DetailsModal{
  DetailsController controller=Get.put(DetailsController());
  Future details(context)async{
    var body=
    {"packageId": "1".toString(),
      //":UserData().getUserMemberId.toString()}
    }
    ;
    var data=await RawData().api("Lab/getPackageDetails", body, context,token: true);
    if(data['responseCode']==1){

      controller.updateDetailsData=data['responseValue'][0]['packageDetails'][0];
    }


    // log(data);
  }
}