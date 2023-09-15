import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'app_color.dart';
import 'my_text_theme.dart';

// FactsCount factsC=Get.put(FactsCount());



late BuildContext currentContext;


class ProgressDialogue{



  // final MyProgressController pressController = Get.put(MyProgressController ());





  show(context, {
   required String loadingText,
  }) async{

   // factsC.updateFactCount();
   // pressController.changeValue(true);
     showProgressDialogue(context,loadingText);
  }



  hide() async{
    try{
       Navigator.pop(currentContext);
    }
    catch (e){
      print(e);
    }
    // if(pressController.readValue().value){
    //   Navigator.pop(currentContext);
    //   pressController.changeValue(false);
    // }
  }


}





showProgressDialogue(context,loadingText,) async{
  // var canPressOk=true;
  // blankScreen(context,loadingText);
  return    showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext dialogContext) {

      currentContext= dialogContext;
      return WillPopScope(
        onWillPop: (){
          ProgressDialogue().hide();
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              color: Colors.black54,
              child:     Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                              height: 100,
                              child: Lottie.asset('assets/loader.json')),
                        ),
                        Text(loadingText?? 'Default',
                          style: MyTextTheme().mediumWCB),
                        // factsDialogue(),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      );
    },
  );
}





class ProgressDialogue2{

  final MyProgressController pressController = Get.put(MyProgressController ());




  show(context,{
    loadingText,
}){
    pressController.changeValue(true);
    showProgressDialogue2(context,loadingText);
  }



  hide(
    context,
  ){
    if(pressController.readValue().value){
      Navigator.pop(context);
      pressController.changeValue(false);
    }
  }


}





showProgressDialogue2(context,loadingText,){
  // var canPressOk=true;
  // blankScreen(context,loadingText);
  return    showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: (){
          ProgressDialogue().hide();
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: Colors.transparent,

            body: GestureDetector(
              onTap: (){

              },
              child: Container(
                color: Colors.black54,
                child:     Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    LinearProgressIndicator(
                      valueColor:  AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                      backgroundColor: Colors.white,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,15,30,15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: Text(loadingText??'Default Text',
                                    style: MyTextTheme().mediumWCB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      );
    },
  );
}




class MyProgressController extends GetxController {
  var canPop = false .obs;

  readValue(){
     return canPop;
  }

  changeValue(val){
    canPop=RxBool(val);
   // update();
  }


}