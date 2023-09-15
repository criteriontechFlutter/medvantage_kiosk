
import 'package:get/get.dart';

class FilterProductController extends GetxController{

  List filterOptions = [
    {
      'filterType':'Select Categories'
    },
    {
      'filterType':'Brands'
    },
    {
      'filterType':'Discounts'
    },
    {
      'filterType':'Price Range'
    },
    {
      'filterType':'Product Form'
    },
    {
      'filterType':'Uses'
    },

  ].obs;

}