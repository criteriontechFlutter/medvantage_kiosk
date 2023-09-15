import 'package:get/get.dart';

import 'era_chart_data_modal.dart';

class EraInvestigationChartControllerss extends GetxController {




  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  List eraInvestigationChartData = [].obs;

  List<EraChartDatass> get getEraInvestigationChart =>
      List<EraChartDatass>.from(eraInvestigationChartData.map((element) =>
          EraChartDatass.fromJson(element))
      );



  List graphResult=[].obs;
  List<EraChartDatass> get getGraphResult=>List<EraChartDatass>.from(
      graphResult.map((element) => EraChartDatass.fromJson(element))
  );


  List<EraChartDatass> get getSubTests=>removeDuplicateSubTest(List<EraChartDatass>.from(
      graphResult.map((element) => EraChartDatass.fromJson(element))
  ));

  List<EraChartDatass> removeDuplicateSubTest(List<EraChartDatass> list) {
    List<EraChartDatass> output = [];
    for(int i = 0; i < list.length; i++) {
      if (output.map((e) => e.subTestID).toList().contains(list[i].subTestID)) {

      }
      else{
        output.add(list[i]);
      }

    }
    return output;
  }


  List<EraChartDatass>   getSubtestWiseGraphs(subTestName)=>List<EraChartDatass>.from(
      (
          graphResult.where(( element) => element['subTestName'].toString().trim()==subTestName.toString().trim()).toList()
      )
          .map((element) => EraChartDatass.fromJson(element))
  );







  set updateEraInvestigationChart(List val) {
    graphResult = val;

    update();
  }

  RxString selectedId = ''.obs;
  String get getSelectedId=> selectedId.value;
  set updateSelectedId(String val){
    selectedId.value=val;
    update();
  }

}