import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/radiology/RadiologyReports/radiology_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/in_app_webview.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../AppManager/widgets/common_widgets/new_shimmer_effect.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../Localization/app_localization.dart';
import '../../DataModal/radiology_data_modal.dart';

class RadiologyReportView extends StatelessWidget {
  const RadiologyReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RadiologyReportController controller = Get.put(RadiologyReportController());
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
          child: Scaffold(
            appBar:MyWidget().myAppBar(context,title:localization.localeData!.testReport),
            body: SizedBox(
              child: GetBuilder<RadiologyReportController>(builder: (_) {
                return Get.arguments["type"]==3? ShimmerEffect(
                  loading:!controller.getShowNoData&&controller.getRadiologyReportList.isEmpty,noData:controller.getShowNoData&&controller.getRadiologyReportList.isEmpty,
                  child: ListView.separated(
                    itemCount: controller.getRadiologyReportList.length,
                    physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    separatorBuilder: ((_, index) => const SizedBox(height: 10,)),
                    itemBuilder: ((_, index) {
                      final reportsData = controller.getRadiologyReportList[index];
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          //controller.updateIsExpand = !controller.getIsExpand;
                          controller.updateExpandedList(index,!controller.getExpandedList[index]);
                          //print(controller.getExpandedList[index]);
                        },
                        child: AnimatedContainer(
                          margin: EdgeInsets.symmetric(
                            horizontal: controller.getExpandedList[index] ? 25 : 0,
                            vertical: 20,
                          ),
                          padding: const EdgeInsets.all(20),
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(milliseconds: 1200),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.primaryColor.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(5, 10),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(controller.getExpandedList[index] ? 20 : 0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          reportsData.itemName.toString(),
                                          style: MyTextTheme().largeBCB,
                                        ),
                                        Row(
                                          children: [
                                            Text("Result :  ",
                                              style: MyTextTheme().mediumBCB,),
                                            Expanded(child: Text(reportsData.result.toString(),style:const TextStyle(fontWeight: FontWeight.w500))),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Test Time :  ",
                                              style: MyTextTheme().mediumBCB,),
                                            Text(reportsData.testTime.toString(),style:const TextStyle(fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Date :  ",
                                              style: MyTextTheme().mediumBCB,),
                                            Text(reportsData.collectionDate!.substring(0, reportsData.collectionDate!.indexOf('T')).toString(),style:const TextStyle(fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Bill no :  ",
                                              style: MyTextTheme().mediumBCB,),
                                            Text(reportsData.billNo.toString(),style:const TextStyle(fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    controller.getExpandedList[index]
                                        ? Icons.keyboard_arrow_down
                                        : Icons.keyboard_arrow_up,
                                    color: Colors.grey,
                                    size: 27,
                                  ),
                                ],
                              ),
                              controller.getExpandedList[index] ?const SizedBox() : const SizedBox(
                                  height: 20),
                              AnimatedCrossFade(
                                firstChild:const SizedBox(),
                                secondChild: Html(
                                  data: reportsData.resultRemark,
                                ),
                                crossFadeState: controller.getExpandedList[index]
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 1200),
                                reverseDuration: Duration.zero,
                                sizeCurve: Curves.fastLinearToSlowEaseIn,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    ),
                  ),
                )
                    :
                ShimmerEffect(
                  loading:!controller.getShowNoData&&controller.getRadiologyList.isEmpty,noData:controller.getShowNoData&&controller.getRadiologyList.isEmpty,
                  child: ListView.builder(
                    itemCount: controller.getRadiologyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      RadiologyDataModal radiologyData = controller.getRadiologyList[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                          child: Row(
                            children: [
                              Text(
                                '${index + 1} .',
                                style: MyTextTheme().mediumBCB,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${UserData().getUserName} ( ${UserData().getUserPid} )',
                                style: MyTextTheme().mediumBCB,
                              ),
                              const Expanded(
                                  child: SizedBox(
                                    width: 5,
                                  )),
                              InkWell(
                                onTap: () {
                                  Get.to(()=>InAppWebViewScreen(
                                      myUrl: radiologyData.pacsURL.toString()));
                                  // App().navigate(
                                  //     context,
                                  //     InAppWebViewScreen(
                                  //         myUrl: radiologyData.pacsURL.toString()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
                ;
              }),
            ),
          )
      ),
    );
  }
}
