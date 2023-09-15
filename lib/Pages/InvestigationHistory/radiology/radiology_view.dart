import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/radiology/radiology_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../AppManager/widgets/common_widgets/new_shimmer_effect.dart';
import '../../../AppManager/widgets/customInkWell.dart';
import '../investigation_controller.dart';
import 'RadiologyReports/radiology_report_view.dart';

class RadiologyView extends StatelessWidget {
  const RadiologyView({Key? key}) : super(key: key);

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
                  child: ShimmerEffect(loading:!controller.getShowNoData&&controller.getRadiologyReportList.isEmpty,noData:controller.getShowNoData&&controller.getRadiologyReportList.isEmpty ,
                    child: ListView.separated(
                      itemCount: controller.getRadiologyReportList.length,
                      separatorBuilder: ((_, index) => const SizedBox(height: 15,)),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: ((_, index) {
                        RadiologyDataModel radiologyData = controller
                            .getRadiologyReportList[index];
                        return CustomInkwell(onPress: () {
                          Get.to(()=>const RadiologyReportView(),arguments: {"collectionDate":radiologyData.collectionDateFormatted,
                            "subCategoryID":radiologyData.subCategoryID,
                            "categoryID":radiologyData.categoryID,
                            "type":radiologyData.type
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
                                Text("${radiologyData.subCategoryName} (${radiologyData.itemNames})",
                                  style: MyTextTheme().mediumBCB,),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("Report No.",
                                      style: MyTextTheme().mediumGCB,),
                                    Text(radiologyData.labReportNo.toString(),
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
                                    Text(radiologyData.collectionDateFormatted.toString(),
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
