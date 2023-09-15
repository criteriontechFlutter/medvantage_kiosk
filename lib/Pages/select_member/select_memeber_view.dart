import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/Pages/select_member/select_memeber_controller.dart';
import 'package:digi_doctor/Pages/select_member/select_memeber_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/app_color.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/my_text_theme.dart';
import '../../AppManager/tab_responsive.dart';
import '../../AppManager/user_data.dart';
import '../../AppManager/widgets/common_widgets.dart';
import '../../AppManager/widgets/my_app_bar.dart';
import '../../AppManager/widgets/my_button.dart';
import '../Dashboard/Widget/profile_info_widget.dart';
import '../Dashboard/dashboard_view.dart';

import '../Specialities/top_specialities_view.dart';
import 'AddMember/add_member_view.dart';
import 'DataModal/select_member_data_modal.dart';

class SelectMember extends StatefulWidget {
  final String pageName;

  const SelectMember({Key? key, required this.pageName}) : super(key: key);

  @override
  _SelectMemberState createState() => _SelectMemberState();
}

class _SelectMemberState extends State<SelectMember> {
  List optionList=[
    {
      'icon':"assets/kiosk_setting.png",
      'name':"Find Doctor By Specialty",
      'isChecked':true
    },
    {
      'icon':"assets/kiosk_symptoms.png",
      'name':"Find Doctors By Symptoms",
      'isChecked':false
    },
  ];
  bool isDoctor = true;
  SelectMemberModal modal = SelectMemberModal();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
  }

  get() async {
    await modal.getMember(context);
    var da = DateTime.now().subtract(const Duration(days: 1));
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SelectMemberController>();
  }
//**
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Scaffold(
      //  appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.selectMember.toString()),
        body: GetBuilder(
          init: SelectMemberController(),
          builder: (_) {
            return Container(

              width: Get.width,
              decoration:   BoxDecoration(
                //***
                  color: AppColor.primaryColorLight,
                  image: const DecorationImage(
                      image:  AssetImage("assets/kiosk_bg.png"),
                      // Orientation.portrait==MediaQuery.of(context).orientation?
                      //  AssetImage("assets/kiosk_bg.png",):
                      // AssetImage("assets/kiosk_bg_img.png",),

                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  // Expanded(
                  //
                  //   child: ListView(
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           ProfileInfoWidget(),
                  //           Padding(
                  //             padding: const EdgeInsets.all(12.0),
                  //             child: Container(
                  //               color: AppColor
                  //                   .primaryColorLight,
                  //               child: Padding(
                  //                 padding:
                  //                 const EdgeInsets.all(
                  //                     8.0),
                  //                 child: Row(
                  //                   children: [
                  //                     Image.asset(
                  //                       "assets/kiosk_setting.png",
                  //                       height: 40,
                  //                     ),
                  //
                  //                     Expanded(
                  //                       child: Text(
                  //                         "Select Member",
                  //                         style: MyTextTheme()
                  //                             .largeWCN,
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           // Row(
                  //           //   children: [
                  //           //     Expanded(
                  //           //       flex: 2,
                  //           //       child: Container(
                  //           //         height:Get.height,
                  //           //         //820,
                  //           //         // MediaQuery.of(context).size.height * .89,
                  //           //         color: AppColor.primaryColor,
                  //           //         child: Padding(
                  //           //           padding: const EdgeInsets.symmetric(
                  //           //               vertical: 56, horizontal: 12),
                  //           //           child: Column(
                  //           //             crossAxisAlignment:
                  //           //             CrossAxisAlignment.start,
                  //           //             children: [
                  //           //
                  //           //               const SizedBox(
                  //           //                 height: 10,
                  //           //               ),
                  //           //               //*********
                  //           //               Container(
                  //           //                 color: AppColor
                  //           //                     .primaryColorLight,
                  //           //                 child: Padding(
                  //           //                   padding:
                  //           //                   const EdgeInsets.all(
                  //           //                       8.0),
                  //           //                   child: Row(
                  //           //                     children: [
                  //           //                       Image.asset(
                  //           //                         "assets/kiosk_setting.png",
                  //           //                         height: 40,
                  //           //                       ),
                  //           //
                  //           //                       Expanded(
                  //           //                         child: Text(
                  //           //                         "Select Member",
                  //           //                           style: MyTextTheme()
                  //           //                               .largeWCN,
                  //           //                         ),
                  //           //                       )
                  //           //                     ],
                  //           //                   ),
                  //           //                 ),
                  //           //               ),
                  //           //               // Expanded(
                  //           //               //   child: ListView.builder(itemCount: modal.controller.getOption(context).length,
                  //           //               //       itemBuilder:(BuildContext context,int index){
                  //           //               //         // OptionDataModal opt=modal.controller.getOption(context)[index];
                  //           //               //         OptionDataModals opts=modal.controller.getOption(context)[index];
                  //           //               //         return Padding(
                  //           //               //           padding:
                  //           //               //           const EdgeInsets.symmetric(
                  //           //               //               vertical: 20,
                  //           //               //               horizontal: 12),
                  //           //               //           child: InkWell(
                  //           //               //             onTap: (){
                  //           //               //               setState(() {
                  //           //               //                 if(index==0){
                  //           //               //                   isDoctor = true;
                  //           //               //                   App().navigate(context, TopSpecialitiesView());
                  //           //               //                 }
                  //           //               //                 else{
                  //           //               //                   isDoctor = false;
                  //           //               //                   App().navigate(context, TopSpecialitiesView(isDoctor:1));
                  //           //               //
                  //           //               //                 }
                  //           //               //               });
                  //           //               //               for (var element
                  //           //               //               in optionList) {
                  //           //               //                 element["isChecked"] = false;
                  //           //               //               }
                  //           //               //               optionList[index]['isChecked']=true;
                  //           //               //
                  //           //               //
                  //           //               //
                  //           //               //
                  //           //               //
                  //           //               //             },
                  //           //               //
                  //           //               //             child:
                  //           //               //             Container(
                  //           //               //               color: optionList[index]['isChecked']?AppColor
                  //           //               //                   .primaryColorLight:AppColor.primaryColor,
                  //           //               //               child: Padding(
                  //           //               //                 padding:
                  //           //               //                 const EdgeInsets.all(
                  //           //               //                     8.0),
                  //           //               //                 child: Row(
                  //           //               //                   children: [
                  //           //               //                     Image.asset(
                  //           //               //                       optionList[index]['icon'],
                  //           //               //                       height: 40,
                  //           //               //                     ),
                  //           //               //                     const SizedBox(
                  //           //               //                       width: 10,
                  //           //               //                     ),
                  //           //               //                     Expanded(
                  //           //               //                       child: Text(
                  //           //               //                         opts.optionText.toString(),
                  //           //               //                         style: MyTextTheme()
                  //           //               //                             .largeWCN,
                  //           //               //                       ),
                  //           //               //                     )
                  //           //               //                   ],
                  //           //               //                 ),
                  //           //               //               ),
                  //           //               //             ),
                  //           //               //           ),
                  //           //               //         );
                  //           //               //       }),
                  //           //               // ),
                  //           //
                  //           //             ],
                  //           //           ),
                  //           //         ),
                  //           //       ),
                  //           //     ),
                  //           //   ],
                  //           // )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProfileInfoWidget(),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            color: AppColor
                                .primaryColorLight,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(
                                  8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/kiosk_setting.png",
                                    height: 40,
                                  ),

                                  Expanded(
                                    child: Text(
                                      localization.getLocaleData!.selectMember.toString(),
                                      style: MyTextTheme()
                                          .largeWCN,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 2,
                        //       child: Container(
                        //         height:Get.height,
                        //         //820,
                        //         // MediaQuery.of(context).size.height * .89,
                        //         color: AppColor.primaryColor,
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 56, horizontal: 12),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //             children: [
                        //
                        //               const SizedBox(
                        //                 height: 10,
                        //               ),
                        //               //*********
                        //               Container(
                        //                 color: AppColor
                        //                     .primaryColorLight,
                        //                 child: Padding(
                        //                   padding:
                        //                   const EdgeInsets.all(
                        //                       8.0),
                        //                   child: Row(
                        //                     children: [
                        //                       Image.asset(
                        //                         "assets/kiosk_setting.png",
                        //                         height: 40,
                        //                       ),
                        //
                        //                       Expanded(
                        //                         child: Text(
                        //                         "Select Member",
                        //                           style: MyTextTheme()
                        //                               .largeWCN,
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //               // Expanded(
                        //               //   child: ListView.builder(itemCount: modal.controller.getOption(context).length,
                        //               //       itemBuilder:(BuildContext context,int index){
                        //               //         // OptionDataModal opt=modal.controller.getOption(context)[index];
                        //               //         OptionDataModals opts=modal.controller.getOption(context)[index];
                        //               //         return Padding(
                        //               //           padding:
                        //               //           const EdgeInsets.symmetric(
                        //               //               vertical: 20,
                        //               //               horizontal: 12),
                        //               //           child: InkWell(
                        //               //             onTap: (){
                        //               //               setState(() {
                        //               //                 if(index==0){
                        //               //                   isDoctor = true;
                        //               //                   App().navigate(context, TopSpecialitiesView());
                        //               //                 }
                        //               //                 else{
                        //               //                   isDoctor = false;
                        //               //                   App().navigate(context, TopSpecialitiesView(isDoctor:1));
                        //               //
                        //               //                 }
                        //               //               });
                        //               //               for (var element
                        //               //               in optionList) {
                        //               //                 element["isChecked"] = false;
                        //               //               }
                        //               //               optionList[index]['isChecked']=true;
                        //               //
                        //               //
                        //               //
                        //               //
                        //               //
                        //               //             },
                        //               //
                        //               //             child:
                        //               //             Container(
                        //               //               color: optionList[index]['isChecked']?AppColor
                        //               //                   .primaryColorLight:AppColor.primaryColor,
                        //               //               child: Padding(
                        //               //                 padding:
                        //               //                 const EdgeInsets.all(
                        //               //                     8.0),
                        //               //                 child: Row(
                        //               //                   children: [
                        //               //                     Image.asset(
                        //               //                       optionList[index]['icon'],
                        //               //                       height: 40,
                        //               //                     ),
                        //               //                     const SizedBox(
                        //               //                       width: 10,
                        //               //                     ),
                        //               //                     Expanded(
                        //               //                       child: Text(
                        //               //                         opts.optionText.toString(),
                        //               //                         style: MyTextTheme()
                        //               //                             .largeWCN,
                        //               //                       ),
                        //               //                     )
                        //               //                   ],
                        //               //                 ),
                        //               //               ),
                        //               //             ),
                        //               //           ),
                        //               //         );
                        //               //       }),
                        //               // ),
                        //
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,8,16,0),
                      child: Container(
                        color: AppColor.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Text(localization.getLocaleData.selectMember.toString(),style: MyTextTheme().largeBCB.copyWith(fontSize: 24)),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      localization.getLocaleData.addFamilyMember.toString(),
                                      style: MyTextTheme().largeBCB,
                                    ),
                                  ),
                                 Expanded(
                                   child: MyButton(
                                        title: localization.getLocaleData.addC.toString(),
                                        width: 80,
                                        onPress: () {
                                          App().navigate(context, const AddMember());
                                        },
                                      ),
                                 ),

                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: CommonWidgets().showNoData(
                                          title: localization.getLocaleData.familyMemberDataNotFound.toString(),
                                          show: (modal.controller.getShowNoData &&
                                              modal.controller.getSelectMember.isEmpty),
                                          loaderTitle: localization.getLocaleData.loadingFamilyMemberData.toString(),
                                          showLoader: (!modal.controller.getShowNoData &&
                                              modal.controller.getSelectMember.isEmpty),
                                          child: ListView(
                                            children: [
                                              StaggeredGrid.count(
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 0.0,
                                                crossAxisCount: MediaQuery.of(context).size.width>600? 2:1,
                                                children: List.generate(
                                                  modal.controller.selectMember.length,
                                                      (index) {
                                                  SelectMemberDataModal details = modal
                                                          .controller.selectMember.isEmpty
                                                      ? SelectMemberDataModal()
                                                      : modal.controller.getSelectMember[index];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        modal.controller.updateSelectedMemberId =
                                                            details.memberId.toString();
                                                        if (widget.pageName.toString() ==
                                                            'Drawer') {
                                                          App().replaceNavigate(
                                                              context, const StartupPage());
                                                        } else {
                                                          Navigator.pop(context);
                                                        }

                                                        await modal.getMember(context);
                                                      },
                                                      child: Card(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(10),
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 21,
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(50),
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: details
                                                                        .profilePhotoPath
                                                                        .toString(),
                                                                    placeholder: (context, url) =>
                                                                        Image.asset(
                                                                            'assets/noProfileImage.png'),
                                                                    errorWidget:
                                                                        (context, url, error) =>
                                                                            CircleAvatar(
                                                                      radius: 20,
                                                                      child: ClipOval(
                                                                        child: Image.asset(
                                                                          'assets/noProfileImage.png',
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    height: 50,
                                                                    width: 50,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      details.name.toString(),
                                                                      style:
                                                                          MyTextTheme().largeBCB,
                                                                    ),
                                                                    Text(
                                                                      details.age.toString(),
                                                                      style:
                                                                          MyTextTheme().mediumBCN,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: details.primaryStatus!=1,
                                                                child: InkWell(
                                                                  child: Icon(
                                                                    Icons.delete,
                                                                    color: AppColor.red,
                                                                    size: 32,
                                                                  ),
                                                                  onTap: () {
                                                                    modal.controller
                                                                            .updateSelectedMemberId =
                                                                        details.memberId.toString();
                                                                    modal.onPressedDelete(context);
                                                                  },
                                                                ),
                                                              )
                                                              // Text(modal.controller.getSelectMember.toString()),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                        ),
                                            ],
                                          ),
                                      ),
                                    )
                                    )],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,)
                  //
                ],
              ),
            );
          },
        ));
  }
}
