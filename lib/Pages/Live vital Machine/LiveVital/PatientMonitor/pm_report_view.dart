
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PMReportView extends StatefulWidget {
  final String heartRate;
  final String temperature;
  final String SPO2;
  final String BP;
  final String PR;
  const PMReportView({Key? key, required this.heartRate, required this.temperature, required this.SPO2, required this.BP, required this.PR}) : super(key: key);

  @override
  State<PMReportView> createState() => _PMReportViewState();
}

class _PMReportViewState extends State<PMReportView> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // TODO: implement initState
    super.initState();
  }

  onPressedBack(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
       child: SafeArea(
         child: Scaffold(
           body:  WillPopScope(
             onWillPop: () {
               return onPressedBack();
             },
             child: Column(
               children:   [
                 GestureDetector(
                   onTap: (){
                       onPressedBack();
                   },
                   child: Row(
                     children: [
                       const Padding(
                         padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                         child: Icon(Icons.arrow_back_ios),
                       ),
                       Text('Patient Report',style: MyTextTheme().largeBCB,),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: Container(
                     padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child:  Column(
                       children: [
                         Row(
                           children: [
                             Text('Patient Name : ',style: MyTextTheme().mediumBCB,),
                             Text(UserData().getUserName.toString().toUpperCase(),style: MyTextTheme().mediumBCB,),
                           ],
                         ),
                         const SizedBox(height: 10,),
                         Row(
                           children: [
                             Text('Patient PID : ',style: MyTextTheme().mediumBCB,),
                             Text(UserData().getUserPid.toString().toUpperCase(),style: MyTextTheme().mediumBCB,),
                           ],
                         ),
                         const SizedBox(height: 20,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Container(
                               width: 130,
                               height: 130,
                               decoration: BoxDecoration(
                                   color: AppColor.primaryColor,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(widget.heartRate.toString().toUpperCase(),style: MyTextTheme().mediumWCB,),
                                   Text('Heart Rate',style: MyTextTheme().mediumWCB),
                                 ],
                               ),
                             ),
                             Container(
                               width: 130,
                               height: 130,
                               decoration: BoxDecoration(
                                   color: AppColor.primaryColor,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(widget.temperature.toString().toUpperCase(),style: MyTextTheme().mediumWCB,),
                                   Text('Temperature',style: MyTextTheme().mediumWCB,),
                                 ],
                               ),
                             ),
                           ],
                         ),

                         const SizedBox(height: 10,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Container(
                               width: 130,
                               height: 130,
                               decoration: BoxDecoration(
                                   color: AppColor.primaryColor,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(widget.SPO2.toString().toUpperCase(),style: MyTextTheme().mediumWCB,),
                                   Text('SPO2',style: MyTextTheme().mediumWCB,),
                                 ],
                               ),
                             ),

                             Container(
                               width: 130,
                               height: 130,
                               alignment: Alignment.center,
                               decoration: BoxDecoration(
                                   color: AppColor.primaryColor,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(widget.BP.toString().toUpperCase(),style: MyTextTheme().mediumWCB,),
                                   Text('BP',style: MyTextTheme().mediumWCB,),
                                 ],
                               ),
                             ),
                           ],
                         ),
                         const SizedBox(height: 10,),
                         Row(mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Container(
                               width: 130,
                               height: 130,
                               decoration: BoxDecoration(
                                   color: AppColor.primaryColor,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(widget.PR.toString().toUpperCase(),style: MyTextTheme().mediumWCB,),
                                   Text('Pulse Rate',style: MyTextTheme().mediumWCB,),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),


               ],
             ),
           ),
         ),
       ),
    );
  }
}
