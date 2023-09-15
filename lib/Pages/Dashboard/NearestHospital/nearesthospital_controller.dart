import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'DataModal/result_data_modal.dart';

class NearestHospitalController extends GetxController {


Rx<TextEditingController> searchC=TextEditingController().obs;
  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }




  final LatLng centerPosition = const LatLng(45.521563, -122.677433);

  void onMapCreated(GoogleMapController controller) {
  }

  var currentLocation;

  void initState() {
    super.dispose();
    Geolocator.getCurrentPosition().then((CurrentLocation) {
      currentLocation = CurrentLocation;
    });
  }


  List googleResultList=[].obs;

List<ResultDataModal> get getGoogleResultList=>List<ResultDataModal>.from(
    (
        (searchC.value.text==''?googleResultList:googleResultList.where((element) =>
            (
                element['name'].toString().toLowerCase().trim()
            ).trim().contains(searchC.value.text.toLowerCase().trim())
        ))
            .map((element) => ResultDataModal.fromJson(element))
    ));

  set updateGoogleResultList(List val){
    googleResultList=val;
    update();
  }
}
