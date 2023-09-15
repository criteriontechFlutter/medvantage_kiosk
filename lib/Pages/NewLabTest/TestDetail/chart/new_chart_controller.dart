import 'package:get/get.dart';

import '../../../../main.dart';
import 'DataModal/new_chart_data_modal.dart';
import 'new_chart_modal.dart';

class NewChartController extends GetxController{

  NewChartModal modal = NewChartModal();

  @override
  void onInit() {
    modal.getGraphData(NavigationService.navigatorKey.currentContext);
    super.onInit();
  }

  List _chartData = [].obs;

  List<NewGraphDataModal> get getChartData=>
      _chartData.map((element) => NewGraphDataModal.fromJson(element)).toList().obs
  ;

  set updateChartData(List val){
    _chartData=val;
    update();
  }
  RxBool showNoData = false.obs;

}