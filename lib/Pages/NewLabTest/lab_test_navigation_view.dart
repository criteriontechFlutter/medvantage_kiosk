import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/widgets/MyCustomSD.dart';
import '../../AppManager/widgets/customInkWell.dart';
import '../../AppManager/widgets/my_app_bar.dart';
import 'DataModal/lab_test_data_modal.dart';
import 'TestDetail/new_test_detail_view.dart';
import 'lab_test_navigation_controller.dart';
import 'lab_test_navigation_modal.dart';
import 'package:get/get.dart';

class LabTestNavigationView extends StatefulWidget {
  final isShowAppBar;
  const LabTestNavigationView({Key? key, required this.isShowAppBar}) : super(key: key);

  @override
  State<LabTestNavigationView> createState() => _LabTestNavigationViewState();
}

class _LabTestNavigationViewState extends State<LabTestNavigationView> {
  LabTestNavigationModal modal = LabTestNavigationModal();

  @override
  void initState() {
    modal.onEnterPage(context);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LabTestNavigationController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
           // backgroundColor: Colors.white,
            appBar:!widget.isShowAppBar? const PreferredSize(
              preferredSize: Size.fromHeight(100.0), child: SizedBox(),):MyWidget().myAppBar(context, title: "Lab Reports"),
            body: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyCustomSD(
                      valFrom: 'name',
                      label: "Select time",
                      initialValue: [
                        {
                          'parameter': 'name',
                          'value': modal.controller.dropDownDateList[1]['name']
                              .toString(),
                        },
                      ],
                      listToSearch: modal.controller.dropDownDateList,
                      height: 100,
                      onChanged: (value) {
                        modal.controller.selectTime.value =
                            value['id'].toString();
                        modal.onEnterPage(context);
                      },
                      prefixIcon: Icons.calendar_month,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GetBuilder(
                        init: LabTestNavigationController(),
                        builder: (_) {
                          return Flexible(
                            child: Center(
                                child: CommonWidgets().showNoData(
                                  loaderTitle: "loading...",
                                  showLoader: !modal.controller.showNoData.value,
                                  show: modal.controller.showNoData.value &&
                                      modal.controller.getEraInvestigationList
                                          .isEmpty,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics()),
                                    itemCount:modal.controller.getEraInvestigationList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      InvestigationListDataModal reportData = modal
                                          .controller
                                          .getEraInvestigationList[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: CustomInkwell(
                                          onPress: () {
                                            Get.to(() => const NewTestDetailView(),
                                                arguments: [
                                                  reportData.categoryID,
                                                  reportData
                                                      .collectionDateFormatted,
                                                  reportData.subCategoryID
                                                ]);
                                          },
                                          elevation: 3,
                                          borderRadius: 10,
                                          shadowColor: Colors.grey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Lab Report No : ",
                                                      style:
                                                      MyTextTheme().mediumBCB,
                                                    ),
                                                    Text(
                                                        reportData.billNo
                                                            .toString(),
                                                        style: MyTextTheme()
                                                            .mediumBCB),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                IntrinsicHeight(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        reportData
                                                            .collectionDateFormatted
                                                            .toString(),
                                                        style:
                                                        MyTextTheme().mediumGCB,
                                                      ),
                                                      VerticalDivider(
                                                          color: AppColor.greyLight,
                                                          thickness: 1),
                                                      Expanded(
                                                          child: Text(
                                                            reportData.categoryName
                                                                .toString(),
                                                            style:
                                                            MyTextTheme().mediumGCB,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                          );
                        })
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
