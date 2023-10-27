


import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../stethoscope_controller.dart';
import '../stetho_controller.dart';

viewAllPIDModule(context) {
  StethoscopeController controller=Get.put(StethoscopeController());
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          title: Text("Select Member"),
          content:  Container(
            height: 250,
            width: MediaQuery.of(context).size.width/1.2,
            child: Center(
              child: GetBuilder(
                  init: StethoscopeController(),
                  builder: (_) {
                    return Material(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.getMemberList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data=controller.getMemberList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (){
                                      controller.pidTextC.value.text=data['pid'].toString();
                                      controller.update();
                                      Navigator.pop(context);
                                    },
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Text(data['name'].toString(),style: MyTextTheme().mediumBCB,),
                                            SizedBox(width: 10,),
                                            Text('(${data['pid'].toString()})',style: MyTextTheme().mediumBCB,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },

                            ),
                          )
                        ],
                      ),
                    );

                  }),
            ),
          ),
          actions: <Widget>[
            MyButton(title: 'Close',color: AppColor.orangeButtonColor,onPress: (){
              Navigator.pop(context);
            },)
          ],
        );
      }
  );
  ;}