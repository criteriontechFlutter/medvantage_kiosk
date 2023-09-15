




import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/AddHomeIsolationMember/add_relation_isolation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_realtion_isolation_modal.dart';

relationModule(context,var localization){
  List relationList = [
    {
      'relation':localization.father
    },
    {
      'relation':localization.mother
    },
    {
      'relation':localization.brother
    },
    {
      'relation':localization.sister
    },
  ];
  AddRelationIsolationModal modal=AddRelationIsolationModal();
    AlertDialogue().show(context,msg: '',title: localization.enterYourRelation,newWidget: [
      GetBuilder(
          init: AddRelationIsolationController(),
          builder: (_) {
            return Column(
              children: List.generate(relationList.length, (index) => InkWell(
                onTap: (){
                  Navigator.pop(context);
                  modal.controller.updateSelectedRelation=relationList[index]['relation'].toString();
                  print(relationList[index]['relation'].toString());
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(relationList[index]['relation'].toString(),style: MyTextTheme().mediumBCN,),
                    ],
                  ),
                ),
              ))
            );
          }
      ),
    ]);
  }