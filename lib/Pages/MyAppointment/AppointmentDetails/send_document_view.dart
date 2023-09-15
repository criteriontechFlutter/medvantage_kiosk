import 'dart:io';

import 'package:digi_doctor/AppManager/ImageView.dart';
import 'package:digi_doctor/AppManager/new_video_player.dart';
import 'package:flutter/foundation.dart';
import '../../../AppManager/audio_recorder.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/VideoPlayer.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/MyAppointment/AppointmentDetails/appointment_details_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/getImage.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../Specialities/SpecialistDoctors/TimeSlot/AppointmentBookedDetails/appointment_booked_controller.dart';
import 'appointment_details_controller.dart';


class SendDocumentView extends StatefulWidget {
  final String appointmentId;
  const SendDocumentView({Key? key,required this.appointmentId}) : super(key: key);

  @override
  State<SendDocumentView> createState() => _SendDocumentViewState();
}

class _SendDocumentViewState extends State<SendDocumentView> {
  AppointmentDetailsModal modal = AppointmentDetailsModal();
 // AppointmentBookedController appointmentBookedController = Get.find();

  get() async {
    await modal.controller.clearData();
    modal.controller.selectedAppointmentId.value = widget.appointmentId.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.sendDocument.toString()),
        body: GetBuilder(
            init: AppointmentDetailsController(),
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      localization.getLocaleData.sendYourDataToDoctor.toString(),
                      textAlign: TextAlign.center,
                      style: MyTextTheme().mediumBCN,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                            imagePicker(context);
                          },
                          child: Column(
                            children: [
                              Card(
                                  elevation: 2.0,
                                  child: SvgPicture.asset(
                                    'assets/image.svg',
                                    height: 55,
                                    width: 55,
                                  )),
                              Text(localization.getLocaleData.image.toString())
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  App().navigate(context, AudioRecorder());
                                },
                                child: Card(
                                    elevation: 2.0,
                                    child: SvgPicture.asset(
                                      'assets/audio.svg',
                                      height: 55,
                                      width: 55,
                                    )),
                              ),
                              Text(localization.getLocaleData.audio.toString())
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //MyImagePicker().getVideo();
                          },
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {

                                  final data = await MyImagePicker().getVideo();

                                  modal.controller.addDocumentInList(
                                      data.path, 'assets/video.svg');
                                  modal.controller.addDocumentInList(data.path, 'assets/video.svg');
                                },
                                child: Card(
                                    elevation: 2.0,
                                    child: SvgPicture.asset(
                                      'assets/video.svg',
                                      height: 55,
                                      width: 55,
                                    )),
                              ),
                              Text(localization.getLocaleData.video.toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 30),
                        child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 35,
                            mainAxisSpacing: 10,
                            children: List.generate(
                                modal.controller.getAddDocumentList.length,
                                    (index) {
                                  return Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Platform.isAndroid?
                                          modal
                                              .controller
                                              .getAddDocumentList[index]
                                          ['docFile'].endsWith('jpg')
                                              ?
                                          App().navigate(context, ImageView(isFilePath: true,filePathImg: modal.controller.getAddDocumentList[index]['docFile'],url:  ''))
                                              : App().navigate(
                                              context,
                                              VideoPlayer(
                                                  url: modal.controller
                                                      .getAddDocumentList[index]
                                                  ['docFile']))
                                              :modal
                                              .controller
                                              .getAddDocumentList[index]
                                          ['docFile']
                                              .toString()
                                              .trim()
                                              .split('/').last.split('.')[1] ==
                                              'jpg'
                                              ?

                                          App().navigate(context, ImageView(isFilePath: true,filePathImg: modal.controller.getAddDocumentList[index]['docFile'],url:  ''))
                                              : App().navigate(
                                              context,
                                              VideoPage(
                                                  filePath: modal.controller
                                                      .getAddDocumentList[index]
                                                  ['docFile']));
                                          if (kDebugMode) {
                                            print("######${modal.controller.getAddDocumentList[index]['docFile']}");
                                          }
                                        },
                                        child: Center(
                                          child: Column(
                                            children: [
                                              modal
                                                  .controller
                                                  .getAddDocumentList[index]
                                              ['docFile']
                                                  .toString()
                                              [Platform.isAndroid?1:0] ==
                                                  'jpg'
                                                  ? Image.file(
                                                File(modal
                                                    .controller
                                                    .getAddDocumentList[index]
                                                ['docFile']
                                                    .toString()),
                                                height: 60,
                                                width: 60,
                                              )
                                                  : SvgPicture.asset(
                                                modal
                                                    .controller
                                                    .getAddDocumentList[index]
                                                ['img']
                                                    .toString(),
                                                height: 60,
                                                width: 60,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 2,
                                          right: 0,
                                          child: InkWell(
                                            onTap: () {
                                              modal.controller
                                                  .deleteDocumentInList(index);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 0, 2, 5),
                                              child: Icon(
                                                Icons.delete,
                                                color: AppColor.red,
                                                size: 15,
                                              ),
                                            ),
                                          ))
                                    ],
                                  );
                                })),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: MyButton2(
                        title: localization.getLocaleData.sendDocument.toString(),
                        color: AppColor.primaryColor,
                        onPress: () async {
                          await modal.saveMultipleFile(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  imagePicker(context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    AlertDialogue()
        .show(context, title: localization.getLocaleData.choose.toString(), showCancelButton: true, newWidget: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                // modal.controller.addDocumentInList=MyImagePicker().getCameraImage();
                var data = await MyImagePicker().getCameraImage();


                modal.controller
                    .addDocumentInList(data.path, 'assets/image.svg');
                modal.controller.addDocumentInList(data.path, 'assets/image.svg');
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_rounded,
                    color: AppColor.greyDark,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    localization.getLocaleData.camera.toString(),
                    style: MyTextTheme().mediumBCB,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                var data = await MyImagePicker().getImage();
                modal.controller
                    .addDocumentInList(data.path, 'assets/image.svg');

              },
              child: Row(
                children: [
                  Icon(
                    Icons.image,
                    color: AppColor.greyDark,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Gallery', style: MyTextTheme().mediumBCB),
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
