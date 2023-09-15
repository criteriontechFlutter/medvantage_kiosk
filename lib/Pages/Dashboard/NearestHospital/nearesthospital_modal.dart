


import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

import 'nearesthospital_controller.dart';
import 'package:http/http.dart' as http;

class NearestHospitalModal{
  NearestHospitalController controller=Get.put(NearestHospitalController());

  getDetails(String addressId) async {
    var googlePlace = GooglePlace("AIzaSyBiCc5Juc52C8oAvuqo_y2rCQh6VU_802Q");
    DetailsResponse? result = await googlePlace.details.get(addressId,
        fields: "name,rating,formatted_phone_number");

    if (result != null) {
      return result.result;
    }
  }


  getHospitalData(lat,log,) async {
    controller.updateShowNoData=false;
    var response= await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$log&radius=5000&types=hospital&name=hospital&key=AIzaSyBiCc5Juc52C8oAvuqo_y2rCQh6VU_802Q'),
    );
    print('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$log&radius=5000&types=hospital&name=hospital&key=AIzaSyBiCc5Juc52C8oAvuqo_y2rCQh6VU_802Q');
    controller.updateShowNoData=true;
    var data=jsonDecode(response.body);
    print('nnnnnvnnnvvnnnvv'+data.toString());
    controller.updateGoogleResultList=data['results'];
  }

}