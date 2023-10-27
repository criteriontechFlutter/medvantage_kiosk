


import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../AppManager/widgets/my_button2.dart';
import '../../../../../AppManager/widgets/my_text_field_2.dart';
import '../stethoscope_controller.dart';

recodingModule(context){

  StethoscopeController stethoController = Get.put(StethoscopeController());
  stethoController.clearData();
  AlertDialogue().show(context,msg: '',title:'Record Data',
newWidget: [
  GetBuilder(
    init: StethoscopeController(),
    builder: (_) {
      return Form(
        key: stethoController.recordingFormKey.value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyTextField2(
                controller: stethoController.timeC.value,
                hintText: "Enter time in sec",
                validator: (val){
                  if(val!.isEmpty){
                        return 'Please Enter recording second';
                      }
                    },
              ),
              const SizedBox(height: 10,),

              MyTextField2(
                controller: stethoController.pidC.value,
                hintText: "Enter PID",
                validator: (val){
                  if(val!.isEmpty){
                        return 'Please Enter PID';
                      }
                    },
              ),

              const SizedBox(height: 10,),
              MyButton2(
                title: "Start Recording",
                onPress: () {
                  if( stethoController.recordingFormKey.value.currentState!.validate()){
                    Navigator.pop(context);
                    stethoController.readStethoData(context,'record_data');
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
  ),
  ]);
}