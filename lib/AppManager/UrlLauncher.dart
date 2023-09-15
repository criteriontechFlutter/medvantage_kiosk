//
//
//
// import 'package:url_launcher/url_launcher.dart';
//
// class UrlLauncher{
//
//
//   launchURL(url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//
//   launchCaller(String number) async {
//     String url = "tel:"+number;
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//
// }