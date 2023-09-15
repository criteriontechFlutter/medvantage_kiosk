import 'dart:async';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../AppManager/app_util.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import '../../../Localization/app_localization.dart';
import 'DataModal/result_data_modal.dart';
import 'nearest_hospital_view.dart';
import 'nearesthospital_controller.dart';
import 'nearesthospital_modal.dart';

class NearestHospital extends StatefulWidget {
  const NearestHospital({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NearestHospital> createState() => _NearestHospitalState();
}

class _NearestHospitalState extends State<NearestHospital> {
    late GoogleMapController mapController ;
  NearestHospitalModal modal = NearestHospitalModal();
  final Map<String, Marker> _markers = {};
  List<SearchResult> hospitals = [];
    Position? myPosition;

  Future<Position> _determinePosition() async{
//here my code
    bool serviceEnabled;
    if (await Permission.location.serviceStatus.isEnabled) {
      serviceEnabled = true;

      print("hhhhhhhhhhhhh   Location Service Enabled");
    } else {
      serviceEnabled = false;
      print("hhhhhhhhhhhhh   Location Service disabled");
    }
    var status = await Permission.location.status;
    if (status.isGranted) {
      serviceEnabled = true;
    } else if (status.isDenied) {
      Map<Permission, PermissionStatus> status =
          await [Permission.location].request();
    }
    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }
    //end my code
    return await Geolocator.getCurrentPosition();
  }

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: 60,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  void onMapCreatedNew(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(myPosition!.latitude, myPosition!.longitude),
        zoom: 50.5)));
    setState(() {});
  }





  void _incrementCounter() async {
    // print('resultresultresult');
    modal.controller.updateShowNoData = false;
    myPosition = await _determinePosition();

    print('resultresultresult');
    // await modal.getHospitalData(myPosition?.latitude, myPosition?.latitude);
    await modal.getHospitalData(myPosition?.latitude, myPosition?.longitude);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(myPosition!.latitude,myPosition!.longitude),
            zoom: 14.5)));
    final Uint8List customMarker = await getBytesFromAsset(
      path: "assets/hospital-locater.png",
      width: 38,
    );

    setState(() {});
    // var googlePlace = GooglePlace("AIzaSyBiCc5Juc52C8oAvuqo_y2rCQh6VU_802Q");
    // var result = await googlePlace.search.getNearBySearch(
    //     Location(lat:26.877850, lng: 80.849892), 1500,
    //     type: "hospital", name: "hospital");
    // print('resultresultresult'+result.toString());


      //  print(hospitals[0].geometry.toString());
      for (var i = 0; i < modal.controller.getGoogleResultList.length; i++) {
        ResultDataModal hospital =  modal.controller.getGoogleResultList[i];
        print(hospital.geometry!.location!.lat);
        final marker = Marker(
          icon: BitmapDescriptor.fromBytes(customMarker),
          markerId: MarkerId(hospital.name.toString()),
          position: LatLng(hospital.geometry!.location!.lat!,
              hospital.geometry!.location!.lng!),
          infoWindow: InfoWindow(
            title: hospital.name,
            snippet: hospital.vicinity,
          ),);
        _markers[hospital.name.toString()] = marker;
      }
      setState(() {});


    modal.controller.updateShowNoData = true;
  }
    // loadData() async{
    //   for(int i=0 ;i<modal.controller.getGoogleResultList.length; i++){
    //     final Uint8List markIcons = await getImages(modal.controller.getGoogleResultList[i], 100);
    //     // makers added according to index
    //     _markers.add(
    //         Marker(
    //           // given marker id
    //           markerId: MarkerId(i.toString()),
    //           // given marker icon
    //           icon: BitmapDescriptor.fromBytes(markIcons),
    //           // given position
    //           position: _latLen[i],
    //           infoWindow: InfoWindow(
    //             // given title for marker
    //             title: 'Location: '+i.toString(),
    //           ),
    //         )
    //     );
    //     setState(() {
    //     });
    //   }
    // }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
    // _incrementCounter();
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
            appBar: MyWidget().myAppBar(
              context,
              title: 'Nearest Hospital',
            ),
            body: GetBuilder(
                init: NearestHospitalController(),
                builder: (_) {
                  return Center(
                      child: Column(children: [
        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyTextField2(
                            controller: modal.controller.searchC.value,
                            hintText:'Search...' ,
                            onChanged: (val){
                              setState(() {

                              });
                            },
                          ),
                        ),

                      // Card(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Container(
                      //       height: 200,
                      //       child:GoogleMap(
                      //         onTap: (LatLng latng){
                      //           // address.updateGoogleLat=latng.latitude;
                      //           // address.updateGoogleLong=latng.longitude;
                      //         },
                      //         myLocationButtonEnabled: true,
                      //         myLocationEnabled: true,
                      //         mapToolbarEnabled: true,
                      //         markers: _markers.values.toSet(),
                      //         onMapCreated: onMapCreatedNew,
                      //         initialCameraPosition:
                      //         // _kGooglePlex
                      //         CameraPosition(
                      //           target: LatLng(myPosition==null? 0.0:myPosition!.latitude,myPosition==null? 0.0:myPosition!.latitude),
                      //           zoom: 5.5,
                      //            // onMapCreated: _onMapCreated,
                      //         ),
                      //       ),
                      //       // GoogleMap(
                      //       //   myLocationButtonEnabled: true,
                      //       //   myLocationEnabled: true,
                      //       //   mapToolbarEnabled: true,
                      //       //   markers: _markers.values.toSet(),
                      //       //   onMapCreated:onMapCreatedNew,
                      //       //   initialCameraPosition: _kGooglePlex,
                      //       // ),
                      //     )),
                      // ),

                    Expanded(
                        child: CommonWidgets().showNoData(
                      title: localization.getLocaleData.dataNotFound.toString(),
                      show: (modal.controller.getShowNoData && modal.controller.getGoogleResultList.isEmpty),
                      loaderTitle: localization.getLocaleData.loading.toString(),
                      showLoader:
                          (!modal.controller.getShowNoData && modal.controller.getGoogleResultList.isEmpty),
                      child: ListView(children: [
                        StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            children: List.generate(modal.controller.getGoogleResultList.length, (index) {
                              ResultDataModal hospital = modal.controller.getGoogleResultList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    App().navigate(
                                        context,
                                        NearestHospitalView( hospitalData: hospital, latitude: myPosition!.latitude,longitude: myPosition!.longitude,

                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Image.network(hospital.icon.toString(),
                                                color: AppColor.greyLight
                                                    .withOpacity(0.7),
                                                height: 70),
                                          ),
                                          Text(hospital.name.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTextTheme().smallBCB),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            hospital.vicinity.toString(),
                                            maxLines: 1,
                                          ),

                                          const SizedBox(
                                            height: 5,
                                          ),

                                          InkWell(
                                              onTap: () {
                                                // App().navigate(
                                                //     context,
                                                //     NearHospitalDetails(
                                                //       hospitalDetail: hospital,
                                                //     ));
                                              },
                                              child: const Text("Details")),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ]),
                    )),
                  ]));
                }),
            floatingActionButton: SizedBox(
              height: 45,
              child: FloatingActionButton(
                onPressed: () async {
                   _incrementCounter();
                },
                // backgroundColor: Colors.blue.shade500,
                child: const Icon(
                  Icons.cached_rounded,
                  size: 30,
                ),
              ),
            )),
      ),
    );

  }
}
