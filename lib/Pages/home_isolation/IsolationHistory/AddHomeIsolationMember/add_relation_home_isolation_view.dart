



import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/home_isolation/DataModal/add_relation_isolation_data_modal.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/AddHomeIsolationMember/Module/relation_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/widgets/common_widgets.dart';
import 'add_realtion_isolation_modal.dart';
import 'add_relation_isolation_controller.dart';

class AddRelationHomeIsolationView extends StatefulWidget {
  const AddRelationHomeIsolationView({Key? key}) : super(key: key);

  @override
  State<AddRelationHomeIsolationView> createState() => _AddRelationHomeIsolationViewState();
}

class _AddRelationHomeIsolationViewState extends State<AddRelationHomeIsolationView> {
  AddRelationIsolationModal modal = AddRelationIsolationModal();

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
  }

  get() async {
    await modal.getRelationIsolationData(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<AddRelationIsolationController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization = Provider.of<ApplicationLocalizations>(context,listen: true);
    return  Container(
      color: AppColor.primaryColor,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.alertsOn.toString()),
            body:GetBuilder(
                init: AddRelationIsolationController(),
                builder: (_) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Container( alignment: AlignmentDirectional.topStart,
                            child: Text(localization.getLocaleData.addMobileNumbersForAlerts.toString(), style: MyTextTheme().largeBCB,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(onTap: (){
                                relationModule(context,localization.getLocaleData);
                              },
                                child: MyTextField2(
                                  controller:modal.controller.relationC.value,
                                  hintText: localization.getLocaleData.enterYourRelation.toString(),
                                  borderColor: AppColor.greyLight,
                                  borderRadius: BorderRadius.zero,
                                  enabled: false,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: MyTextField2(
                                controller:modal.controller.mobileC.value,
                                hintText: localization.getLocaleData.enterYourMobileNo.toString(),
                                borderColor: AppColor.greyLight,
                                borderRadius: BorderRadius.zero,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                enabled: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: MyButton(onPress: (){
                            if (modal.controller.relationC.value!="" && modal.controller.mobileC.value.text!=''){
                              modal.addRelationIsolationData(context);
                              modal.controller.mobileC.value.clear();
                            }else{
                              alertToast(context, localization.getLocaleData.pleasFillAllFields.toString());
                            }

                          },
                            title: localization.getLocaleData.save.toString(),
                            width: 120,
                          ),
                        ),
                      ),
                      if (modal.controller.getIsolationPatientList.length !=0)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Container(alignment: AlignmentDirectional.topStart,
                              child: Text(localization.getLocaleData.listYourRelation.toString(), style: MyTextTheme().largeBCB,)),
                        ),
                      Expanded(
                        flex: 15,
                        child:CommonWidgets().showNoData(
                          title: localization.getLocaleData.list.toString(),
                          show: false,
                          loaderTitle: localization.getLocaleData.loading.toString(),
                          showLoader: (!modal.controller.getShowNoData &&
                              modal.controller.getIsolationPatientList.isEmpty),
                          child: ListView.builder(
                              padding: const EdgeInsets.all(10),
                              itemCount: modal.controller.getIsolationPatientList.length,
                              itemBuilder: (BuildContext context, int index) {
                                AddRelationIsolationDataModal isolationRelationData =
                                modal.controller.getIsolationPatientList[index];
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,10),
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    color: AppColor.lightBlue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Text((index+1).toString() +".",style: MyTextTheme().mediumBCB),
                                          SizedBox(width: 30),
                                          Expanded(child: Text(isolationRelationData.relation.toString(),style: MyTextTheme().mediumBCB)),
                                          SizedBox(width: 40),
                                          Expanded(child: Text(isolationRelationData.mobileNo.toString(),style: MyTextTheme().mediumBCB)),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                              child: InkWell(
                                                onTap: (){
                                                  AlertDialogue().show(context);
                                                  modal.deleteRelationIsolationData(context, (isolationRelationData.id)?? 0);

                                                },
                                                child: Container(
                                                  alignment: Alignment.topRight,
                                                    child: SvgPicture.asset('assets/delete.svg')),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          )
      ),
    );
  }
}
