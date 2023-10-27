import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../AppManager/alert_dialogue.dart';
import '../../../../../../AppManager/widgets/MyTextField.dart';
import '../stetho_chart_view.dart';
import '../stetho_controller.dart';

pickAudioRecording(context) {
  StethoController controller=Get.put(StethoController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GetBuilder(
        init: StethoController(),
        builder: (_) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(15),
                child: Material(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 7,
                              child:  Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: AppColor.greyLight,
                                    borderRadius: BorderRadius.circular(5)),
                                    child:controller.getFileOnePath.toString()!=''?
                                    Text(controller.getFileOnePath.toString(),
                                    maxLines: 2,overflow: TextOverflow.ellipsis,):Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text('Pick Audio File'),
                                    ),
                                  )

                ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 4,
                              child: MyButton(
                                title: 'Audio File 1',
                                onPress: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  controller.updateFileOnePath=result.files.single.path!;
                                // File file = File(result.files.single.path);
                                } else {
                                // User canceled the picker
                                }
                                }
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 7,
                              child:Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: AppColor.greyLight,
                                    borderRadius: BorderRadius.circular(5)),
                                child: controller.getFileTwoPath.toString()!=''?
                                Text(controller.getFileTwoPath.toString(),
                                  maxLines: 2,overflow: TextOverflow.ellipsis,):Padding(
                                  padding: const EdgeInsets.all(5),
                                    child: Text('Pick Audio File'),
                                  ),
                              ) ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 4,
                              child: MyButton(
                                title: 'Audio File 2',
                                onPress: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles();

                              if (result != null) {
                              controller.updateFileTwoPath=result.files.single.path!;
                              // File file = File(result.files.single.path);
                              } else {
                              // User canceled the picker
                              }
                              },
                              )),
                        ],
                      ),
                      Spacer(),
                     Row(children: [
                       Expanded(child: MyButton(title: 'Close',color: AppColor.orangeButtonColor,
                       onPress: (){
                         Navigator.pop(context);
                       },)),
                       SizedBox(width: 5,),
                       Expanded(child: MyButton(title: 'Compare Data',
                       onPress: (){
                         if(controller.getFileTwoPath!='' && controller.getFileOnePath!=''){
                           App().navigate(context, AudioGraphPage(audioFilePathOne: controller.getFileOnePath.toString(),
                               audioFilePathTwo: controller.getFileTwoPath.toString()));
                         }
                         else{
                           alertToast(context, 'Please Pick Both File');
                         }
                       })),
                     ],),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      );
    },
  );
}
