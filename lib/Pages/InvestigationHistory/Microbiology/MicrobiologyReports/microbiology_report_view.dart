
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/Microbiology/MicrobiologyReports/microbiology_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/widgets/common_widgets/new_shimmer_effect.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../Localization/app_localization.dart';

class MicrobiologyReportView extends StatelessWidget {
  const MicrobiologyReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MicrobiologyReportController controller = Get.put(MicrobiologyReportController());
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
          child: Scaffold(
            appBar:MyWidget().myAppBar(context,title:localization.localeData!.testReport),
            body: SizedBox(
              child: GetBuilder<MicrobiologyReportController>(builder: (_) {
                return ShimmerEffect(
                  loading:!controller.getShowNoData&&controller.getMicrobiologyReportList.isEmpty,noData:controller.getShowNoData&&controller.getMicrobiologyReportList.isEmpty,
                  child: ListView.separated(
                    itemCount: controller.getMicrobiologyReportList.length,
                    physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    separatorBuilder: ((_, index) => const SizedBox(height: 10,)),
                    itemBuilder: ((_, index) {
                      final reportsData = controller.getMicrobiologyReportList[index];
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.updateExpandedList(index,!controller.getExpandedList[index]);
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
                                        // Row(
                                        //   children: [
                                        //     Text("Date :  ",
                                        //       style: MyTextTheme().mediumBCB,),
                                        //     Text(reportsData.collectionDate!.substring(0, reportsData.collectionDate!.indexOf('T')).toString(),style:const TextStyle(fontWeight: FontWeight.w500)),
                                        //   ],
                                        // ),
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
                );
              }),
            ),
          )
      ),
    );
  }
}
