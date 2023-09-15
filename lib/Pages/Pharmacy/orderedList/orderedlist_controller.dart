import 'package:get/get.dart';

import 'DataModal/orderedlist_data_modal.dart';

class OrderedListController extends GetxController{

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }
  List myorderedList=[
    {
      'title':'Lifebuoy Total 10',
      'subtitle':'Total 10 Active Silver',
      'time':'Delivered 20 Nov 2020',
      'img':'assets/Appointments.svg',

    },
    {
      'title':'Godrej',
      'subtitle':'Total 10 Active Silver',
    'time':'Delivered 20 Nov 2020',
      'img':'assets/prescription.svg',

    },
    {
      'title':'Paracetamol',
      'subtitle':'Total 10 Active Silver',
    'time':'Delivered 20 Nov 2020',
      'img':'assets/investigation.svg',

    }

  ];
  RxInt orderDetailsId=0.obs;
  int get getOrderDetailsId=>orderDetailsId.value;
  set updateOrderDetailsId(int val){
    orderDetailsId.value=val;
    update();
  }

  List orderedList=[].obs;
  List<OrderedListDataModal> get getOrderedList=>List<OrderedListDataModal>.from(
    orderedList.map((e) => OrderedListDataModal.fromJson(e))
  );


  set updateOrderedList(List val){
    orderedList=val;
    update();
  }







// List orderedList=[].obs;
// List<OrderedListDataModal> get getOrderedList=>OrderedListDataModal.from(
//   orderedList.map((e) => OrderedListDataModal.fromJson(e))
// );
}
