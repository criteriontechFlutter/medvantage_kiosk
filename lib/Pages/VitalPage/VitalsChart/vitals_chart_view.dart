import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/VitalPage/VitalsChart/vital_chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../DataModal/vital_history_data_model.dart';
import 'vital_chart_modal.dart';
import '../vital_modal.dart';

class VitalsChartView extends StatefulWidget {
  const VitalsChartView({Key? key}) : super(key: key);

  @override
  _VitalsChartViewState createState() => _VitalsChartViewState();
}

class _VitalsChartViewState extends State<VitalsChartView> {

  VitalChartModal modal = VitalChartModal();

  VitalModal vitalHistoryModal = VitalModal();

  @override
  void initState() {
    // TODO: implement initState
    get();
setState(() {

});
    super.initState();
  }

  get()async{
   await  modal.getVitalsData(context);
  }
  @override
  void dispose() {
    Get.delete<VitalChartController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: MyWidget().myAppBar(context,title: localization.getLocaleData.vitalChart.toString()),
          body: GetBuilder(
              init: VitalChartController(),
              builder: (_){
              return ((modal.controller.showNoData.value) && (modal.controller.getVitalData.isEmpty) )?CommonWidgets().showNoData(show: true):Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CommonWidgets().shimmerEffect(
                      shimmer: vitalHistoryModal.controller.getSelectVitals['id']==-1?
                      (modal.controller.getSystolic.isEmpty && modal.controller.getDiastolic.isEmpty) : modal.controller.getChartData.isEmpty ,
                      child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                          dateFormat: DateFormat('dd/MM/yyyy\nhh:mm'),
                           desiredIntervals: 10,
                           //interval: 40,
                            autoScrollingDelta: 200
                           //intervalType: DateTimeIntervalType.days
                        ),
                        enableAxisAnimation: true,
                        title: ChartTitle(
                          text: vitalHistoryModal.controller.getSelectVitals['tittle'].toString(),backgroundColor: vitalHistoryModal.controller.getSelectVitals['iconColor'],alignment:ChartAlignment.near,textStyle: MyTextTheme().smallWCB,borderWidth:1.8
                        ),
                        legend: Legend(isVisible: true,position: LegendPosition.bottom,),
                        tooltipBehavior: TooltipBehavior(enable: true,color: AppColor.white,textStyle: const TextStyle(
                          color: Colors.black,
                        )),
                        series:

                  vitalHistoryModal.controller.getSelectVitals['id']==-1?
                        [
                          LineSeries<VitalsData,DateTime>(dataSource: List.generate(modal.controller.getSystolic.length, (index){

                            VitalChartData vital=modal.controller.getSystolic[index];
                              return VitalsData(DateTime.parse(
                                  DateFormat('dd MMM yyyy, hh:mma').parse( vital.vitalDate.toString()).toString()
                              ),  double.parse(vital.vitalValue.toString()));



                          }),
                              markerSettings:  MarkerSettings(
                                  isVisible: true,color: Colors.deepPurpleAccent,borderColor: vitalHistoryModal.controller.getSelectVitals['color']
                              ),
                          enableTooltip: true,
                          color: Colors.deepPurpleAccent,
                              //dataLabelSettings:const DataLabelSettings(isVisible: true),
                          name: localization.getLocaleData.hintText!.systolic.toString(),
                          xValueMapper: (VitalsData vi, _) => vi.date,
                          yValueMapper: (VitalsData sales, _) => sales.value),
                          //Second graph line Diastoic
                          LineSeries<VitalsData,DateTime>(dataSource: List.generate(modal.controller.getDiastolic.length, (index){

                            VitalChartData vital=modal.controller.getDiastolic[index];
                            return VitalsData(DateTime.parse(
                                DateFormat('dd MMM yyyy, hh:mma').parse( vital.vitalDate.toString()).toString()
                            ),  double.parse(vital.vitalValue.toString()));


                          }),
                              markerSettings:  MarkerSettings(
                                  isVisible: true,color: Colors.orangeAccent,borderColor: vitalHistoryModal.controller.getSelectVitals['color']
                              ),
                              enableTooltip: true,
                              color: Colors.orangeAccent,
                              //dataLabelSettings:const DataLabelSettings(isVisible: true),
                              name: localization.getLocaleData.hintText!.diastolic.toString(),
                              xValueMapper: (VitalsData sales, _) => sales.date,
                              yValueMapper: (VitalsData sales, _) => sales.value),
                        ] : [
                      LineSeries<VitalsData,DateTime>(dataSource: List.generate(modal.controller.getChartData.length, (index){

                        VitalChartData vital=modal.controller.getChartData[index];
                        return VitalsData(DateTime.parse(
                            DateFormat('dd MMM yyyy, hh:mma').parse( vital.vitalDate.toString()).toString()
                        ),  double.parse(vital.vitalValue.toString()));



                      }),
                          markerSettings:  MarkerSettings(
                              isVisible: true,color: vitalHistoryModal.controller.getSelectVitals['iconColor'],borderColor: vitalHistoryModal.controller.getSelectVitals['color']
                          ),
                          enableTooltip: true,
                          color: vitalHistoryModal.controller.getSelectVitals['iconColor'],
                          dataLabelSettings:const DataLabelSettings(isVisible: true),
                          name: vitalHistoryModal.controller.getSelectVitals['tittle'].toString(),
                          xValueMapper: (VitalsData sales, _) => sales.date,
                          yValueMapper: (VitalsData sales, _) => sales.value),
                  ],
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.getLocaleData.history.toString(),style: MyTextTheme().mediumBCB,),
                        Visibility(
                          visible: vitalHistoryModal.controller.getSelectVitals['id']==-1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 7,width: 7,
                                    decoration: BoxDecoration(
                                      color: AppColor.red,
                                      shape: BoxShape.circle
                                    ),
                                  ),
                                  const SizedBox(width: 4,),
                                  Text(localization.getLocaleData.mmHgHigher.toString(),style: MyTextTheme().smallBCN,)
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 7,width: 7,
                                    decoration: BoxDecoration(
                                        color: AppColor.orangeButtonColor,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                  const SizedBox(width: 4,),
                                  Text(localization.getLocaleData.mmHgLower.toString(),style: MyTextTheme().smallBCN,)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Expanded(
                        child: ListView.separated(
                          itemCount: vitalHistoryModal.controller.getSelectVitals['id']==-1? modal.controller.getBp.length :modal.controller.getChartData.length,
                          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,),
                            itemBuilder: (BuildContext context, int index){

                              VitalChartData bpData = (vitalHistoryModal.controller.getSelectVitals['id']==-1? modal.controller.getBp :modal.controller.getChartData)
                                  .isEmpty ?
                              VitalChartData() :((vitalHistoryModal.controller.getSelectVitals['id']==-1? modal.controller.getBp :modal.controller.getChartData))[index];

                            return CommonWidgets().shimmerEffect(
                              shimmer:vitalHistoryModal.controller.getSelectVitals['id']==-1? modal.controller.getBp.isEmpty : modal.controller.getChartData.isEmpty,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(bpData.vitalDate.toString(),style: MyTextTheme().smallBCN,),
                                    Text(bpData.vitalValue.toString(),style: MyTextTheme().smallBCB,)
                                  ],
                                ),
                              ),
                            );
                            },

                            ),

                    )
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }



}







class VitalsData{
  final DateTime date;
  final double value;

  VitalsData(this.date,this.value);
}
