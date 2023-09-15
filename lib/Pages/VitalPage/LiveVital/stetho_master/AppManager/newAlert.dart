import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/tab_responsive.dart';
import 'app_color.dart';
import 'my_text_theme.dart';

class NewAlertDialog {

  show(context,
      {
        String? alert,
        String? msg,
        String? firstButtonName,
        Function? firstButtonPressEvent,
        String?  secondButtonName,
        Function? secondButtonPressEvent,
        bool? showCancelButton,
        bool? showOkButton,
        bool? disableDuration,
        bool? checkIcon,
        bool? hideIcon,
        bool? centerTitle,
        Widget? newWidget,
        List<Widget>? fullScreenWidget,
        String? title,
        String? subTitle,
      }
      )  {
    var canPressOk=true;
    return WidgetsBinding.instance.addPostFrameCallback((_){

      showGeneralDialog(
          barrierColor: Colors.white.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return StatefulBuilder(
                builder: (context,setState)
                {
                  return Transform.scale(
                    scale: a1.value,
                    child: Opacity(
                      opacity: a1.value,
                      child: WillPopScope(
                        onWillPop: (){
                          Navigator.pop(context);
                          return Future.value(false);
                        },
                        child: SafeArea(
                          child: Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: (fullScreenWidget!=null)?
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Container(

                                  decoration: BoxDecoration(
                                      color: AppColor.bgColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(color: AppColor.white)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Visibility(
                                          visible: title!=null,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(title.toString(),
                                                      style: MyTextTheme().mediumWCB,),
                                                    Visibility(
                                                        visible: subTitle!=null,
                                                        child: Text(subTitle.toString(),
                                                          style: MyTextTheme().mediumWCB,)
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(onPressed: (){
                                                if(canPressOk)
                                                {
                                                  canPressOk=false;
                                                  Navigator.pop(context);
                                                }
                                              }, icon: const Icon(Icons.clear,
                                                color: Colors.white,))
                                            ],
                                          ),
                                        ),
                                        ListView(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          children: fullScreenWidget,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                                  :TabResponsive().wrapInTab(
                                context: context,
                                child: newWidget==null?
                                Container(

                                  height: double.infinity,
                                  width: double.infinity,
                                  alignment: Alignment.center,

                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(40,20,40,20),
                                        child: Container(
                                            decoration:   BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                              border: Border.all(color: Colors.white , width: 3)
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(msg.toString(),
                                                          textAlign: TextAlign.center,
                                                          style:  MyTextTheme().mediumWCB),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,0,40,0,),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Visibility(
                                                              visible: showCancelButton?? false,
                                                              child: TextButton(
                                                                style: TextButton.styleFrom(
                                                                  primary: Colors.white,
                                                                  padding: const EdgeInsets.all(8),
                                                                ),
                                                                onPressed: () {
                                                                  if(canPressOk)
                                                                  {
                                                                    canPressOk=false;
                                                                    Navigator.pop(context);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'Cancel',
                                                                  style: TextStyle(color: AppColor.white,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: secondButtonName!=null,
                                                              child: TextButton(
                                                                style: TextButton.styleFrom(
                                                                  primary: Colors.white,
                                                                  padding: const EdgeInsets.all(8),
                                                                ),
                                                                onPressed: () {
                                                                  if(canPressOk)
                                                                  {
                                                                    canPressOk=false;
                                                                    secondButtonPressEvent!();
                                                                  }
                                                                },
                                                                child: Text(
                                                                  secondButtonName.toString(),
                                                                  style: TextStyle(color: AppColor.white,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: firstButtonName!=null,
                                                              child: TextButton(
                                                                style: TextButton.styleFrom(
                                                                  primary: Colors.white,
                                                                  padding: const EdgeInsets.all(8),
                                                                ),
                                                                onPressed: () {
                                                                  if(canPressOk)
                                                                  {
                                                                    canPressOk=false;
                                                                    firstButtonPressEvent!();
                                                                  }
                                                                },
                                                                child: Text(
                                                                  firstButtonName.toString(),
                                                                  style: TextStyle(color: AppColor.white,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: showOkButton ?? true,
                                                              child: TextButton(

                                                                style: TextButton.styleFrom(
                                                                  alignment: showCancelButton==true ?  Alignment.centerRight: Alignment.center,
                                                                  primary: Colors.white,
                                                                  padding: const EdgeInsets.all(8),
                                                                ),
                                                                onPressed: () {
                                                                  if(canPressOk)
                                                                  {
                                                                    canPressOk=false;
                                                                    Navigator.pop(context);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'Ok',
                                                                  style: TextStyle(color: AppColor.white,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )

                                    :Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColor.bgColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(color: AppColor.greyLight)
                                  ),
                                  child: newWidget,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Container();
          }).then((val){
        canPressOk=false;
      });

    });
  }



}