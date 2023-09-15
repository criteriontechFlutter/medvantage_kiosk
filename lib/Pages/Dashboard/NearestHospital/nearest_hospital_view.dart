


import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../Localization/app_localization.dart';
import '../../../MapServices/map_modal.dart';
import 'DataModal/result_data_modal.dart';

class NearestHospitalView extends StatefulWidget {
  final ResultDataModal hospitalData;
  final double latitude;
  final double longitude;
  const NearestHospitalView({Key? key, required this.hospitalData, required this.latitude, required this.longitude }) : super(key: key);

  @override
  State<NearestHospitalView> createState() => _NearestHospitalViewState();
}

class _NearestHospitalViewState extends State<NearestHospitalView> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController ;
  void onMapCreatedNew(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: 5.5)));
    setState(() {});
  }

  setMarker() async {
    final Uint8List customMarker = await getBytesFromAsset(    "assets/hospital-locater.png",
          38, );
  final marker = Marker(
      icon: BitmapDescriptor.fromBytes(customMarker),
      markerId: MarkerId(widget.hospitalData.name.toString()),
      position: LatLng(widget.hospitalData.geometry!.location!.lat!,
          widget.hospitalData.geometry!.location!.lng!),
      infoWindow: InfoWindow(
        title: widget.hospitalData.name,
        snippet: widget.hospitalData.vicinity,
      ),);
    _markers[widget.hospitalData.name.toString()] = marker;
  }
  @override
  void initState() {
    setMarker();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(
          context,
          title: 'Hospital Detail',
        ),
          body:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 8, 5),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/hospital_buildings.svg',
                          height: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            widget.hospitalData.name.toString(),
                            style: MyTextTheme().mediumBCB,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0,0,10,0),
                        //   child: IconButton(
                        //     onPressed: () async {
                        //       await doctorProfileModal.sendSMSPatientToDoctor(context,hospitalData.userMobileNo.toString());
                        //     },
                        //     icon: Image.asset(
                        //       'assets/sms.png',
                        //       height: 25,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.speaker_notes_rounded,
                        size: 15,
                        color: AppColor.orangeButtonColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(widget.hospitalData.userRatingsTotal.toString() +
                          localization.getLocaleData.feedback.toString() ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 220,
                      child:
                      Container(
                        height: 200,
                        width:
                        MediaQuery.of(context).size.width /
                            1.06,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.greyLight),
                            borderRadius:
                            BorderRadius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: widget
                              .hospitalData.icon
                              .toString()
                              .toString(),
                          errorWidget: (context, url, error) =>
                              Image.asset(
                                'assets/logo.png',
                              ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 15,
                        color: AppColor.orangeButtonColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(widget.hospitalData
                                .vicinity
                                .toString()),
                            // Text(   widget.hospitalDetails.stateName.toString(),),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.phone,
                  //       size: 15,
                  //       color: AppColor.orangeButtonColor,
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //     // Text(widget.hospitalData..toString())
                  //   ],
                  // ),

                  const SizedBox(height: 10,),
                  Expanded(
                    child: Card(
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
                            markers: _markers.values.toSet(),
                            onMapCreated: onMapCreatedNew,
                            initialCameraPosition:
                            // _kGooglePlex
                            CameraPosition(
                              target: LatLng(widget.latitude,widget.latitude),
                              zoom: 15.5,
                              // onMapCreated: _onMapCreated,
                            ),
                          )),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
