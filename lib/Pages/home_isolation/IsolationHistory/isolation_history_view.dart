
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/isolation_history_controller.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/isolation_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/tab_responsive.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../Localization/app_localization.dart';
import '../DataModal/isolation_history_data_modal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'isolation_request_detail_view.dart';

class IsolationHistoryView extends StatefulWidget {
  const IsolationHistoryView({Key? key}) : super(key: key);

  @override
  State<IsolationHistoryView> createState() => _IsolationHistoryViewState();
}

class _IsolationHistoryViewState extends State<IsolationHistoryView> {
  IsolationHistoryModal modal = IsolationHistoryModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    await modal.homeIsolationRequestList(context);
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.isolationRequests.toString()),
          body: GetBuilder(
              init: IsolationHistoryController(),
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        localization.getLocaleData.homeIsolationHistory.toString(),
                        textAlign: TextAlign.center,
                        style: MyTextTheme().largeBCB,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CommonWidgets().showNoData(
                          title: localization.getLocaleData.doctorListDataNotFound.toString(),
                          show: (modal.controller.getShowNoData &&
                              modal.controller.getRequestList.isEmpty),
                          loaderTitle: localization.getLocaleData.loadingDoctorList.toString(),
                          showLoader: (!modal.controller.getShowNoData &&
                              modal.controller.getRequestList.isEmpty),
                          child: ListView(
                            children: [
                              StaggeredGrid.count(
                                children: List.generate(
                                    modal.controller.getRequestList.length, (index) {
                                  IsolationHistoryDataModal historyData =
                                      modal.controller.getRequestList[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                    child: Card(
                                      child: InkWell(
                                        onTap: () async {
                                          App().navigate(
                                              context,
                                              IsolationRequestDetailsView(
                                                requestDetail: historyData,
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 22,
                                                child: historyData
                                                            .homeIsolationStatus ==
                                                        localization.getLocaleData.pending.toString()
                                                    ? Image.asset('assets/dgicon_yellow.png')
                                                    : historyData
                                                                .homeIsolationStatus ==
                                                            localization.getLocaleData.approved.toString()
                                                        ? Image.asset('assets/dgicon_green.png')
                                                        : Image.asset('assets/dgicon_red.png'),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    historyData.name.toString(),
                                                    style: MyTextTheme().mediumBCB,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    historyData.requestedDate
                                                        .toString(),
                                                    style: MyTextTheme()
                                                        .smallBCB
                                                        .copyWith(color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              const Expanded(
                                                  child: SizedBox(
                                                width: 5,
                                              )),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 18,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                crossAxisCount:
                                    TabResponsive().isTab(context) ? 2 : 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
