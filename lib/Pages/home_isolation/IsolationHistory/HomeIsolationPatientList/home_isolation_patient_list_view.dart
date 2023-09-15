


import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/home_isolation/DataModal/home_isolation_patient_list_data_modal.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/HomeIsolationPatientList/home_isolation_patient_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';

import 'home_isolation_patient_list_controller.dart';


class HomeIsolationPatientListView extends StatefulWidget {
  const HomeIsolationPatientListView({Key? key}) : super(key: key);


  @override
  State<HomeIsolationPatientListView> createState() => _HomeIsolationPatientListViewState();
}

class _HomeIsolationPatientListViewState extends State<HomeIsolationPatientListView> {

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
  }

  get() async {
    await modal.getHomeIsolationPatientList(context);
  }

  HomeIsolationPatientListModal modal = HomeIsolationPatientListModal();

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.homeIsolatedPatientList.toString()
          ),
          body: GetBuilder(
              init: HomeIsolationPatientListController(),
              builder: (_) {
                return Center(
                    child: CommonWidgets().showNoData(
                      title: localization.getLocaleData.dataNotFound.toString(),
                      show: (modal.controller.getShowNoData &&
                          modal.controller.getIsolationPatientList.isEmpty),
                      loaderTitle: localization.getLocaleData.loading.toString(),
                      showLoader: (!modal.controller.getShowNoData &&
                          modal.controller.getIsolationPatientList.isEmpty),
                      child: ListView(
                        children: [
                          StaggeredGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 0.0,
                            crossAxisCount: MediaQuery.of(context).size.width>600? 2:1,
                            children: List.generate(
                                modal.controller.getIsolationPatientList.length,
                                    (index) {
                                  HomeIsolationPatientListDataModal isolationData =
                                  modal.controller.getIsolationPatientList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Card(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      isolationData.name
                                                          .toString(),
                                                      style: MyTextTheme().mediumBCB,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      isolationData.hospitalName
                                                          .toString(),
                                                      style: MyTextTheme().mediumBCB.copyWith(fontSize:12 ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      isolationData.packageName
                                                          .toString(),
                                                      style: MyTextTheme().smallBCN,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(isolationData
                                                            .requestedDate
                                                            .toString(),
                                                          style: MyTextTheme().mediumBCN,
                                                        ),
                                                        isolationData.homeIsolationStatus  ==
                                                            "Declined"
                                                            ? Container(
                                                          width: 100,
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor.red,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  15)),
                                                          child: Text(
                                                            isolationData.homeIsolationStatus.toString(),
                                                            textAlign:
                                                            TextAlign.center,
                                                            style: MyTextTheme()
                                                                .smallWCB,
                                                          ),
                                                        )
                                                            : isolationData
                                                            .homeIsolationStatus ==
                                                            "Approved"
                                                            ? Container(
                                                          width: 100,
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              10,
                                                              vertical:
                                                              5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  15)),
                                                          child: Center(
                                                            child: Text(
                                                              isolationData.homeIsolationStatus.toString(),
                                                              style:
                                                              MyTextTheme()
                                                                  .smallWCB,
                                                            ),
                                                          ),
                                                        )
                                                            : Container(
                                                          width: 100,
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              10,
                                                              vertical:
                                                              5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .orangeColorDark,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  15)),
                                                          child: Center(
                                                            child: Text(
                                                              isolationData.homeIsolationStatus.toString(),
                                                              style:
                                                              MyTextTheme()
                                                                  .smallWCB,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ));
              }),
        ),
      ),
    );
  }
}
