import 'dart:math';

import 'package:digi_doctor/AppManager/web_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/app_color.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/app_util.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/bluetooth_connectivity/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../AppManager/progress_dialogue.dart';
import '../AppManager/raw_api.dart';
import '../AppManager/web_view.dart';
import '../AppManager/widgets/common_widgets.dart';

class MainScreenDart extends StatefulWidget {
  const MainScreenDart({Key? key}) : super(key: key);

  @override
  State<MainScreenDart> createState() => _MainScreenDartState();
}

class _MainScreenDartState extends State<MainScreenDart> {

  TextEditingController pid=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Digital StethoScope",style: TextStyle(fontSize: 28,fontWeight:FontWeight.bold ),),
          const SizedBox(height: 100,),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: MyTextField2(
               hintText: "Enter Pid",
               controller:pid ,
             ),
           ),
            const SizedBox(height: 10,),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton2(title: "Connect",onPress: (){
                getWebView(context,pid: pid.value.text.toString());
              },color: Colors.indigo,),
            ),
            const SizedBox(height: 10,),
            const Text("Or"),
            const SizedBox(height: 10,),
             MyButton2(title: "Connect Device",onPress: (){
              App().navigate(context, const Tester());
            },color: Colors.indigo,)
          ],
        ),
      ),
    );
  }

  getWebView(context,{required String pid})async{
    ProgressDialogue().show(context, loadingText: "redirecting to webpage");
    var data =await RawData().getapi("getPatientInfoByPID/$pid",context);
    ProgressDialogue().hide();
    print("ppppppppppppppppppppp$data");
    if(data["status"]=="success"){
      print("lllllllllll${data['data']['listenUrl']}");
      Get.to(()=>WebViewPage(url: data['data']['listenUrl'].toString(), title: 'Stethoscope',));
    }
    else{
      alertToast(context,data["data"].toString());
    }
  }
}
