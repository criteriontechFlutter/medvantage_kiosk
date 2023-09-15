import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CervicalQuesionnaire/cervical_questinnaire_view.dart';

class CervicalStartUpView extends StatelessWidget {
  const CervicalStartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/cervical_doctor.png",fit: BoxFit.fill,)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30,20,30,15),
                child: Text("Fill out your Cervical Pain Questionnaire",style: MyTextTheme().largeBCB.copyWith(fontSize: 20),),
              ),
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(30,0,30,35),
              child: MyButton2(title: "Place Order",onPress:(){
                Get.to(()=>const CervicalQuestionnaireView());
                //App().navigate(context, const CervicalQuestionnaireView());
              }),
            ),
          ],
        ),
      )),
    );
  }
}
