
import 'dart:io';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/widgets/MyCustomSD.dart';
import '../../../AppManager/widgets/date_time_field.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import 'add_prescription_controller.dart';
import 'add_prescription_modal.dart';

class AddPrescription extends StatefulWidget {
  const AddPrescription({Key? key}) : super(key: key);

  @override
  _AddPrescriptionState createState() => _AddPrescriptionState();
}

class _AddPrescriptionState extends State<AddPrescription> {

  AddPrescriptionModal modal = AddPrescriptionModal();

  get() async {
    modal.controller.dateController.value.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await modal.getDiagnosis(context);
  }

  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<AddPrescriptionController>();
  }

  File? _file;

  Future getImage(ImageSource imagetype) async {
    final imagePicker = await ImagePicker().pickImage(source: imagetype);
    modal.controller.updatePrescriptionPhotoPath = imagePicker!.path.toString();
  }


  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Scaffold(
        appBar:MyWidget().myAppBar(context, title: localization.getLocaleData.addPrescription.toString()),
        body: GetBuilder(
            init: AddPrescriptionController(),
            builder: (_) {
              return Form(
                key: modal.controller.formKey.value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
                          child: Column(children: [
                            Text(
                              localization.getLocaleData.prescriptionDetails.toString(),
                              style: MyTextTheme().largeBCN,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                decoration:
                                    BoxDecoration(color: AppColor.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        localization.getLocaleData.doctorsInformation.toString(),
                                        style: MyTextTheme().mediumBCB,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      MyTextField2(
                                        controller: modal.controller
                                            .doctorNameController.value,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return localization.getLocaleData.validationText!.pleaseEnterName.toString();
                                          }
                                        },
                                        hintText: localization.getLocaleData.hintText!.doctorsName.toString(),
                                        borderColor: AppColor.greyLight,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyCustomSD(
                                        borderColor: AppColor.greyLight,
                                        listToSearch:
                                            modal.controller.getDiagnosisList,
                                        height: 200,
                                        hideSearch: false,
                                        label:
                                            localization.getLocaleData.diagnosisProvisionalDiagnosis.toString(),
                                        valFrom: 'problemName',
                                        onChanged: (value) {
                                          if (value != null) {
                                            modal.controller.updateDiagnosisId =
                                                value['problemId'];
                                            modal.controller.updateProblemName =
                                                value['problemName'];
                                          }
                                        },
                                        // modal.controller.dtDataList.add({'medicineName':modal.controller.getDiagnosisList[index].toString(),
                                        // 'frequencyId':modal.controller.getDiagnosisList[index]}),
                                      ),
                                      // SizedBox(height: 10,),
                                      // MyTextField2(maxLength: 200,maxLine: 5,validator: (value){
                                      //   if(value!.isEmpty){
                                      //     return "Please Enter Diagnosis details";
                                      //   }
                                      // },hintText: "Diagnosis/Provisional Diagnosis",borderColor: AppColor.greyLight,),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyDateTimeField(
                                        controller: modal
                                            .controller.dateController.value,
                                        borderColor: AppColor.greyLight,


                                        suffixIcon:   const Icon(
                                            Icons.calendar_today_outlined, ),
                                        // suffixIcon: Icon(Icons.person),
                                      ),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: _file.toString() != '',
                              child: Container(
                                  decoration:
                                      BoxDecoration(color: AppColor.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          localization.getLocaleData.medicineDetails.toString(),
                                          style: MyTextTheme().mediumBCB,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // MyTextField2(validator: (value){
                                        //   if(value!.isEmpty){
                                        //     return "Please Enter Medicine detail";
                                        //   }
                                        // },prefixIcon: Icon(Icons.description),
                                        //   hintText: 'Medicine Name',borderColor: AppColor.greyLight,),

                                        //
                                        //  MyTextField(controller: modal.controller.searchMedicineController.value,
                                        //  onChanged:(value){
                                        //    modal.controller.update();
                                        //    setState(() {
                                        //      print(modal.controller.getSearchData.toString());
                                        //    });
                                        //  }),

                                        //
                                        const SizedBox(height: 10,),
                                        MyTextField2(
                                          controller: modal.controller.medicineC.value,
                                          hintText: localization.getLocaleData.hintText!.enterMedicine.toString(),
                                          onTap: (){
                                            modal.controller.update();
                                          },
                                          //showSearchedList:  modal.controller.selectedAddMedicineCon.value.text==modal.controller.medicineC.value.text,
                                          searchedList: modal.controller.getSearchedMedicine,
                                          searchParam: 'medicineName',
                                           showSearchedList: modal.controller.medicineC.value.text!='',
                                          onTapSearchedData: (val){
                                            if(val!=null){
                                              modal.controller.onTapMedicine(val);
                                              modal.controller.update();
                                            }
                                          },
                                          onChanged: (val){
                                            if(val.toString().length>1) {
                                              modal.getMedicineName(context);

                                            }
                                            else{
                                              modal.controller.updateSearchedMedicine=[];
                                            }
                                            modal.controller.update();
                                          },
                                        ),


                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [

                                            Expanded(
                                              child: MyTextField2(
                                                controller: modal.controller.frequencyC.value,
                                                hintText: localization.getLocaleData.hintText!.enterFrequency.toString(),
                                                searchedList: modal.controller.getFrequency,
                                                searchParam: 'name' ,
                                                onTap: (){
                                                  modal.controller.update();
                                                },
                                                showSearchedList: modal.controller.frequencyC.value.text!='',
                                                onTapSearchedData: (val){
                                                  if(val!=null){
                                                  modal.controller.onTapFrequency(val);
                                                  modal.controller.update();
                                                  }
                                                },
                                                onChanged: (val){
                                                  if(val.toString().length>1) {
                                                    modal.getFrequency(context);
                                                  }
                                                  else{
                                                    modal.controller.updateFrequencyList=[];
                                                  }
                                                  modal.controller.update();

                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: MyTextField2(
                                                controller: modal.controller
                                                    .durationController.value,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]'))
                                                ],
                                                hintText: localization.getLocaleData.hintText!.durationInDays.toString(),
                                                borderColor:
                                                    AppColor.greyLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            MyButton(
                                              title: localization.getLocaleData.addMorePlus.toString(),
                                              buttonRadius: 25,
                                              width: 120,
                                              onPress: () async {
                                                await   modal.onPressedAddMedicine(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    modal.controller.getMedicineDataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                   var details = modal
                                      .controller.getMedicineDataList;

                                  return Container(
                                    color: AppColor.lightBackground,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Icon(
                                              Icons.check_circle,
                                              size: 15,
                                              color: AppColor.green,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text( details[index]['medicineName'].toString(),
                                                style: MyTextTheme().mediumBCB,
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                    modal.controller
                                                        .medicineDataList
                                                        .removeAt(index);

                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: AppColor.red,
                                                ))
                                          ]),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children:   [
                                              Text(localization.getLocaleData.frequency.toString(),style: MyTextTheme().smallGCN,),
                                              Text(localization.getLocaleData.hintText!.durationInDays.toString(),style: MyTextTheme().smallGCN,),
                                              const SizedBox(),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text( details[index]['frequency']?? '-'.toString(),style: MyTextTheme().smallBCN,),
                                              Text( details[index]['durationInDays'].toString(),style: MyTextTheme().smallBCN,),
                                              const SizedBox(),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            // modal.controller.dtDataList.add()
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                decoration:
                                    BoxDecoration(color: AppColor.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        localization.getLocaleData.attachPrescriptionFile.toString(),
                                        style: MyTextTheme().mediumBCB,
                                      ),
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
                                                        .getPrescriptionPhotoPath
                                                        .toString()),
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(localization.getLocaleData.or.toString()),
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
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyButton(
                        title: localization.getLocaleData.submit.toString(),
                        buttonRadius: 20,
                        onPress: () {
                          AddPrescriptionModal().onPressedRequest(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              );
            }));
  }
}
