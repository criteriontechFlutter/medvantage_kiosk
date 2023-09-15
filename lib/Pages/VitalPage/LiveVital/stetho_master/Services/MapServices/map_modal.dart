//
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'dart:ui' as ui;
//
// import 'location_modal.dart';
//
//
//
//
// class MapModal{
//
//   Future<Position> getCurrentLocation(context) async {
//     // ProgressDialogue().show(context,
//     //     loadingText: 'Getting current location');
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     var data=await LocationModal().service();
//     if(data){
//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         // Location services are not enabled don't continue
//         // accessing the position and request users of the
//         // App to enable the location services.
//         return Future.error('Location services are disabled.');
//       }
//
//       permission = await Geolocator.checkPermission();
//    //   permission = await Geolocator.checkPermission();
//       // print('HHHHHHHHHHHH'+permission.toString());
//       if (permission == LocationPermission.denied) {
//
//         permission = await Geolocator.requestPermission();
//
//         if (permission == LocationPermission.deniedForever) {
//           // Permissions are denied forever, handle appropriately.
//           return Future.error(
//               'Location permissions are permanently denied, we cannot request permissions.');
//         }
//
//         if (permission == LocationPermission.denied) {
//           // Permissions are denied, next time you could try
//           // requesting permissions again (this is also where
//           // Android's shouldShowRequestPermissionRationale
//           // returned true. According to Android guidelines
//           // your App should show an explanatory UI now.
//           return Future.error(
//               'Location permissions are denied');
//         }
//       }
//
//       // When we reach here, permissions are granted and we can
//       // continue accessing the position of the device.
//     }
//
//     // ProgressDialogue().hide();
//     return await Geolocator.getCurrentPosition();
//   }
//
//
//   cameraPosition(Position location) {
//     return CameraPosition(
//       target: LatLng(location.latitude, location.longitude),
//       zoom: 18,
//     );
//   }
//
//
//
//
//
//   // Future<String> addressFromCoordinates(Position loc) async{
//   //   List<Placemark> placeMarks = await placemarkFromCoordinates(loc.latitude, loc.longitude);
//   //   print(placeMarks.toString());
//   //   String  address=   locationFromPlaceMarker(placeMarks).toString();
//   //   print(address);
//   //   return address.toString();
//   // }
//   //
//   //
//   // coordinatesFromAddress(address) async{
//   //   List locations = await locationFromAddress(address.toString());
//   //   var _currentLocation=LatLng(locations[0].latitude,locations[0].longitude);
//   //   return _currentLocation;
//   // }
//   //
//   //
//   //
//   // customMarker(imageUrl) async{
//   //   // final Uint8List icon = await getBytesFromAsset('assets/marker.jpg', 150);
//   //   //  final http.Response response = await http.get(Uri.parse('https://map.radius.gr/public/eventdata/ZE0YUQiiiA8xpYpqOh7UHvXOjXZ8eXYzVIdQOj49.gif'));
//   //   //  return BitmapDescriptor.fromBytes(response.bodyBytes);
//   //
//   //   final int targetWidth = 100;
//   //   final File markerImageFile = await DefaultCacheManager().getSingleFile((imageUrl=='' || imageUrl==null)?
//   //
//   //   'https://picsum.photos/200/300':
//   //   imageUrl);
//   //   final Uint8List markerImageBytes = await markerImageFile.readAsBytes();
//   //
//   //   final Codec markerImageCodec = await instantiateImageCodec(
//   //     markerImageBytes,
//   //     targetWidth: targetWidth,
//   //   );
//   //
//   //   final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
//   //   final ByteData? byteData = await frameInfo.image.toByteData(
//   //     format: ImageByteFormat.png,
//   //   );
//   //
//   //   final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
//   //
//   //   return BitmapDescriptor.fromBytes(resizedMarkerImageBytes);
//   //
//   //
//   // }
//
//
//   Future<String> locationFromPlaceMarker(placemarks) async{
//     String newLocation=
//         placemarks[0].name.toString()+', '+
//             placemarks[2].street.toString()+', '+
//             placemarks[1].subLocality.toString()+', '+
//             placemarks[0].locality.toString()+', '+
//             placemarks[0].administrativeArea.toString()+', '+
//             placemarks[0].country.toString();
//     return newLocation;
//   }
//
//
//
// }
//
//
//
// Future<Uint8List> getBytesFromAsset(String path, int width) async {
//   ByteData data = await rootBundle.load(path);
//   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//   ui.FrameInfo fi = await codec.getNextFrame();
//   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
// }