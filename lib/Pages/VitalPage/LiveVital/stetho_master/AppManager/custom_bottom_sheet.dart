import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'app_color.dart';

class CustomBottomSheet {


  static dynamic open(context,{
    Widget? child,
    bool ? isDismissible,
  }) async{
    var data= await showBarModalBottomSheet (
      context: context,
       isDismissible: isDismissible ?? true,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: child??Container(
            color: AppColor.primaryColorLight,
          ),
        ),
      ),
    );
    return data;
  }



}