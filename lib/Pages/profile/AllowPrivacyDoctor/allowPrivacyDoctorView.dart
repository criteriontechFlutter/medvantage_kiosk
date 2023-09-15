

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/DoctorProfile/doctor_profile_view.dart';
import 'package:digi_doctor/Pages/profile/AllowPrivacyDoctor/allowPrivacy_Controller.dart';
import 'package:digi_doctor/Pages/profile/AllowPrivacyDoctor/allowPrivacy_DataModal.dart';
import 'package:digi_doctor/Pages/profile/AllowPrivacyDoctor/allowPrivacy_Model.dart';
import 'package:digi_doctor/Pages/profile/profle_model.dart';
import 'package:flutter_svg/svg.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/search_specialist_doctor_controller.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/DataModal/search_specialist_doctor_data_modal.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/search_specialist_doctor_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_util.dart';

class AllowPrivacyDoctorView extends StatefulWidget {
  const AllowPrivacyDoctorView({Key? key}) : super(key: key);
  @override
  State<AllowPrivacyDoctorView> createState() => _AllowPrivacyDoctorViewState();

}

class _AllowPrivacyDoctorViewState extends State<AllowPrivacyDoctorView> {

  ProfileModel profileModal = ProfileModel();
  AllowPrivacyModel modal = AllowPrivacyModel();
  bool isChecked = false;


  get() async {
    profileModal.updateMember(context);
    await modal.getAllowDoctorList(
      context,
    );
  }

  @override
  void initState() {
    super.initState();
      get();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<AllowPrivacyController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder(
              init: AllowPrivacyController(),
              builder: (_) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Colors.black),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text( "Allow Doctor List",
                                        style: MyTextTheme().largeBCB),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics:const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()
                        ),
                          children: [
                            StaggeredGrid.count(
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 0.0,
                              crossAxisCount: MediaQuery.of(context).size.width>600? 2:1,
                              children: List.generate(
                                  modal.controller.getAllowDoctorList.length,
                                      (index) {
                                    PrivacyModal allowDoctor =
                                    modal.controller.getAllowDoctorList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: CustomInkwell(
                                        borderRadius: 15,elevation: 2,
                                        onPress: (){
                                          App().navigate(
                                              context,
                                              DoctorProfile(
                                                doctorId: allowDoctor.serviceProviderDetailsId.toString(),
                                              ));
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                      color:
                                                      Colors.grey.shade50,
                                                    ),
                                                    child: CachedNetworkImage(
                                                        imageUrl: allowDoctor
                                                            .profilePhotoPath
                                                            .toString(),
                                                        errorWidget: (context,
                                                            url, error) =>
                                                            Image.asset(
                                                                "assets/doctorSign.png")
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          allowDoctor.doctorName
                                                              .toString(),
                                                          style: MyTextTheme()
                                                              .mediumBCB,
                                                        ),
                                                        Text(
                                                          '${allowDoctor.degree} (${allowDoctor.degree})',
                                                          style: MyTextTheme()
                                                              .smallBCN.copyWith(fontSize: 13),
                                                        ),
                                                        Text(
                                                              "Era hospital",
                                                          style: MyTextTheme()
                                                              .smallPCN.copyWith(fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  // IconButton(
                                                  //   onPressed: () async {
                                                  //     modal.controller.updateIsFavoriteDoctor = !modal.controller.getIsFavoriteDoctor;
                                                  //     await specialistDoctorModal.addFavouriteDoctor(context,allowDoctor.serviceProviderDetailsId.toString(),allowDoctor.isFavourite !=1? 1:0);
                                                  //     if(allowDoctor.isFavourite !=1){
                                                  //       specialistDoctorModal.dashboardController.updateFavoriteDoctor(modal.controller.allowDoctorList[index]);
                                                  //     }else{
                                                  //       specialistDoctorModal.dashboardController.removeFavoriteDoctor(modal.controller.allowDoctorList[index]);
                                                  //     }
                                                  //   },
                                                  //   icon: SvgPicture.asset(
                                                  //     allowDoctor.isFavourite ==1?  'assets/heart.svg':'assets/unFavourite.svg',
                                                  //     height: 20,
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "Allow Reports History",
                                              style:
                                              MyTextTheme().mediumBCB.copyWith(fontSize: 15),
                                            ),


                                            SizedBox(
                                              height: 30,
                                              child: Divider(
                                                color: Colors.grey.shade400,
                                                thickness: 1,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 0, 5, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  InkWell(onTap: (){
                                                    print("Inestigation");
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text( 'Do you wants to change report privacy?', textAlign: TextAlign.center,style: MyTextTheme().mediumBCB,),
                                                          contentPadding: const EdgeInsets.all(20),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                          ),
                                                            content: Stack(
                                                              clipBehavior: Clip.none,
                                                              children: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Expanded(
                                                                      child: MyButton(title: localization.getLocaleData.yes.toString(),width: 50,onPress: () async {
                                                                        Navigator.of(context).pop();
                                                                       modal.changePrivacyReport(context, modal.controller.getAllowReportList[0].privacyId.toString());

                                                                      },),
                                                                    ),
                                                                    const SizedBox(width: 25),
                                                                    Expanded(child: MyButton(title: localization.getLocaleData.no.toString(),width: 50,onPress: (){
                                                                      Navigator.of(context).pop();
                                                                    },))
                                                                  ],
                                                                ),

                                                              ],
                                                            )
                                                        );
                                                      }
                                                    );
                                                  },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          modal.controller.getAllowReportList[0].privacyName.toString(),
                                                          style:
                                                          MyTextTheme().mediumBCN,
                                                        ),
                                                        const SizedBox(width: 10,),
                                                        Icon(Icons.check_box,color: AppColor.primaryColor,size: 15,)
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),

                                                  modal.controller.getAllowReportList.length >1 ?

                                                  InkWell(onTap: (){
                                                    print("Prescription");
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                              title: Text( 'Do you wants to change report privacy?', textAlign: TextAlign.center,style: MyTextTheme().mediumBCB,),
                                                              contentPadding: const EdgeInsets.all(20),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0),
                                                              ),
                                                              content: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: <Widget>[
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Expanded(
                                                                        child: MyButton(title: localization.getLocaleData.yes.toString(),width: 50,onPress: () async {
                                                                          Navigator.of(context).pop();
                                                                          modal.changePrivacyReport(context, modal.controller.getAllowReportList[1].privacyId.toString());

                                                                        },),
                                                                      ),
                                                                      const SizedBox(width: 25),
                                                                      Expanded(child: MyButton(title: localization.getLocaleData.no.toString(),width: 50,onPress: (){
                                                                        Navigator.of(context).pop();
                                                                      },))
                                                                    ],
                                                                  ),

                                                                ],
                                                              )
                                                          );
                                                        }
                                                    );
                                                  },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          modal.controller.getAllowReportList[1].privacyName.toString(),
                                                          style:
                                                          MyTextTheme().mediumBCN,
                                                        ),
                                                        const SizedBox(width: 15,),
                                                        Icon(Icons.check_box,color: AppColor.primaryColor,size: 15,)
                                                      ],
                                                    ),
                                                  ): SizedBox()
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              child: Divider(
                                                color: Colors.grey.shade400,
                                                thickness: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        )
                    ],
                );
              }),
        ),
      ),
    );
  }
}

