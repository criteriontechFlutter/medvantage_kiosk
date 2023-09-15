import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/date_time_field.dart';
import 'package:digi_doctor/Pages/SymptomTracker/SymtomsHistory/symptom_history_controller.dart';
import 'package:digi_doctor/Pages/SymptomTracker/SymtomsHistory/symptom_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/tab_responsive.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../DataModal/symptom_history_data_modal.dart';

class SymptomHistoryView extends StatefulWidget {
  const SymptomHistoryView({Key? key}) : super(key: key);

  @override
  State<SymptomHistoryView> createState() => _SymptomHistoryViewState();
}

class _SymptomHistoryViewState extends State<SymptomHistoryView> {
  SymptomHistoryModal modal = SymptomHistoryModal();

  get() async {
    modal.controller.dateFromC.value.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 30)));
    modal.controller.dateToC.value.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    await  modal.getPatientSymptomDateWiseHistory(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    get();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SymptomHistoryController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.symptomHistory.toString()),
        body: GetBuilder(
          init: SymptomHistoryController(),
          builder: (_) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TabResponsive().wrapInTab(
                      context: context,
                      child: Row(
                        children: [
                          Expanded(
                              child: MyDateTimeField(
                            controller: modal.controller.dateFromC.value,
                            hintText: localization.getLocaleData.hintText!.fromDate.toString(),
                                onChanged: (val) async {
                                 await modal.getPatientSymptomDateWiseHistory(context);
                                },
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: MyDateTimeField(
                            controller: modal.controller.dateToC.value,
                            hintText: localization.getLocaleData.hintText!.toDate.toString(),
                                onChanged: (val) async {
                                  await modal.getPatientSymptomDateWiseHistory(context);
                                },
                          )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: AppColor.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            localization.getLocaleData.problemName.toString(),
                            textAlign: TextAlign.center,
                            style: MyTextTheme().mediumBCB,
                          )),
                          Expanded(
                              child: Text(
                            localization.getLocaleData.attributeValue.toString(),
                            textAlign: TextAlign.center,
                            style: MyTextTheme().mediumBCB,
                          )),
                          Expanded(
                              child: Text(
                            localization.getLocaleData.problemDate.toString(),
                            textAlign: TextAlign.center,
                            style: MyTextTheme().mediumBCB,
                          )),
                          Expanded(
                              child: Text(
                            localization.getLocaleData.problemTime.toString(),
                            textAlign: TextAlign.center,
                            style: MyTextTheme().mediumBCB,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CommonWidgets().showNoData(
                        title: localization.getLocaleData.symptomHistoryNotFound.toString(),
                        show: (modal.controller.getShowNoData &&
                            modal.controller.getSymptomDataList.isEmpty),
                        loaderTitle: localization.getLocaleData.loadingSymptomHistory.toString(),
                        showLoader: (!modal.controller.getShowNoData &&
                            modal.controller.getSymptomDataList.isEmpty),
                        child: ListView.builder(
                          itemCount: modal.controller.getSymptomDataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            SymptomsHistoryDataModal symptomData= modal.controller.getSymptomDataList[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,10,0),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                color: AppColor.white,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              symptomData.problemName.toString(),
                                          textAlign: TextAlign.center,
                                          style: MyTextTheme()
                                              .smallBCB
                                              .copyWith(color: AppColor.greyDark),
                                        )),
                                        Expanded(
                                            child: Text(
                                              symptomData.attributeName.toString(),
                                          textAlign: TextAlign.center,
                                          style: MyTextTheme()
                                              .smallBCB
                                              .copyWith(color: AppColor.greyDark),
                                        )),
                                        Expanded(
                                            child: Text(
                                              symptomData.problemDate.toString(),
                                          textAlign: TextAlign.center,
                                          style: MyTextTheme()
                                              .smallBCB
                                              .copyWith(color: AppColor.greyDark),
                                        )),
                                        Expanded(
                                            child: Text(
                                              symptomData.problemTime.toString(),
                                          textAlign: TextAlign.center,
                                          style: MyTextTheme()
                                              .smallBCB
                                              .copyWith(color: AppColor.greyDark),
                                        )),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
