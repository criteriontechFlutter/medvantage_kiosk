



import 'package:flutter_oximeter/flutter_oximeter.dart';
import 'package:get/get.dart';

import '../../../select_member/DataModal/select_member_data_modal.dart';

class OximeterController extends GetxController {



  Rx<OximeterData> oximeterData=OximeterData().obs;

  OximeterData get  getOximeterData=>oximeterData.value;

  set updateOximeterData(OximeterData data){
    oximeterData.value=data;
    update();
  }



}