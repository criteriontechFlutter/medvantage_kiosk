//
// import 'package:digi_doctor/AppManager/alert_dialogue.dart';
// import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
// import 'package:digi_doctor/AppManager/widgets/my_button.dart';
// import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
// import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_controller.dart';
// import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_modal.dart';
// import 'package:digi_doctor/Pages/select_member/select_memeber_view.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import '../../../../AppManager/app_color.dart';
// import '../../../../AppManager/app_util.dart';
// import '../../../../AppManager/my_text_theme.dart';
// import '../../../../AppManager/user_data.dart';
// import '../../../../AppManager/widgets/my_app_bar.dart';
// import 'package:get/get.dart';
//
// import '../../../../Localization/app_localization.dart';
// import '../../../select_member/select_memeber_modal.dart';
// import '../DataModal/payment_data_modal.dart';
//
// class BookAppointmentView extends StatefulWidget {
//   final String drName;
//   final String speciality;
//   final String degree;
//   final int isEraUser;
//
//
//   const BookAppointmentView({
//     Key? key,
//     required this.drName,
//     required this.speciality,
//     required this.degree,
//     required this.isEraUser,
//   }) : super(key: key);
//
//   @override
//   State<BookAppointmentView> createState() => _BookAppointmentViewState();
// }
//
// class _BookAppointmentViewState extends State<BookAppointmentView> {
//   TimeSlotModal modal = TimeSlotModal();
//   SelectMemberModal memberModal =SelectMemberModal();
//   UserData userData=Get.put(UserData());
//
//   late Razorpay _razorpay;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
//
//   }
//
//   handlePaymentSuccess(PaymentSuccessResponse response) async {
//     print('paymentResponse');
//     print(response.orderId.toString());
//     print(response.paymentId.toString());
//     modal.controller.updatePaymentResponse = response;
//     print('succccccccccccessssssssssssss');
//     await modal.onlineAppointment(context);
//   }
//
//   handlePaymentError(PaymentFailureResponse response) {
//     print('PaymentFailed');
//
//     alertToast(context, 'Payment Failed');
//   }
//
//   handleExternalWallet(ExternalWalletResponse response) {
//     alertToast(context, response.walletName);
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
//     return Container(
//       color: AppColor.primaryColor,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.bookAppointment.toString()),
//           body: GetBuilder(
//               init: TimeSlotController(),
//               builder: (_) {
//                 return SimpleBuilder(
//                     builder: (_) {
//                       return Column(
//                         children: [
//                           Container(
//                             color: Colors.white,
//                             child: Padding(
//                               padding: const EdgeInsets.all(15),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     localization.getLocaleData.bookAppointmentFor.toString(),
//                                     style: MyTextTheme().largeBCB,
//                                   ),
//                                   const SizedBox(height: 12,),
//                                   Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       CustomInkwell(borderRadius: 15,color:userData.getUserPrimaryStatus=="1"? AppColor.primaryColor:Colors.grey,elevation: 3,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                                           child: Text(localization.getLocaleData.self.toString(),style:MyTextTheme().mediumWCB ),
//                                         ),
//                                         onPress: () async {
//                                           memberModal.controller.updateSelectedMemberId='';
//                                           await memberModal.getMember(context);
//                                         },
//                                       ),
//                                       SizedBox(width: 100,),
//                                       CustomInkwell(
//                                         color:userData.getUserPrimaryStatus=="0"?AppColor.buttonColor:Colors.grey,
//                                         elevation: 3,borderRadius: 15,
//                                         onPress: (){
//                                           App().navigate(context, const SelectMember(pageName: '',));
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(
//                                                 userData.getUserPrimaryStatus=="0"?userData.getUserName.capitalize!:localization.getLocaleData.selectMember.toString(),
//                                                 style: MyTextTheme().mediumWCB,
//                                               ),
//                                               // Icon(
//                                               //   Icons.arrow_forward_ios,
//                                               //   size: 15,
//                                               //    color: AppColor.black,
//                                               // )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                             width: Get.width,
//                             color: Colors.white,
//                             child:Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     localization.getLocaleData.doctorInformation.toString(),
//                                     style: MyTextTheme().largeBCB,
//                                   ),
//                                   const SizedBox(height: 10,),
//                                   Row(
//                                     children: [
//                                       Text("${localization.getLocaleData.fullName.toString()} :",style: MyTextTheme().mediumBCB,),
//                                       const SizedBox(width: 8,),
//                                       Text(
//                                         "${widget.drName.toString().toUpperCase()}  (${widget.degree})",
//                                         style: MyTextTheme().mediumGCB,
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10,),
//                                   Row(
//                                     children: [
//                                       Text("${localization.getLocaleData.speciality.toString()} :",style: MyTextTheme().mediumBCB,),
//                                       const SizedBox(width: 8,),
//                                       Text(widget.speciality.toString().toUpperCase(),
//                                         style: MyTextTheme().mediumGCB,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 10,),
//                                   Row(
//                                     //mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text("${localization.getLocaleData.appointmentDate.toString()} :",style: MyTextTheme().mediumBCB,),
//                                       const SizedBox(width: 10,),
//                                       Text(
//                                         '${DateFormat.MMMEd().format(
//                                             modal
//                                                 .controller.getSelectedDate??DateTime.now())}  ${modal
//                                             .controller.getSavedTime}',
//                                         style: MyTextTheme().mediumGCB,
//                                       ),
//                                     ],
//                                   ),
//
//                                 ],
//                               ),
//                             ) ,
//                           ),
//                           const SizedBox(height: 15,),
//                           Expanded(
//                             child: Container(
//                               width: Get.width,
//                               color: Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       localization.getLocaleData.patientInformation.toString(),
//                                       style: MyTextTheme().largeBCB,
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     // Text(
//                                     //   localization.getLocaleData.fullName.toString(),
//                                     //   style: MyTextTheme().mediumBCN,
//                                     // ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "${localization.getLocaleData.fullName.toString()} :",
//                                           style: MyTextTheme().mediumBCB,
//                                         ),
//                                         const SizedBox(width: 8,),
//                                         Text(
//                                           "${userData.getUserName.toString()}  (${DateTime.now().year-int.parse(userData.getUserDob.split('/')[2])} y / ${userData.getUserGender=='1'?'M':'F'})",
//                                           style: MyTextTheme().mediumGCB,
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     // Text(
//                                     //   localization.getLocaleData.hintText!.enterMobileNo.toString(),
//                                     //   style: MyTextTheme().mediumBCN,
//                                     // ),
//                                     // const SizedBox(
//                                     //   height: 10,
//                                     // ),
//                                     Row(
//                                       children: [
//                                         Text("${localization.getLocaleData.mobileNumber.toString()} :",style: MyTextTheme().mediumBCB,),
//                                         const SizedBox(width: 8,),
//                                         Text(
//                                           userData.getUserMobileNo.toString(),
//                                           style: MyTextTheme().mediumGCB,
//                                         ),
//                                       ],
//                                     ),
//                                     const Expanded(
//                                       child: SizedBox(
//                                         height: 10,
//                                       ),
//                                     ),
//                                     Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: MyButton(
//                                           title: localization.getLocaleData.confirm.toString(),
//                                           buttonRadius: 25,
//                                           onPress: () async {
//                                             // await  modal.openCheckout(context,_razorpay);
//                                             var data= await  modal.onPressedCfm(context);
//                                             print('nnnnnnnnnnnnnnnn$data');
//                                             if(data==1){
//                                               await  paymentModule(context);
//                                             }
//                                             // widget.isEraUser!=0?   modal.onPressedConfirm(context):payOption(context);
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 35,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       );
//                     }
//                 );
//               }),
//         ),
//       ),
//     );
//   }
//
//
//   paymentModule(
//       context,
//       ) {
//     ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
//     AlertDialogue().show(context,  msg:  "",title: localization.getLocaleData.selectPayMode.toString(),
//         newWidget: [GetBuilder(
//             init: TimeSlotController(),
//             builder: (_) {
//               return Column(
//                 children: [
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: modal.controller.getPaymentMode.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       PaymentDataModal paymentType =
//                       modal.controller.getPaymentMode[index];
//                       return InkWell(
//                         onTap: (){
//                           modal.checkPaymentMode(index, paymentType.isSelected);
//
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.network(paymentType.image.toString(),height: 15,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   paymentType.paymentMode.toString(),
//                                   style: MyTextTheme().mediumBCB,
//                                 ),
//                                 Icon(paymentType.isSelected == true
//                                     ? Icons.check_box_sharp
//                                     : Icons.check_box_outline_blank)
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 30,),
//                   MyButton2(title: localization.getLocaleData.payNow.toString(),color: AppColor.primaryColor,width: 200,
//                     onPress: () async {
//                       await modal.onPressedPayNow(context,_razorpay);
//                     },),
//                 ],
//               );
//             })]);
//   }
//
//
// }


import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_controller.dart';
import 'package:digi_doctor/Pages/select_member/select_memeber_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import 'package:get/get.dart';

import '../../../../Localization/app_localization.dart';
import '../../../Dashboard/Widget/profile_info_widget.dart';
import '../../../Login Through OTP/select_user.dart';
import '../../../Login Through OTP/select_user_view_modal.dart';
import '../../../select_member/select_memeber_modal.dart';
import '../../NewBookAppintment/NewBookAppointmentModal.dart';
import '../../top_specialities_view.dart';
import '../DataModal/payment_data_modal.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_controller.dart' as dp;


import 'time_slot_modal.dart';
class BookAppointmentView extends StatefulWidget {
  final String drName;
  final String speciality;
  final String degree;
  final String doctorId;
  final String timeSlot;
  final String date;
  final String day;
  final String timeSlotId;
  final String dayid;
  final int? departmentId;



  const BookAppointmentView({
    Key? key,
    required this.drName,
    required this.speciality,
    required this.degree,
    required  this.doctorId, required this.departmentId, required this.timeSlot, required this.date, required this.day, required this.timeSlotId, required this.dayid,

  }) : super(key: key);

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  //******


  optionList() {

    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    return  [
      {
        'icon':"assets/kiosk_setting.png",
        'name':localization.getLocaleData.doctorBySpeciality.toString(),
        'isChecked':true
      },
      {
        'icon':"assets/kiosk_symptoms.png",
        'name':localization.getLocaleData.doctorBySymptoms.toString(),
        'isChecked':false
      },
    ];}
  bool isDoctor = true;
  TimeSlotModal modal = TimeSlotModal();
  SelectMemberModal memberModal =SelectMemberModal();
  UserData userData=Get.put(UserData());

  late Razorpay _razorpay;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

  }

  handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('paymentResponse');
    print(response.orderId.toString());
    print(response.paymentId.toString());
    modal.controller.updatePaymentResponse = response;
    print('succccccccccccessssssssssssss');
    await modal.onlineAppointment(context);
  }

  handlePaymentError(PaymentFailureResponse response) {
    print('PaymentFailed');

    alertToast(context, 'Payment Failed');
  }

  handleExternalWallet(ExternalWalletResponse response) {
    alertToast(context, response.walletName);
  }


  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }


  @override
  Widget build(BuildContext context) {

    var  newDate = DateTime.parse(widget.date);
    var date = DateFormat.yMd().format(newDate);
    NewBookAppointmentModal modal2 = NewBookAppointmentModal();
    final medvantageUser = GetStorage();
    SelectUserViewModal currentUser =
    Provider.of<SelectUserViewModal>(context, listen: true);
    currentUser.updateName=medvantageUser.read('medvantageUserName');

    var userName = medvantageUser.read('medvantageUserName');
    var number = medvantageUser.read('medvantageUserNumber');
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.bookAppointment.toString()),
          body: GetBuilder(
              init: TimeSlotController(),
              builder: (_) {
                return SimpleBuilder(
                    builder: (_) {
                      return Container(
                    //    width: Get.width,
                        decoration:   BoxDecoration(
                          //***
                            color: AppColor.primaryColorLight,
                            image: const DecorationImage(
                                image:  AssetImage("assets/kiosk_bg.png"),

                                // Orientation.portrait==MediaQuery.of(context).orientation?
                                //  AssetImage("assets/kiosk_bg.png",):
                                // AssetImage("assets/kiosk_bg_img.png",),

                                fit: BoxFit.fill),
                        ),
                        child: Column(
                          children: [
                            //**
                            const SizedBox(
                                height: 80,
                                child: ProfileInfoWidget()),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: 110,
                              child: ListView.builder(
                                  scrollDirection:   Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // shrinkWrap: true,
                                  itemCount: optionList().length,itemBuilder:(BuildContext context,int index){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 18),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(index==0){
                                          isDoctor = true;
                                          App().navigate(context, TopSpecialitiesView());
                                        }
                                        else{
                                          isDoctor = false;
                                          App().navigate(context, TopSpecialitiesView(isDoctor:1));
                                        }
                                      });
                                      for (var element
                                      in optionList()) {
                                        element["isChecked"] = false;
                                      }
                                      optionList()[index]['isChecked']=true;
                                    },

                                    child: Container(

                                      decoration: BoxDecoration(
                                          color: optionList()[index]['isChecked']?AppColor
                                              .primaryColor:AppColor.white,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      //  width: Get.width*.46,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              optionList()[index]['icon'],
                                              color: optionList()[index]['isChecked']?AppColor
                                                  .white:AppColor.secondaryColorShade2,
                                              height: 40,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              optionList()[index]['name'],
                                              style: MyTextTheme()
                                                  .largeWCN.copyWith(color:optionList()[index]['isChecked']?AppColor
                                                  .white:AppColor.secondaryColorShade2),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20,10,20,0),
                              child: Container(
                                color: AppColor.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20,30,20,10),
                                      child: Text(
                                        localization.getLocaleData.bookAppointmentFor.toString(),
                                        style: MyTextTheme().largeBCB,
                                      ),
                                    ),
                                    const SizedBox(height: 12,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomInkwell(borderRadius: 15,color:userData.getUserPrimaryStatus=="1"? AppColor.primaryColor:Colors.grey,elevation: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                            child: Text(localization.getLocaleData.self.toString(),style:MyTextTheme().mediumWCB ),
                                          ),
                                          onPress: () async {
                                            // memberModal.controller.updateSelectedMemberId='';
                                            // await memberModal.getMember(context);
                                          },
                                        ),
                                        const SizedBox(width: 100),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              App().navigate(context, const SelectUser());
                                            });
                                          },
                                          child: Padding(
                                            padding:  const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 160,
                                                decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: AppColor.white
                                                  ),
                                                ),
                                                child:Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    border: Border.all(color: Colors.grey),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Expanded(child: Text(currentUser.getName.toString(),style: MyTextTheme().mediumBCB,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),
                                                        //     Text(getLanguageInRealLanguageForChange(UserData().getLang.toString()),style: MyTextTheme().mediumWCB,),
                                                        const Icon(Icons.arrow_drop_down_sharp,color: Colors.grey,),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ),
                                          ),
                                        ),
                                        // CustomInkwell(
                                        //   color:userData.getUserPrimaryStatus=="0"?AppColor.buttonColor:Colors.grey,
                                        //   elevation: 3,borderRadius: 15,
                                        //   onPress: (){
                                        //     App().navigate(context, const SelectMember(pageName: '',));
                                        //   },
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(8.0),
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //       MainAxisAlignment.spaceEvenly,
                                        //       children: [
                                        //         Text(
                                        //           userData.getUserPrimaryStatus=="0"?userData.getUserName.capitalize!:localization.getLocaleData.selectMember.toString(),
                                        //           style: MyTextTheme().mediumWCB,
                                        //         ),
                                        //         // Icon(
                                        //         //   Icons.arrow_forward_ios,
                                        //         //   size: 15,
                                        //         //    color: AppColor.black,
                                        //         // )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: Get.width,
                                      color: Colors.white,
                                      child:Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              localization.getLocaleData.doctorInformation.toString(),
                                              style: MyTextTheme().largeBCB,
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text("${localization.getLocaleData.fullName.toString()} :",style: MyTextTheme().mediumBCB ),
                                                const SizedBox(width: 8 ),
                                                Text(
                                                  widget.drName.toString().toUpperCase(),
                                                  style: MyTextTheme().mediumGCB,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Text("${localization.getLocaleData.speciality.toString()} :",style: MyTextTheme().mediumBCB,),
                                                const SizedBox(width: 8,),
                                                Text(widget.speciality.toString()==''?'N/A':widget.speciality.toString().toUpperCase(),
                                                  style: MyTextTheme().mediumGCB,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10,),
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("${localization.getLocaleData.appointmentDate.toString()} :",style: MyTextTheme().mediumBCB),
                                                const SizedBox(width: 10),
                                                Text(date.toString(),
                                                  style: MyTextTheme().mediumGCB,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20,),
                                            Text(
                                              localization.getLocaleData.patientInformation.toString(),
                                              style: MyTextTheme().largeBCB,
                                            ),
                                            const SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Text(
                                                  "${localization.getLocaleData.fullName.toString()} :",
                                                  style: MyTextTheme().mediumBCB,
                                                ),

                                                Text(userName.toString(),
                                                  style: MyTextTheme().mediumGCB,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10,),
                                            // Text(
                                            //   localization.getLocaleData.hintText!.enterMobileNo.toString(),
                                            //   style: MyTextTheme().mediumBCN,
                                            // ),
                                            // const SizedBox(
                                            //   height: 10,
                                            // ),
                                            Row(
                                              children: [
                                                Text("${localization.getLocaleData.mobileNumber.toString()} :",style: MyTextTheme().mediumBCB,),
                                                const SizedBox(width: 8),
                                                Text(
                                                  number.toString(),
                                                  style: MyTextTheme().mediumGCB,
                                                ),
                                              ],
                                            ),
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                                child: SizedBox(
                                                  width: 200,
                                                  child:modal2.controller.bookAppointmentLoader==true?Center(child: LoadingAnimationWidget.fourRotatingDots(color: AppColor.primaryColor, size: 50)): MyButton(
                                                    title: localization.getLocaleData.confirm.toString(),
                                                    buttonRadius: 25,
                                                    onPress: () async {
                                                      // await  modal.openCheckout(context,_razorpay);
                                                      modal2.bookAppointment(context,doctorId: widget.doctorId,departmentId: widget.departmentId,timeSlotsId: widget.timeSlotId,appointmentDate: widget.date,dayId:widget.dayid);
                                                      //
                                                      // var data= await  modal.onPressedCfm(context);
                                                      // print('nnnnnnnnnnnnnnnn$data');
                                                      // if(data==1){
                                                      //  // await  paymentModule(context);
                                                      // }
                                                      // widget.isEraUser!=0?   modal.onPressedConfirm(context):payOption(context);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: Container(
                                    //     width: Get.width,
                                    //     color: Colors.white,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(15),
                                    //       child: Column(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           Text(
                                    //             localization.getLocaleData.patientInformation.toString(),
                                    //             style: MyTextTheme().largeBCB,
                                    //           ),
                                    //           // const SizedBox(
                                    //           //   height: 15,
                                    //           // ),
                                    //           // Text(
                                    //           //   localization.getLocaleData.fullName.toString(),
                                    //           //   style: MyTextTheme().mediumBCN,
                                    //           // ),
                                    //           Row(
                                    //             children: [
                                    //               Text(
                                    //                 "${localization.getLocaleData.fullName.toString()} :",
                                    //                 style: MyTextTheme().mediumBCB,
                                    //               ),
                                    //               const SizedBox(width: 8,),
                                    //               Text(
                                    //                 "${userData.getUserName.toString()}  (${DateTime.now().year-int.parse(userData.getUserDob.split('/')[2])} y / ${userData.getUserGender=='1'?'M':'F'})",
                                    //                 style: MyTextTheme().mediumGCB,
                                    //               ),
                                    //             ],
                                    //           ),
                                    //
                                    //           // Text(
                                    //           //   localization.getLocaleData.hintText!.enterMobileNo.toString(),
                                    //           //   style: MyTextTheme().mediumBCN,
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 10,
                                    //           // ),
                                    //           Row(
                                    //             children: [
                                    //               Text("${localization.getLocaleData.mobileNumber.toString()} :",style: MyTextTheme().mediumBCB,),
                                    //               const SizedBox(width: 8,),
                                    //               Text(
                                    //                 userData.getUserMobileNo.toString(),
                                    //                 style: MyTextTheme().mediumGCB,
                                    //               ),
                                    //             ],
                                    //           ),
                                    //
                                    //           Center(
                                    //             child: Padding(
                                    //               padding: const EdgeInsets.all(8.0),
                                    //               child: MyButton(
                                    //                 title: localization.getLocaleData.confirm.toString(),
                                    //                 buttonRadius: 25,
                                    //                 onPress: () async {
                                    //                   // await  modal.openCheckout(context,_razorpay);
                                    //                   var data= await  modal.onPressedCfm(context);
                                    //                   print('nnnnnnnnnnnnnnnn$data');
                                    //                   if(data==1){
                                    //                     await  paymentModule(context);
                                    //                   }
                                    //                   // widget.isEraUser!=0?   modal.onPressedConfirm(context):payOption(context);
                                    //                 },
                                    //               ),
                                    //             ),
                                    //           ),
                                    //
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                );
              }),
        ),
      ),
    );
  }


  paymentModule(
      context,
      ) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    AlertDialogue().show(context,  msg:  "",title: localization.getLocaleData.selectPayMode.toString(),
        newWidget: [GetBuilder(
            init: TimeSlotController(),
            builder: (_) {
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: modal.controller.getPaymentMode.length,
                    itemBuilder: (BuildContext context, int index) {
                      PaymentDataModal paymentType =
                      modal.controller.getPaymentMode[index];
                      return InkWell(
                        onTap: (){
                          modal.checkPaymentMode(index, paymentType.isSelected);

                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(paymentType.image.toString(),height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  paymentType.paymentMode.toString(),
                                  style: MyTextTheme().mediumBCB,
                                ),
                                Icon(paymentType.isSelected == true
                                    ? Icons.check_box_sharp
                                    : Icons.check_box_outline_blank)
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30,),
                  MyButton2(title: localization.getLocaleData.payNow.toString(),color: AppColor.primaryColor,width: 200,
                    onPress: () async {
                      await modal.onPressedPayNow(context,_razorpay);
                    },),
                ],
              );
            })]);
  }


}



//
// class BookAppointmentView extends StatefulWidget {
//   final String drName;
//   final String speciality;
//   final String degree;
//   final int isEraUser;
//
//
//   const BookAppointmentView({
//     Key? key,
//     required this.drName,
//     required this.speciality,
//     required this.degree,
//     required this.isEraUser,
//   }) : super(key: key);
//
//   @override
//   State<BookAppointmentView> createState() => _BookAppointmentViewState();
// }
//
// class _BookAppointmentViewState extends State<BookAppointmentView> {
//   //**
//   List optionList=[
//     {
//       'icon':"assets/kiosk_setting.png",
//       'name':"Find Doctor By Specialty",
//       'isChecked':true
//     },
//     {
//       'icon':"assets/kiosk_symptoms.png",
//       'name':"Find Doctors By Symptoms",
//       'isChecked':false
//     },
//   ];
//   bool isDoctor = true;
//   TimeSlotModal modal = TimeSlotModal();
//   SelectMemberModal memberModal =SelectMemberModal();
//   UserData userData=Get.put(UserData());
//
//   late Razorpay _razorpay;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
//
//   }
//
//   handlePaymentSuccess(PaymentSuccessResponse response) async {
//     print('paymentResponse');
//     print(response.orderId.toString());
//     print(response.paymentId.toString());
//     modal.controller.updatePaymentResponse = response;
//     print('succccccccccccessssssssssssss');
//     await modal.onlineAppointment(context);
//   }
//
//   handlePaymentError(PaymentFailureResponse response) {
//     print('PaymentFailed');
//
//     alertToast(context, 'Payment Failed');
//   }
//
//   handleExternalWallet(ExternalWalletResponse response) {
//     alertToast(context, response.walletName);
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
//     return Container(
//       color: AppColor.primaryColor,
//       child: SafeArea(
//         child: Scaffold(
//           // appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.bookAppointment.toString()),
//           body: GetBuilder(
//               init: TimeSlotController(),
//               builder: (_) {
//                 return SimpleBuilder(
//                     builder: (_) {
//                       return Row(
//                         children: [
//                           //**
//                           Expanded(
//                             flex: 3,
//                             child: ListView(
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           flex: 2,
//                                           child: Container(
//                                             height:Get.height,
//                                             //820,
//                                             // MediaQuery.of(context).size.height * .89,
//                                             color: AppColor.primaryColor,
//                                             child: Padding(
//                                               padding: const EdgeInsets.symmetric(
//                                                   vertical: 56, horizontal: 12),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                     const EdgeInsets.only(left: 20),
//                                                     child: Image.asset(
//                                                       'assets/kiosk_logo.png',
//                                                       color: Colors.white,
//                                                       height: 40,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   //*********
//                                                   Expanded(
//                                                     child: ListView.builder(itemCount: modal.controller.getOption(context).length,
//                                                         itemBuilder:(BuildContext context,int index){
//                                                           // OptionDataModal opt=modal.controller.getOption(context)[index];
//                                                           dp.OptionDataModals opts=modal.controller.getOption(context)[index];
//                                                           return Padding(
//                                                             padding:
//                                                             const EdgeInsets.symmetric(
//                                                                 vertical: 20,
//                                                                 horizontal: 12),
//                                                             child: InkWell(
//                                                               onTap: (){
//                                                                 setState(() {
//                                                                   if(index==0){
//                                                                     isDoctor = true;
//                                                                  //   App().navigate(context, TopSpecialitiesView());
//                                                                   }
//                                                                   else{
//                                                                     isDoctor = false;
//                                                                  //   App().navigate(context, TopSpecialitiesView(isDoctor:1));
//
//                                                                   }
//                                                                 });
//                                                                 for (var element
//                                                                 in optionList) {
//                                                                   element["isChecked"] = false;
//                                                                 }
//                                                                 optionList[index]['isChecked']=true;
//
//
//
//
//
//                                                               },
//
//                                                               child: Container(
//                                                                 color: optionList[index]['isChecked']?AppColor
//                                                                     .primaryColorLight:AppColor.primaryColor,
//                                                                 child: Padding(
//                                                                   padding:
//                                                                   const EdgeInsets.all(
//                                                                       8.0),
//                                                                   child: Row(
//                                                                     children: [
//                                                                       Image.asset(
//                                                                         optionList[index]['icon'],
//                                                                         height: 40,
//                                                                       ),
//                                                                       const SizedBox(
//                                                                         width: 10,
//                                                                       ),
//                                                                       Expanded(
//                                                                         child: Text(
//                                                                           opts.optionText.toString(),
//                                                                           style: MyTextTheme()
//                                                                               .largeWCN,
//                                                                         ),
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           );
//                                                         }),
//                                                   ),
//
//                                                   Padding(
//                                                     padding: const EdgeInsets.all(8.0),
//                                                     child: Image.asset("assets/kiosk_tech.png",height: 25,color: AppColor.white,),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(flex: 7,child:      Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children:  [
//                                   Expanded(
//                                     child: Padding(
//                                       padding:  EdgeInsets.only(left: 20,top: 25),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(UserData().getUserName.toString(),style: MyTextTheme().largePCB.copyWith(color: AppColor.primaryColorLight,fontSize: 25)),
//                                           Row(
//                                             children: [
//
//                                               Text(UserData().getUserGender.toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
//                                               Text(" ${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
//                                             ],
//                                           ),
//                                           Text(UserData().getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
//                                           Text(UserData().getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   ProfileInfoWidget()
//                                 ],
//                               ),
//                               Container(
//                                 color: Colors.white,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         localization.getLocaleData.bookAppointmentFor.toString(),
//                                         style: MyTextTheme().largeBCB,
//                                       ),
//                                       const SizedBox(height: 12,),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           CustomInkwell(borderRadius: 15,color:userData.getUserPrimaryStatus=="1"? AppColor.primaryColor:Colors.grey,elevation: 3,
//                                             child: Padding(
//                                               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                                               child: Text(localization.getLocaleData.self.toString(),style:MyTextTheme().mediumWCB ),
//                                             ),
//                                             onPress: () async {
//                                               memberModal.controller.updateSelectedMemberId='';
//                                               await memberModal.getMember(context);
//                                             },
//                                           ),
//                                           SizedBox(width: 100,),
//                                           CustomInkwell(
//                                             color:userData.getUserPrimaryStatus=="0"?AppColor.buttonColor:Colors.grey,
//                                             elevation: 3,borderRadius: 15,
//                                             onPress: (){
//                                               App().navigate(context, const SelectMember(pageName: '',));
//                                             },
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                                 children: [
//                                                   Text(
//                                                     userData.getUserPrimaryStatus=="0"?userData.getUserName.capitalize!:localization.getLocaleData.selectMember.toString(),
//                                                     style: MyTextTheme().mediumWCB,
//                                                   ),
//                                                   // Icon(
//                                                   //   Icons.arrow_forward_ios,
//                                                   //   size: 15,
//                                                   //    color: AppColor.black,
//                                                   // )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//
//                                         ],
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Container(
//                                 width: Get.width,
//                                 color: Colors.white,
//                                 child:Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         localization.getLocaleData.doctorInformation.toString(),
//                                         style: MyTextTheme().largeBCB,
//                                       ),
//                                       const SizedBox(height: 10,),
//                                       Row(
//                                         children: [
//                                           Text("${localization.getLocaleData.fullName.toString()} :",style: MyTextTheme().mediumBCB,),
//                                           const SizedBox(width: 8,),
//                                           Text(
//                                             "${widget.drName.toString().toUpperCase()}  (${widget.degree})",
//                                             style: MyTextTheme().mediumGCB,
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 10,),
//                                       Row(
//                                         children: [
//                                           Text("${localization.getLocaleData.speciality.toString()} :",style: MyTextTheme().mediumBCB,),
//                                           const SizedBox(width: 8,),
//                                           Text(widget.speciality.toString().toUpperCase(),
//                                             style: MyTextTheme().mediumGCB,
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 10,),
//                                       Row(
//                                         //mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Text("${localization.getLocaleData.appointmentDate.toString()} :",style: MyTextTheme().mediumBCB,),
//                                           const SizedBox(width: 10,),
//                                           Text(
//                                             '${DateFormat.MMMEd().format(
//                                                 modal
//                                                     .controller.getSelectedDate??DateTime.now())}  ${modal
//                                                 .controller.getSavedTime}',
//                                             style: MyTextTheme().mediumGCB,
//                                           ),
//                                         ],
//                                       ),
//
//                                     ],
//                                   ),
//                                 ) ,
//                               ),
//                               const SizedBox(height: 15,),
//                               Expanded(
//                                 child: Container(
//                                   width: Get.width,
//                                   color: Colors.white,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(15),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           localization.getLocaleData.patientInformation.toString(),
//                                           style: MyTextTheme().largeBCB,
//                                         ),
//                                         const SizedBox(
//                                           height: 15,
//                                         ),
//                                         // Text(
//                                         //   localization.getLocaleData.fullName.toString(),
//                                         //   style: MyTextTheme().mediumBCN,
//                                         // ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "${localization.getLocaleData.fullName.toString()} :",
//                                               style: MyTextTheme().mediumBCB,
//                                             ),
//                                             const SizedBox(width: 8,),
//                                             Text(
//                                               "${userData.getUserName.toString()}  (${DateTime.now().year-int.parse(userData.getUserDob.split('/')[2])} y / ${userData.getUserGender=='1'?'M':'F'})",
//                                               style: MyTextTheme().mediumGCB,
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 15,
//                                         ),
//                                         // Text(
//                                         //   localization.getLocaleData.hintText!.enterMobileNo.toString(),
//                                         //   style: MyTextTheme().mediumBCN,
//                                         // ),
//                                         // const SizedBox(
//                                         //   height: 10,
//                                         // ),
//                                         Row(
//                                           children: [
//                                             Text("${localization.getLocaleData.mobileNumber.toString()} :",style: MyTextTheme().mediumBCB,),
//                                             const SizedBox(width: 8,),
//                                             Text(
//                                               userData.getUserMobileNo.toString(),
//                                               style: MyTextTheme().mediumGCB,
//                                             ),
//                                           ],
//                                         ),
//                                         const Expanded(
//                                           child: SizedBox(
//                                             height: 10,
//                                           ),
//                                         ),
//                                         Center(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: MyButton(
//                                               title: localization.getLocaleData.confirm.toString(),
//                                               buttonRadius: 25,
//                                               onPress: () async {
//                                                 // await  modal.openCheckout(context,_razorpay);
//                                                 var data= await  modal.onPressedCfm(context);
//                                                 print('nnnnnnnnnnnnnnnn$data');
//                                                 if(data==1){
//                                                   await  paymentModule(context);
//                                                 }
//                                                 // widget.isEraUser!=0?   modal.onPressedConfirm(context):payOption(context);
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 35,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),)
//                         ],
//                       );
//                     }
//                 );
//               }),
//         ),
//       ),
//     );
//   }
//
//
//   paymentModule(
//       context,
//       ) {
//     ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
//     AlertDialogue().show(context,  msg:  "",title: localization.getLocaleData.selectPayMode.toString(),
//         newWidget: [GetBuilder(
//             init: TimeSlotController(),
//             builder: (_) {
//               return Column(
//                 children: [
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: modal.controller.getPaymentMode.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       PaymentDataModal paymentType =
//                       modal.controller.getPaymentMode[index];
//                       return InkWell(
//                         onTap: (){
//                           modal.checkPaymentMode(index, paymentType.isSelected);
//
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.network(paymentType.image.toString(),height: 15,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   paymentType.paymentMode.toString(),
//                                   style: MyTextTheme().mediumBCB,
//                                 ),
//                                 Icon(paymentType.isSelected == true
//                                     ? Icons.check_box_sharp
//                                     : Icons.check_box_outline_blank)
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 30,),
//                   MyButton2(title: localization.getLocaleData.payNow.toString(),color: AppColor.primaryColor,width: 200,
//                     onPress: () async {
//                       await modal.onPressedPayNow(context,_razorpay);
//                     },),
//                 ],
//               );
//             })]);
//   }
//
//
// }
