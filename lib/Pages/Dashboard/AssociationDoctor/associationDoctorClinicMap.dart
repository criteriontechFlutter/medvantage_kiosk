



import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AssociationDoctorClinicMap extends StatelessWidget {

  const AssociationDoctorClinicMap({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  final String? latitude;
  final String? longitude;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: MyWidget().myAppBar(context, title: "Location"),
        body: Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GoogleMap(
              onTap: (LatLng latng){
                // address.updateGoogleLat=latng.latitude;
                // address.updateGoogleLong=latng.longitude;
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapToolbarEnabled: true,
              // markers: markers.values.toSet(),
              //  onMapCreated: onMapCreatedNew,
              initialCameraPosition:
              // _kGooglePlex
              CameraPosition(
                target: LatLng(double.parse(latitude!),double.parse(longitude!)),
                zoom: 15.5,
                // onMapCreated: _onMapCreated,
              ),
            )),
      ),
    );
  }
}
