import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/pdf_viewer.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/prescription_history/prescription_details/prescription_details_controller.dart';
import 'package:digi_doctor/Pages/prescription_history/prescription_details/prescription_details_modal.dart';
import 'package:digi_doctor/AppManager/flutter_download_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/alert_dialogue.dart';
import '../dataModal/prescription_history_data_modal.dart';
import '../prescription_history_modal.dart';

class PrescriptionDetails extends StatefulWidget {
  final PrescriptionHistoryDataModal prescriptionDetail;

  const PrescriptionDetails({Key? key, required this.prescriptionDetail})
      : super(key: key);

  @override
  State<PrescriptionDetails> createState() => _PrescriptionDetailsState();
}

class _PrescriptionDetailsState extends State<PrescriptionDetails> {
  bool isDownloading = false;
  String downloadMessage = '';
  double percent = 0;
  bool isVisible =false;

  get() async {
    modal_pdf.controller.appointmentId.value=widget.prescriptionDetail.appointment_id.toString();
    print( 'nnnnnnnnnnnnnnnn'+modal_pdf.controller.appointmentId.value);
    await modal_pdf.getMedicationPdf(context,widget.prescriptionDetail.appointment_id.toString());

  }

  void initState() {
    super.initState();
    FlutterDownloadFiles().callInInitState(setState);
    get();

  }

  @override
  void dispose() {
    super.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    Get.delete<PrescriptionDetailsController>();
  }

  PrescriptionHistoryModal modal= PrescriptionHistoryModal();
  PrescriptionDetailModal modal_pdf = PrescriptionDetailModal();

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Scaffold(
      appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.prescriptionDetails.toString()),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        children: [
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              Image.asset('assets/image_unavailable.jpg'),
                          imageUrl: widget.prescriptionDetail.profile_photo
                              .toString(),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/image_unavailable.jpg'),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.shade300),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.prescriptionDetail.doctor_name == ''
                                ? localization.getLocaleData.na.toString()
                                : widget.prescriptionDetail.doctor_name
                                    .toString(),
                            style: MyTextTheme().mediumBCB,
                          ),
                          Text(
                            widget.prescriptionDetail.speciality == ''
                                ? localization.getLocaleData.specialityNA.toString()
                                : widget.prescriptionDetail.speciality
                                    .toString(),
                            style: MyTextTheme().smallBCN,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.grey.shade200,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.prescriptionDetail.start_date == ''
                            ? localization.getLocaleData.na.toString()
                            : widget.prescriptionDetail.start_date.toString(),
                        style: MyTextTheme().smallBCN,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            localization.getLocaleData.diagnosis.toString(),
            style: MyTextTheme().mediumBCB,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.prescriptionDetail.problem_name == ''
                ? localization.getLocaleData.na.toString()
                : widget.prescriptionDetail.problem_name.toString(),
            style: MyTextTheme().smallBCN,
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.prescriptionDetail.adviseDetails!.length,
            itemBuilder: (BuildContext context, int index) {
              AdviseDetails adviseDetails= widget.prescriptionDetail.adviseDetails![index];
              return Column(
                children: [
                  Visibility(
                    visible:adviseDetails.recommendedDiet!='' ,
                    child: Row(
                      children: [
                        Text('Recommended Diet : ',style: MyTextTheme().mediumBCB, ),
                        Text(adviseDetails.recommendedDiet.toString(),style: MyTextTheme().smallBCN, ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: adviseDetails.avoidedDiet!='' ,
                    child: Row(
                      children: [
                        Text('Avoided Diet : ',style: MyTextTheme().mediumBCB, ),
                        Text(adviseDetails.avoidedDiet.toString(),style: MyTextTheme().smallBCN, ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: adviseDetails.otherDiet!='' ,
                    child: Row(
                      children: [
                        Text('Other Diet : ',style: MyTextTheme().mediumBCB, ),
                        Text(adviseDetails.otherDiet.toString(),style: MyTextTheme().smallBCN, ),
                      ],
                    ),
                  )
                ],
              );
            },
              ),


          const SizedBox(
            height: 20,
          ),
          Text(localization.localeData!.prescription.toString(), style: MyTextTheme().mediumBCB),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: CommonWidgets().showNoData(
              title: localization.getLocaleData.prescriptionDataNotFound.toString(),
              show: (modal.controller.getShowNoData &&
                  widget.prescriptionDetail.medicine_details!.isEmpty),
              loaderTitle: localization.getLocaleData.loadingPrescription.toString(),
              showLoader: (!modal.controller.getShowNoData &&
                  widget.prescriptionDetail.medicine_details!.isEmpty),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.prescriptionDetail.medicine_details!.length,
                itemBuilder: (BuildContext context, int index) {
                  MedicineDetails medicine_details =
                      widget.prescriptionDetail.medicine_details![index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Image.asset(
                                      'assets/image_unavailable.jpg'),
                                  imageUrl: widget
                                      .prescriptionDetail.profile_photo
                                      .toString(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          'assets/image_unavailable.jpg'),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey.shade300),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    medicine_details.medicine_name == ''
                                        ? localization.getLocaleData.na.toString()
                                        : medicine_details.medicine_name
                                            .toString(),
                                    style: MyTextTheme().mediumBCB,
                                  ),
                                  Text(
                                    medicine_details.dosage_form_name == ''
                                        ? localization.getLocaleData.dosageFormNA.toString()
                                        : medicine_details.dosage_form_name
                                            .toString(),
                                    style: MyTextTheme().smallBCN,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          indent: 80,
                          endIndent: 10,
                          color: Colors.grey.shade300,
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(80, 5, 20, 20),
                            child: Table(
                              children: [
                                TableRow(children: [
                                  Text(
                                    localization.getLocaleData.frequency.toString(),
                                    style: MyTextTheme().smallGCN,
                                  ),
                                  Text(
                                    localization.getLocaleData.hintText!.durationInDays.toString(),
                                    style: MyTextTheme().smallGCN,
                                  )
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 20),
                                    child: Text(
                                      medicine_details.frequency_name == ''
                                          ? localization.getLocaleData.na.toString()
                                          : medicine_details.frequency_name
                                              .toString(),
                                      style: MyTextTheme().smallBCB,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 20),
                                    child: Text(
                                      medicine_details.duration.toString() == ''
                                          ? localization.getLocaleData.na.toString()
                                          : medicine_details.duration
                                              .toString(),
                                      style: MyTextTheme().smallBCB,
                                    ),
                                  )
                                ]),
                                TableRow(children: [
                                  Text(
                                    localization.getLocaleData.strength.toString(),
                                    style: MyTextTheme().smallGCN,
                                  ),
                                  Text(
                                    localization.getLocaleData.unit.toString(),
                                    style: MyTextTheme().smallGCN,
                                  )
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 20),
                                    child: Text(
                                      medicine_details.strength.toString() == ''
                                          ? localization.getLocaleData.na.toString()
                                          : medicine_details.strength
                                              .toString(),
                                      style: MyTextTheme().smallBCB,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 20),
                                    child: Text(
                                      medicine_details.unit_name == ''
                                          ? localization.getLocaleData.na.toString()
                                          : medicine_details.unit_name
                                              .toString(),
                                      style: MyTextTheme().smallBCB,
                                    ),
                                  )
                                ]),
                              ],
                            ))
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(
            title: 'View PDF'.toString(),
            buttonRadius: 20,
            onPress: () async {
              if (Platform.isAndroid) {
                print("################"+modal_pdf.controller.getPdfUrl.toString());
                App().navigate(context, PdfViewer(pdfUrl:modal_pdf.controller.getPdfUrl));
              }
              else if (Platform.isIOS) {
                alertToast(context,localization.getLocaleData.alertToast!.comingSoon.toString());
              }
            },
          ),
          // MyButton(
          //   title: localization.getLocaleData.downloadPrescription.toString(),
          //   buttonRadius: 20,
          //   onPress: () async {
          //     if (Platform.isAndroid) {
          //       await FlutterDownloadFiles().download(
          //           context, modal_pdf.controller.getAppointmentId.toString());
          //     }else if (Platform.isIOS) {
          //      alertToast(context,localization.getLocaleData.alertToast!.comingSoon.toString());
          //     }
          //
          //   },
          // ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
