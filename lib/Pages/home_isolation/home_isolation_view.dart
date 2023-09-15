


import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/HomeIsolationPatientList/home_isolation_patient_list_view.dart';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/MyCustomSD.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/tab_responsive.dart';
import '../../AppManager/user_data.dart';
import '../../AppManager/widgets/date_time_field.dart';
import '../select_member/select_memeber_modal.dart';
import 'home_isolation_controller.dart';
import 'home_isolation_modal.dart';

class HomeIsolation extends StatefulWidget {
  const HomeIsolation({Key? key}) : super(key: key);

  @override
  _HomeIsolationState createState() => _HomeIsolationState();
}

class _HomeIsolationState extends State<HomeIsolation> {
  HomeModal modal = HomeModal();
  SelectMemberModal selectMemberModal=SelectMemberModal();

  get() async {
    modal.controller.nameController.value.text =
        modal.userData.getUserName.toString();
    modal.controller.mobileController.value.text =
        modal.userData.getUserMobileNo.toString();
    await selectMemberModal.getMember(context);
    //await modal.getIsolationPackage(context);
    await modal.getHospitalList(context);
  }

  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<HomeIsolationController>();
  }

  bool isSwitched = false;
  bool isSwitched2 = false;

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
            appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.homeIsolationRequest.toString(),
                action: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 20, 10),
                child: InkWell(onTap:(){
                  App().navigate(context, HomeIsolationPatientListView());
                },child: Icon(Icons.list_alt_rounded)),
              )
            ]),
            body: GetBuilder(
                init: HomeIsolationController(),
                builder: (_) {
                  return Form(
                    key: modal.controller.formKey.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child:
                    TabResponsive().wrapInTab(
                      context: context,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [

                                    MyCustomSD(
                                      hideSearch: true,
                                        listToSearch: selectMemberModal.controller.selectMember,
                                        valFrom: 'name',
                                        initialValue: [
                                        {
                                        'parameter': 'name',
                                        'value': UserData().getUserName.toString(),
                                        },],
                                        onChanged: (val){
                                          if(val!=null){
                                            modal.controller.nameController.value
                                                .text = val['name'].toString();
                                            modal.controller.mobileController.value
                                                .text = val['mobileNo'].toString();
                                            modal.controller.memberId.value = val['memberId'].toString();
                                            print( modal.controller.memberId.value);


                                          }
                                        }),
                                    const SizedBox(height: 10),

                                    MyTextField2(
                                      controller:
                                          modal.controller.mobileController.value,
                                      borderColor: AppColor.greyLight,
                                      borderRadius: BorderRadius.zero,
                                      maxLength: 10,
                                      enabled: false,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'))
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    MyCustomSD(
                                        listToSearch:
                                            modal.controller.getHospitalList,
                                        height: 200,
                                        hideSearch: true,
                                        label: localization.getLocaleData.hintText!.selectHospital.toString(),
                                        valFrom: 'name',
                                        borderColor: AppColor.greyLight,
                                        onChanged: (value) {
                                          if (value != null) {
                                            modal.controller
                                                    .updateSelectedHospitalId =
                                                value['id'] as int;
                                          }
                                        }),
                                    const SizedBox(height: 10),

                                    MyTextField2(
                                        hintText: localization.getLocaleData.hintText!.enterYourComorbid.toString(),
                                        borderColor: AppColor.greyLight,
                                        borderRadius: BorderRadius.zero,
                                        controller:
                                            modal.controller.comorBidController.value,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return localization.getLocaleData.validationText!.enterYourComorbid.toString();
                                          }
                                        }),
                                    const SizedBox(
                                      height: 5,
                                    ),

                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            localization.getLocaleData.anySymptoms.toString(),
                                            style: MyTextTheme().smallBCB,
                                          ),
                                          const Expanded(
                                            child: SizedBox(
                                              width: 90,
                                            ),
                                          ),
                                          Switch(
                                              value: isSwitched,
                                              onChanged: (value) {
                                                setState(() {
                                                  isSwitched = value;
                                                });
                                              }),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                        visible: isSwitched == true,
                                        child: Column(
                                          children: [
                                            MyTextField2(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return localization.getLocaleData.validationText!.enterYourSymptoms.toString();
                                                }
                                              },
                                              controller: modal.controller
                                                  .symptomsController.value,
                                              hintText: localization.getLocaleData.hintText!.enterYourSymptoms.toString(),
                                              borderColor: AppColor.greyLight,
                                              borderRadius: BorderRadius.zero,
                                            ),

                                            SizedBox(
                                              height: 10,
                                            ),
                                            MyDateTimeField(
                                              controller: modal.controller
                                                  .onSetDateController.value,
                                              hintText:localization.getLocaleData.hintText!.selectDateOfSymptom.toString(),
                                              suffixIcon: Icon(
                                                Icons.calendar_today_outlined,
                                                color: AppColor.primaryColor,
                                              ),
                                              borderColor: AppColor.greyLight,
                                              borderRadius: BorderRadius.zero,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return localization.getLocaleData.validationText!.enterADate.toString();
                                                }
                                              },
                                            ),
                                          ],
                                        )),

                                    const SizedBox(height: 5),
                                    MyCustomSD(
                                      listToSearch:
                                          modal.controller.getPackageList(context),
                                      label: localization.getLocaleData.hintText!.selectPackage.toString(),
                                      height: 200,
                                      hideSearch: true,
                                      valFrom: 'packageName',
                                      onChanged: (value) {
                                        if (value != null) {
                                          modal.controller.updateSelectedPackageId =
                                              value['id'];
                                          modal.controller.pricePackageController.value.text=value['packagePrice'].toString();
                                        }
                                      },
                                      borderColor: AppColor.greyLight,
                                    ),

                                    const SizedBox(height: 10),
                                    Visibility(
                                      visible: modal.controller.pricePackageController.value.text.isNotEmpty,
                                      child: MyTextField2(
                                        enabled: false,
                                          controller: modal
                                              .controller.pricePackageController.value,
                                          hintText: localization.getLocaleData.hintText!.packagePrice.toString(),
                                          borderColor: AppColor.greyLight,
                                          borderRadius: BorderRadius.zero,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return localization.getLocaleData.validationText!.enterPackagePrice.toString();
                                            }
                                          }),
                                    ),

                                    const SizedBox(height: 5),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            localization.getLocaleData.haveYouCovidTest.toString(),
                                            style: MyTextTheme().smallBCB,
                                          ),
                                          const Expanded(
                                            child: SizedBox(
                                              width: 80,
                                            ),
                                          ),
                                          Switch(
                                              value: isSwitched2,
                                              onChanged: (value) {
                                                setState(() {
                                                  isSwitched2 = value;
                                                });
                                              }),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                        visible: isSwitched2 == true,
                                        child: Column(
                                          children: [
                                            MyCustomSD(
                                                listToSearch:
                                                    modal.controller.getTestType(context),
                                                valFrom: 'test',
                                                label: localization.getLocaleData.hintText!.selectTestType.toString(),
                                                hideSearch: true,
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    modal.controller
                                                            .updateCovidTestTypeId =
                                                        value['id'] as int;
                                                  }
                                                },
                                                borderColor: AppColor.greyLight),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MyDateTimeField(
                                              controller: modal.controller
                                                  .testDateController.value,
                                              hintText: localization.getLocaleData.hintText!.selectCovidTestDate.toString(),
                                              suffixIcon: Icon(
                                                Icons.calendar_today_outlined,
                                                color: AppColor.primaryColor,
                                              ),
                                              borderColor: AppColor.greyLight,
                                              borderRadius: BorderRadius.zero,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return localization.getLocaleData.validationText!.selectADate.toString();
                                                }
                                              },
                                            ),
                                          ],
                                        )),

                                    const SizedBox(height: 5),
                                    MyTextField2(
                                      controller:
                                          modal.controller.allergyController.value,
                                      hintText: localization.getLocaleData.hintText!.anyAllergies.toString(),
                                      borderColor: AppColor.greyLight,
                                      borderRadius: BorderRadius.zero,
                                    ),

                                    const SizedBox(height: 10),
                                    MyCustomSD(
                                      listToSearch: modal.controller.getLifeSupport(context),
                                      valFrom: 'life',
                                      label: localization.getLocaleData.selectLifeSupport.toString(),
                                      hideSearch: true,
                                      onChanged: (value) {
                                        if (value != null) {
                                          modal.controller.updateLifeSupportId =
                                              value['id'] as int;
                                        }
                                      },
                                      borderColor: AppColor.greyLight,
                                    ),

                                    Visibility(
                                      visible: modal.controller.getLifeSupportId
                                              .toString() ==
                                          '2',
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MyTextField2(
                                              controller: modal
                                                  .controller.spoController.value,
                                              hintText: localization.getLocaleData.hintText!.typeO2Value.toString(),
                                              borderColor: AppColor.greyLight,
                                              borderRadius: BorderRadius.zero,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return localization.getLocaleData.validationText!.enterO2Value.toString();
                                                }
                                              }),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                    Container(
                                        // height: 680,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 10, 8, 0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 15,
                                                      child: SvgPicture.asset(
                                                        'assets/bloodPressureImage.svg',
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    localization.getLocaleData.bloodPressure.toString(),
                                                    style: MyTextTheme().smallBCB,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 0, 8, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: MyTextField2(
                                                      controller: modal.controller
                                                          .systolicController.value,
                                                      hintText: localization.getLocaleData.hintText!.systolic.toString(),
                                                      borderColor: AppColor.greyLight,
                                                      borderRadius: BorderRadius.zero,
                                                      maxLength: 3,
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: MyTextField2(
                                                      controller: modal.controller
                                                          .diastolicController.value,
                                                      hintText: localization.getLocaleData.hintText!.diastolic.toString(),
                                                      borderColor: AppColor.greyLight,
                                                      borderRadius: BorderRadius.zero,
                                                      maxLength: 3,
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 10, 8, 0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 15,
                                                      child: SvgPicture.asset(
                                                        'assets/pulseRate.svg',
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    localization.getLocaleData.pulseRate.toString(),
                                                    style: MyTextTheme().smallBCB,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 0, 8, 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: MyTextField2(
                                                      controller: modal.controller
                                                          .pulseController.value,
                                                      hintText: localization.getLocaleData.hintText!.pulseRateValue.toString(),
                                                      borderColor: AppColor.greyLight,
                                                      borderRadius: BorderRadius.zero,
                                                      maxLength: 3,
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 10, 8, 0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 15,
                                                      child: SvgPicture.asset(
                                                        'assets/temperature.svg',
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    localization.getLocaleData.temperature.toString(),
                                                    style: MyTextTheme().smallBCB,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 0, 8, 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: MyTextField2(
                                                      controller: modal
                                                          .controller
                                                          .temperatureController
                                                          .value,
                                                      hintText:
                                                          localization.getLocaleData.hintText!.temperatureValue.toString(),
                                                      borderColor: AppColor.greyLight,
                                                      borderRadius: BorderRadius.zero,
                                                      maxLength: 6,
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 10, 8, 0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 15,
                                                      child: SvgPicture.asset(
                                                        'assets/spO2.svg',
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    localization.getLocaleData.spO2.toString(),
                                                    style: MyTextTheme().smallBCB,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 0, 8, 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: MyTextField2(
                                                      controller: modal.controller
                                                          .spoController.value,
                                                      hintText: localization.getLocaleData.spO2.toString(),
                                                      borderColor: AppColor.greyLight,
                                                      borderRadius: BorderRadius.zero,
                                                      maxLength: 3,
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 10, 8, 0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 15,
                                                      child: SvgPicture.asset(
                                                        'assets/respiratoryRate.svg',
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    localization.getLocaleData.respiratoryRate.toString(),
                                                    style: MyTextTheme().smallBCB,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 0, 8, 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: MyTextField2(
                                                      controller: modal
                                                          .controller
                                                          .respiratoryController
                                                          .value,
                                                      hintText: localization.getLocaleData.respiratoryRate.toString(),
                                                      borderColor: AppColor.greyLight,
                                                      borderRadius: BorderRadius.zero,
                                                      maxLength: 3,
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        )),

                                    const SizedBox(height: 5),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyButton(
                              title: localization.getLocaleData.request.toString(),
                              onPress: () {
                                HomeModal().onPressedRequest(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
    }
}
