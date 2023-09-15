

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';
import '../VitalsChart/vitals_chart_view.dart';
import '../vital.controller.dart';
import '../vital_modal.dart';

vitalTrendsModule(context){
  ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
  VitalModal modal = VitalModal();
  AlertDialogue().show(context,msg: '',title: localization.getLocaleData.vitalTrends.toString(),newWidget: [
    GetBuilder(
        init: VitalController(),
        builder: (_) {
          return Column(
            children: [
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,height: 0.5,),
                  itemCount: modal.controller.getVitalTrends(context).length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap
                          ),
                          onPressed: () {
                            modal.controller.updateSelectVitals = modal.controller.getVitalTrends(context)[index];
                            Navigator.pop(context);
                            App().navigate(context, const VitalsChartView());
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: modal.controller.getVitalTrends(context)[index]['color'],
                                child: Center(
                                  child: SizedBox(
                                    height: 35,
                                    child: SvgPicture.asset(modal.controller.getVitalTrends(context)[index]['image']),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(modal.controller.getVitalTrends(context)[index]['tittle'],style: MyTextTheme().mediumBCN,),
                                    SvgPicture.asset('assets/arrow_forward.svg'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
              )
            ],
          );
        }
    ),
  ]);
}