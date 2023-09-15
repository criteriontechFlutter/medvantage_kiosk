import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/MyTextField.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/organ_modal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../DataModal/organ_symptom_data_modal.dart';
import '../organ_controller.dart';

showSymptomDataList(context,setState, Map Organ, {moreSymptoms}) {
  OrganModal modal = OrganModal();
  ApplicationLocalizations localization =
      Provider.of<ApplicationLocalizations>(context, listen: false);

  // AlertDialogue2().show(context, "", "",
  //     newWidget: GetBuilder(
  //         init: OrganController(),
  //         builder: (_) {
  //           List selectedSymptoms = modal.controller.selectedOrganSymptomList
  //               .where((element) => element['organ']['id'] == Organ['id'])
  //               .toList();
  //           return Container(
  //               height: 100,
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
  //                       child: Row(
  //                         children: [
  //                           Text(
  //                             localization.getLocaleData.diseaseList.toString(),
  //                             style: MyTextTheme().mediumBCB,
  //                           ),
  //                           const Expanded(child: SizedBox()),
  //                           IconButton(
  //                               onPressed: () {
  //                                 Navigator.pop(context);
  //                                 modal.clearSelectedList();
  //                               },
  //                               icon: const Icon(
  //                                 Icons.clear,
  //                               )),
  //                         ],
  //                       ),
  //                     ),
  //                     const Divider(),
  //
  //
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: MyTextField(
  //                         labelText: 'Search...',
  //                         controller: modal.controller.searchC.value,
  //                         onChanged: (val){
  //                           modal.controller.update();
  //                           setState((){
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //
  //
  //                     Expanded(
  //                       child: GetBuilder(
  //                           init: OrganController(),
  //                           builder: (_) {
  //                             return SingleChildScrollView(
  //                               child: StaggeredGrid.count(
  //                                   crossAxisCount: 2,
  //                                   mainAxisSpacing: 2,
  //                                   children: List.generate(
  //                                       modal.controller.getOrganSymptomList
  //                                           .length, (index) {
  //                                     OrganSymptom fields = modal.controller
  //                                         .getOrganSymptomList[index];
  //
  //                                     return Padding(
  //                                       padding: const EdgeInsets.fromLTRB(
  //                                           8, 5, 8, 5),
  //                                       child: Column(
  //                                         children: [
  //                                           InkWell(
  //                                             onTap: (() {
  //                                               modal.selectOrganSymptomList(
  //                                                   modal.controller
  //                                                           .organSymptomList[
  //                                                       index],
  //                                                   Organ);
  //                                             }),
  //                                             child: Row(
  //                                               children: [
  //                                                 Icon(Icons.circle,
  //                                                     color: (modal.controller
  //                                                             .selectedOrganSymptomList
  //                                                             .map((e) =>
  //                                                                 e['id'])
  //                                                             .toList()
  //                                                             .contains(
  //                                                                 fields.id))
  //                                                         ? AppColor
  //                                                             .primaryColor
  //                                                         : AppColor.red),
  //                                                 const SizedBox(
  //                                                   width: 10,
  //                                                 ),
  //                                                 Expanded(
  //                                                     child: Text(
  //                                                   fields.symptoms.toString(),
  //                                                   style:
  //                                                       MyTextTheme().smallBCN,
  //                                                 )),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     );
  //                                   })),
  //                             );
  //                           }),
  //                     ),
  //                     Visibility(
  //                       visible: modal
  //                           .controller.selectedOrganSymptomList.isNotEmpty,
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Text(
  //                           localization.getLocaleData.selectedSymptom
  //                               .toString(),
  //                           style: MyTextTheme().mediumBCB,
  //                         ),
  //                       ),
  //                     ),
  //                     const Divider(),
  //                     Visibility(
  //                       visible: selectedSymptoms.isNotEmpty,
  //                       child: Expanded(
  //                         child: GetBuilder(
  //                             init: OrganController(),
  //                             builder: (_) {
  //                               return SingleChildScrollView(
  //                                 child: StaggeredGrid.count(
  //                                     crossAxisCount: 2,
  //                                     mainAxisSpacing: 2,
  //                                     children: List.generate(
  //                                         selectedSymptoms.length, (index) {
  //                                       var selectedData =
  //                                           selectedSymptoms[index];
  //                                       return Padding(
  //                                         padding: const EdgeInsets.fromLTRB(
  //                                             8, 5, 8, 5),
  //                                         child: Column(
  //                                           children: [
  //                                             InkWell(
  //                                               onTap: (() {}),
  //                                               child: Row(
  //                                                 children: [
  //                                                   const SizedBox(
  //                                                     width: 10,
  //                                                   ),
  //                                                   Expanded(
  //                                                       child: Container(
  //                                                     decoration: BoxDecoration(
  //                                                         color: AppColor
  //                                                             .primaryColor,
  //                                                         borderRadius:
  //                                                             BorderRadius
  //                                                                 .circular(
  //                                                                     2.0)),
  //                                                     child: Center(
  //                                                       child: Padding(
  //                                                         padding:
  //                                                             const EdgeInsets
  //                                                                 .all(5.0),
  //                                                         child: Text(
  //                                                           selectedData[
  //                                                                   'symptoms']
  //                                                               .toString(),
  //                                                           style: MyTextTheme()
  //                                                               .smallBCN,
  //                                                         ),
  //                                                       ),
  //                                                     ),
  //                                                   )),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       );
  //                                     })),
  //                               );
  //                             }),
  //                       ),
  //                     ),
  //                     MyButton(
  //                       title: localization.getLocaleData.ok.toString(),
  //                       color: AppColor.orangeColorDark,
  //                       onPress: () {
  //                         Navigator.pop(context);
  //                       },
  //                     )
  //                   ]));
  //         }));
}
