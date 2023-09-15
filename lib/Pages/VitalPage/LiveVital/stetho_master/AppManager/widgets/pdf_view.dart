// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:digi_doctor_max/AppManager/widgets/my_app_bar.dart';
// import 'package:digi_doctor_max/Pages/DoctorSection/DashboardOptions/PendingPatient/PendingPatientsDetails/WritePrescription/PastMedicalHistory/InvestigationHistory/DownloadPercent/dowload_percent_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:lottie/lottie.dart';
//
// class PdfView extends StatefulWidget {
//   final String url;
//
//    const PdfView({Key? key, required this.url}) : super(key: key);
//
//   @override
//   _PdfViewState createState() => _PdfViewState();
// }
//
// class _PdfViewState extends State<PdfView> {
//   @override
//   void initState() {
//     super.initState();
//     get().whenComplete(() {
//       setState(() {});
//     });
//   }
//   DownloadPercentController controller = Get.put(DownloadPercentController());
//   var doc;
//
//   get() async {
//     try{
//       doc = await PDFDocument.fromURL(
//           widget.url);
//     }
//     catch(e){
//       print(e.toString());
//       controller.isFileError.value = true;
//     }
//     // doc = await PDFDocument.fromURL(
//     //     '${widget.url}');
//     // doc = await PDFDocument.fromURL(
//     //     'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: doc != null
//           ? Stack(
//         fit: StackFit.expand,
//               children: [
//                 SafeArea(
//                   child: Scaffold(
//                     appBar: MyWidget().myAppBar(context),
//                     body: PDFViewer(
//                       progressIndicator: const CircularProgressIndicator(
//                         color: Colors.orange,
//                       ),
//                       document: doc,
//                     ),
//                   ),
//                 ),
//                 Material(
//                   color: Colors.transparent,
//                     child: SafeArea(child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(onPressed: (){
//                               Navigator.pop(context);
//                             }, icon: const Icon(Icons.arrow_back_ios_outlined,color: Colors.black,)),
//                           ],
//                         ),
//                       ],
//                     ),),),
//               ],
//           )
//           : Center(
//               child: Lottie.asset('assets/no_files.json')//CircularProgressIndicator(
//               //   color: Colors.orange,
//               // ),
//             ),
//     );
//   }
// }
