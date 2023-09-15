// import 'dart:io';
//
// import 'package:digi_doctor/AppManager/alert_dialogue.dart';
// import 'package:digi_doctor/AppManager/app_color.dart';
// import 'package:digi_doctor/AppManager/app_util.dart';
// import 'package:digi_doctor/AppManager/getImage.dart';
// import 'package:digi_doctor/AppManager/my_text_theme.dart';
// import 'package:digi_doctor/AppManager/widgets/date_time_field.dart';
// import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
// import 'package:digi_doctor/AppManager/widgets/my_button.dart';
// import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
// import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
// import 'package:digi_doctor/Pages/InvestigationHistory/AddInvestigation/add_investigation_modal.dart';
// import 'package:digi_doctor/Pages/LabTests/LabCart/lab_cart_view.dart';
// import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_test_search_modal.dart';
// import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_tests_search.dart';
// import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class AddInvestigation extends StatefulWidget {
//   const AddInvestigation({Key? key}) : super(key: key);
//
//   @override
//   State<AddInvestigation> createState() => _AddInvestigationState();
// }
//
// class _AddInvestigationState extends State<AddInvestigation> {
//   LabTestModal cartModal = LabTestModal();
//   AddInvestigationModal modal = AddInvestigationModal();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:AppColor.lightBackground,
//       appBar: AppBar(
//         title: Text("Add Investigation"),
//       ),
//       body:Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(8, 25,8,0),
//                 child: Column(
//                   children: [
//  Center(child: Text("Add Investigation Details")),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: AppColor.white,
//                   borderRadius: BorderRadius.circular(5)
//                 ),
//                 child: Column(
//                   crossAxisAlignment:CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                         decoration:
//                         BoxDecoration(color: AppColor.white),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Column(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Add Pathology information",
//                                 style: MyTextTheme().mediumBCB,
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               MyTextField2(
//                                // controller: modal.controller.pathologyC.value,
//                                 prefixIcon:SizedBox(height:2,width:2,child: Center(child: SvgPicture.asset('assets/hospital.svg'))) ,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "Please Enter Pathology or Hospital name";
//                                   }
//                                 },
//                                 hintText: "Pathology/Hospital Name",
//                                 borderColor: AppColor.greyLight,
//                               ),
//                               const SizedBox(height: 10,),
//                               MyTextField2(
//                                // controller: modal.controller.receiptC.value,
//                                 prefixIcon:SizedBox(height: 2,width: 2,
//                                     child: Center(child: SvgPicture.asset('assets/receipt.svg'))),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "Please Enter Receipt no";
//                                   }
//                                 },
//                                 hintText: "Receipt No.",
//                                 borderColor: AppColor.greyLight,
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               MyDateTimeField(
//                                // controller: modal.controller.testDateC.value,
//                                 validator: (value){
//                                   print(value.toString());
//                                   if(value!.isEmpty){
//                                     return 'please enter date';
//                                   }
//                                 },
//                                 hintText: 'Test Date',
//                                 borderColor: AppColor.greyLight,
//                                 prefixIcon:   const Icon(
//                                   Icons.calendar_today,color: Colors.blue, ),
//                                 // suffixIcon: Icon(Icons.person),
//                               ),
//                             ],
//                           ),
//                         )),
//
//                   ],
//                 ),),
//                 SizedBox(height: 10,),
//                 Container(
//                   color:AppColor.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Test Information",   style: MyTextTheme().mediumBCB,),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         MyTextField2(
//                           prefixIcon: SizedBox(height: 2,width: 2,child: Center(child: SvgPicture.asset('assets/receipt.svg'))),
//                           hintText: 'Test Name',
//                           suffixIcon: Icon(Icons.arrow_drop_down_sharp),
//
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: MyTextField2(
//                                 hintText: "Value",
//                                 keyboardType:TextInputType.number,
//                               ),
//                             ),
//                             SizedBox(width: 10,),
//                             Expanded(flex: 2,
//                               child: MyTextField2(
//                                 hintText: "Unit",
//                                 suffixIcon: Icon(Icons.arrow_drop_down_sharp),
//                                 keyboardType: TextInputType.number,
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         MyTextField2(
//                           hintText: "0",
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                         //  crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Expanded(child: SizedBox()),
//                             MyButton(title: "Add Test",buttonRadius: 25,
//                               width: 120,),
//                           ],
//                         )
//
//                       ],
//                     ),
//                   ),
//
//                 ),
//                 SizedBox(height: 10,),
//                 Container(
//                   color:AppColor.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Attach Investigation File",style: MyTextTheme().mediumBCB,),
//                         SizedBox(height: 10,),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(height: 8,),
//                           InkWell(
//                             onTap: (){
//                               imageUpload(context);
//
//
//                             },
//
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                               Icon(Icons.camera_alt),
//                                 SizedBox(width: 5,),
//                               Text("Upload File")
//                             ],),
//                           )
//                         ],)
//                       ],
//                     ),
//                   ),
//                 ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child:MyButton(
//               title: "Submit",
//               buttonRadius: 20,
//               onPress: ()async{
//                 if(modal.controller.files.isNotEmpty){
//                   AlertDialogue().show(context,
//                       msg: 'Are you sure you want to Submit?',
//                       firstButtonName: 'Confirm',
//                       showOkButton: false, firstButtonPressEvent: () async {
//                         Navigator.pop(context);
//                         await modal.saveMultipleFile(context);
//                       }, showCancelButton: true);
//                 }
//                 else{
//                   if(modal.controller.formKey.value.currentState!.validate()){
//                     if(modal.controller.addedTestList.isNotEmpty){
//                       AlertDialogue().show(context,
//                           msg: 'Are you sure you want to Submit?',
//                           firstButtonName: 'Confirm',
//                           showOkButton: false, firstButtonPressEvent: () async {
//                             Navigator.pop(context);
//                             await  modal.addInvestigation(context,'');
//                           }, showCancelButton: true);
//
//                     }
//                     else{
//                       alertToast(context, 'please add test information');
//                     }
//
//                   }
//
//                 }
//
//               },
//             ),
//           ),
//           SizedBox(height: 10,)
//         ],
//       )
//     );
//   }
//   imageUpload(BuildContext context) {
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//       return AlertDialog(content: Container(
//           height: 50,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5)
//         ),
//         child: Column(children: [
//           Row(children: [
//             Expanded(child: Text("Upload File")),
//             InkWell(onTap: (){
//             Navigator.pop(context);
//             },child: Icon(Icons.clear))
//           ],),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//             InkWell(
//               onTap: (){
//                 final file=MyImagePicker().getCameraImage();
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.camera_alt,),
//                   SizedBox(width: 5,),
//                   Text('Camera',style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//
//             InkWell(
//
//               onTap: (){
//                 final file=MyImagePicker().getImage();
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.folder),
//                   Text("Browse",style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold))
//                 ],
//               ),
//             )
//           ],)
//         ]),
//       ),);
//
//     });
//   }
//
// }
// //  Center(child: Text("Add Investigation Details")),
// //       Container(
// //         decoration: BoxDecoration(
// //             color: AppColor.white,
// //         borderRadius: BorderRadius.circular(5)
// //       ),
// //       child: Column(
// //         crossAxisAlignment:CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //               decoration:
// //               BoxDecoration(color: AppColor.white),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(15),
// //                 child: Column(
// //                   crossAxisAlignment:
// //                   CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "Add Pathology information",
// //                       style: MyTextTheme().mediumBCB,
// //                     ),
// //                     const SizedBox(
// //                       height: 20,
// //                     ),
// //                     MyTextField2(
// //                      // controller: modal.controller.pathologyC.value,
// //                       prefixIcon:SizedBox(height:2,width:2,child: Center(child: SvgPicture.asset('assets/hospital.svg'))) ,
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return "Please Enter Pathology or Hospital name";
// //                         }
// //                       },
// //                       hintText: "Pathology/Hospital Name",
// //                       borderColor: AppColor.greyLight,
// //                     ),
// //                     const SizedBox(height: 10,),
// //                     MyTextField2(
// //                      // controller: modal.controller.receiptC.value,
// //                       prefixIcon:SizedBox(height: 2,width: 2,
// //                           child: Center(child: SvgPicture.asset('assets/receipt.svg'))),
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return "Please Enter Receipt no";
// //                         }
// //                       },
// //                       hintText: "Receipt No.",
// //                       borderColor: AppColor.greyLight,
// //                     ),
// //                     const SizedBox(
// //                       height: 10,
// //                     ),
// //                     MyDateTimeField(
// //                      // controller: modal.controller.testDateC.value,
// //                       validator: (value){
// //                         print(value.toString());
// //                         if(value!.isEmpty){
// //                           return 'please enter date';
// //                         }
// //                       },
// //                       hintText: 'Test Date',
// //                       borderColor: AppColor.greyLight,
// //                       prefixIcon:   const Icon(
// //                         Icons.calendar_today,color: Colors.blue, ),
// //                       // suffixIcon: Icon(Icons.person),
// //                     ),
// //                   ],
// //                 ),
// //               )),
// //
// //         ],
// //       ),),
// //       SizedBox(height: 10,),
// //       Container(
// //         color:AppColor.white,
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text("Test Information",   style: MyTextTheme().mediumBCB,),
// //               MyTextField2(
// //                 prefixIcon: SizedBox(height: 2,width: 2,child: Center(child: SvgPicture.asset('assets/receipt.svg'))),
// //                 hintText: 'Test Name',
// //                 suffixIcon: Icon(Icons.arrow_drop_down_sharp),
// //
// //               ),
// //               SizedBox(height: 10,),
// //               Row(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Expanded(
// //                     child: MyTextField2(
// //                       hintText: "Value",
// //                       keyboardType:TextInputType.number,
// //                     ),
// //                   ),
// //                   SizedBox(width: 10,),
// //                   Expanded(flex: 2,
// //                     child: MyTextField2(
// //                       hintText: "Unit",
// //                       suffixIcon: Icon(Icons.arrow_drop_down_sharp),
// //                       keyboardType: TextInputType.number,
// //                     ),
// //                   )
// //                 ],
// //               ),
// //               SizedBox(height: 10,),
// //               MyTextField2(
// //                 hintText: "0",
// //               ),
// //               SizedBox(height: 10,),
// //               Row(
// //               //  crossAxisAlignment: CrossAxisAlignment.end,
// //                 children: [
// //                   Expanded(child: SizedBox()),
// //                   MyButton(title: "Add Test",buttonRadius: 25,
// //                     width: 120,),
// //                 ],
// //               )
// //
// //             ],
// //           ),
// //         ),
// //
// //       ),
// //       SizedBox(height: 10,),
// //       Container(
// //         color:AppColor.white,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("Attach Investigation File",style: MyTextTheme().mediumBCB,),
// //             SizedBox(height: 10,),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //               InkWell(
// //                 onTap: (){
// //                   imageUpload(context);
// //
// //
// //                 },
// //
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                   Icon(Icons.camera_alt),
// //                     SizedBox(width: 5,),
// //                   Text("Upload File")
// //                 ],),
// //               )
// //             ],)
// //           ],
// //         ),
// //       ),