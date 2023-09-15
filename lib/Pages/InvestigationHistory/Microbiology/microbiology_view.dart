
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/Microbiology/MicrobiologyReports/microbiology_report_view.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/Microbiology/microbiology_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../AppManager/widgets/common_widgets/new_shimmer_effect.dart';
import '../../../AppManager/widgets/customInkWell.dart';
import '../investigation_controller.dart';

class MicrobiologyView extends StatelessWidget {
  const MicrobiologyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InvestigationController controller = Get.find();
    return  SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              GetBuilder<InvestigationController>(builder: (_) {
                return Flexible(
                  child: ShimmerEffect(loading:!controller.getShowNoData&&controller.getMicrobiologyList.isEmpty,noData:controller.getShowNoData&&controller.getMicrobiologyList.isEmpty ,
                    child: ListView.separated(
                      itemCount: controller.getMicrobiologyList.length,
                      separatorBuilder: ((_, index) => const SizedBox(height: 15,)),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: ((_, index) {
                        MicrobiologyDataModel microbiologyData = controller
                            .getMicrobiologyList[index];
                        return CustomInkwell(onPress: () {
                          Get.to(()=>const MicrobiologyReportView(),arguments: {
                            "billNo":microbiologyData.labReportNo
                          });
                        },
                          borderRadius: 10,
                          elevation: 3,
                          shadowColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("${microbiologyData.subCategoryName} (${microbiologyData.itemName})",
                                  style: MyTextTheme().mediumBCB,),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Report No.",
                                      style: MyTextTheme().mediumGCB,),
                                    Text(microbiologyData.labReportNo.toString(),
                                      style: MyTextTheme().mediumGCB,),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Date",
                                      style: MyTextTheme().mediumGCB,),
                                    Text(microbiologyData.collectionDateFormatted.toString(),
                                      style: MyTextTheme().mediumGCB,),
                                  ],
                                ),
                              ],
                            ),
                          ),);
                      }),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      );

  }
}
