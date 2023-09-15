




import 'dart:io';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../prescription_history_modal.dart';
import '../prescripton_history_controller.dart';

AddPrescriptionModule(context){

  PrescriptionHistoryModal modal = PrescriptionHistoryModal();
  modal.controller.prescriptionPhotoPath.value='';
  File? _file;

  Future getImage(ImageSource imagetype) async {
    final imagePicker = await ImagePicker().pickImage(source: imagetype);
    modal.controller.updatePrescriptionPhotoPath = imagePicker!.path.toString();
  }
  ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
  AlertDialogue().show(context,   title: localization.getLocaleData.attachPrescriptionFile.toString(),newWidget: [

    GetBuilder(
      init: PrescriptionHistoryController(),
      builder: (_) {
        return Column(
        children: [
          Container(
              decoration:
              BoxDecoration(color: AppColor.white),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                         Align(
                            alignment: Alignment.center,
                            child: Text(localization.getLocaleData.camera.toString())),
                        InkWell(
                          onTap: () {
                            getImage(ImageSource.camera);
                          },
                          child: modal.controller
                              .getPrescriptionPhotoPath ==
                              ''
                              ? SvgPicture.asset(
                            'assets/cameraicon.svg',
                            width: 100,
                            height: 100,
                          )
                              : Image.file(
                            File(modal.controller
                                .getPrescriptionPhotoPath),
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('OR'),
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          title: localization.getLocaleData.browse.toString(),
                          buttonRadius: 20,
                          width: 150,
                          onPress: () {
                            getImage(ImageSource.gallery);
                            // AlertDialogue().show(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyButton(
              title: localization.getLocaleData.submit.toString(),
              buttonRadius: 20,
              width: 200,
              onPress: () async {
               await modal.onPressedRequest(context);
              },
            ),
          ),
        ],
  );
      }
    )]
  );
  
}