import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_text_theme.dart';

class BluetoothLostConnection{
  show(context,
      {
        required String  msg,
        required String title,
      }
      ){
    return WidgetsBinding.instance.addPostFrameCallback((_){
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.5),
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return WillPopScope(
            onWillPop: (){
              return Future.value(false);
            },
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: const Color.fromRGBO(103, 58, 183 ,1),
              elevation: 2,
              shape:   RoundedRectangleBorder(borderRadius: BorderRadius.circular(50) , side: const BorderSide(color: Colors.white, width: 4)),
              child:   Container(
                height: height/2,
                width: width / 400,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text( title.toString(),  style: MyTextTheme().extraLargeWCB ,),
                      const Icon(Icons.bluetooth , size: 100, color: Colors.white,),
                      const SizedBox(height: 8,),
                      Text( msg.toString() , style: MyTextTheme().mediumWCN.copyWith(fontFamily: 'Poppins-Regular'),),
                      const SizedBox(height: 40,),
                      const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundColor: Color.fromRGBO(241, 116, 6 , 1),
                          child: Icon(Icons.bluetooth , size: 60, color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
    );
  }

}

