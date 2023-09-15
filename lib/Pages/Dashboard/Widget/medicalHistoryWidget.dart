
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/user_data.dart';
import '../../InvestigationHistory/investigation_view.dart';
import '../../MyAppointment/my_appointment_view.dart';
import '../../VitalPage/Add Vitals/VitalHistory/vital_history_view.dart';

// class AVIWidget extends StatefulWidget {
//   const AVIWidget({Key? key}) : super(key: key);
//
//   @override
//   State<AVIWidget> createState() => _AVIWidgetState();
// }
//
// class _AVIWidgetState extends State<AVIWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount:getAVIData(context).length,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (BuildContext context, int index){
//
//           AVIDataModal data =getAVIData(context)[index];
//       return  InkWell(
//         onTap: (){
//           if(UserData().getUserData.isNotEmpty){
//             if(getContainerIndex.toString()=="0"){
//               App().replaceNavigate(context,data.route);
//             }else if(getContainerIndex.toString()=="1"){
//               App().replaceNavigate(context,data.route);
//             }else{
//               App().replaceNavigate(context, data.route);
//             }
//           }else{
//             App().replaceNavigate(context, const StartupPage());
//           }
//         },
//         child: Padding(
//           padding:
//           const EdgeInsets.symmetric(
//               vertical: 20,
//               horizontal: 12),
//           child: Container(
//            width: 200,
//             decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(10),
//               color: getContainerIndex.toString()==index.toString()?AppColor
//                   .red:AppColor.primaryColor,
//             ),
//
//             child: Padding(
//               padding:
//               const EdgeInsets.all(
//                   8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     data.containerImage.toString(),
//                     height: 40,
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Text(
//                       data.containerText.toString(),
//                       style: MyTextTheme()
//                           .largeWCN,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }



class AVIDataModal{
  String?containerText;
  String?containerImage;
  Widget?route;

  AVIDataModal({
    this.containerImage,
    this.containerText,
    this.route
  });

}



