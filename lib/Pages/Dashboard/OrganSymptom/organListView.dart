
import 'dart:io';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/organ_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/widgets/my_button2.dart';
import '../../Specialities/NewBookAppintment/NewBookAppointmentModal.dart';
import '../../Symptoms/Select_Doctor/select_doctor_controller.dart';
import '../../Symptoms/Select_Doctor/select_doctor_modal.dart';
import '../dashboard_modal.dart';
import 'DataModal/body_organ_data_modal.dart';
import 'DataModal/organ_symptom_data_modal.dart';
import 'organ_controller.dart';

class OrganListView extends StatefulWidget {
  const OrganListView({Key? key}) : super(key: key);

  @override
  State<OrganListView> createState() => _OrganListViewState();
}

class _OrganListViewState extends State<OrganListView> {
  OrganModal modal = OrganModal();
  SelectDoctorModal modal2 = SelectDoctorModal();
  DashboardModal dashboardModal = DashboardModal();
  NewBookAppointmentModal modal3 = NewBookAppointmentModal();

  List languageList = [
    {
      'name': "Hindi",
    },
    {
      'name': "English",
    },
    {
      'name': "Urdu",
    }
  ];




  List  listItemsOne =[].obs;

  additemsInList(context){

    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    listItemsOne=[
      {
        "isSelected":false,
        'img':'assets/abdomen.svg',
        'title':localization.getLocaleData.Abdomen.toString(),
        'id':'1',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/backpain.svg',
        'title':localization.getLocaleData.backPain.toString(),
        'id':'12',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/ear.svg',
        'title':localization.getLocaleData.Ear.toString(),
        'id':'19',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/redeye.svg',
        'title':localization.getLocaleData.eye.toString(),
        'id':'22',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/face.svg',
        'title':localization.getLocaleData.face.toString(),
        'id':'23',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/arm.svg',
        'title':localization.getLocaleData.hand.toString(),
        'id':'27',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/leg.svg',
        'title':localization.getLocaleData.leg.toString(),
        'id':'32',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/mouth.svg',
        'title':localization.getLocaleData.mouth.toString(),
        'id':'34',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/neck.svg',
        'title':localization.getLocaleData.neck.toString(),
        'id':'36',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/nose.svg',
        'title':localization.getLocaleData.nose.toString(),
        'id':'37',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/pelvis.svg',
        'title':localization.getLocaleData.pelvis.toString(),
        'id':'39',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/skin.svg',
        'title':localization.getLocaleData.skin.toString(),
        'id':'42',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/spine.svg',
        'title':localization.getLocaleData.spine.toString(),
        'id':'12',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/mouth.svg',
        'title':localization.getLocaleData.teeth.toString(),
        'id':'43',
        'language':'1'
      },
      {
        "isSelected":false,
        'img':'assets/Clinical Features.svg',
        'title':localization.getLocaleData.fullBody.toString(),
        'id':'50',
        'language':'1'
      },
    ];
  }

  get() {
    clearSelectedList();
  }
  clearSelectedList(){
    for(int i=0;i< listItemsOne.length;i++){
      listItemsOne[i]['isSelected']=false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    get();
    additemsInList(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<OrganController>();
  }

  @override
  Widget build(BuildContext context) {
    additemsInList(context);
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    NewBookAppointmentModal modal2 = NewBookAppointmentModal();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: AppColor.primaryColor,
        child: SafeArea(
          child: GetBuilder(
              init: OrganController(),
              builder: (_) {
                List selectedSymptomsSorted = modal
                    .controller.selectedOrganSymptomList
                  ..sort(
                      (a, b) => a['organ']['id'].compareTo(b['organ']['id']));
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  // appBar: MyWidget().myAppBar(context,
                  //     title:
                  //         localization.getLocaleData.bodySymptoms.toString()),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.all(4.0),
                      //   child: InkWell(
                      //     onTap: (){
                      //       VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
                      //       listenVM.stopListening();
                      //       App().navigate(context,  Speech());
                      //     },
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(5),
                      //         color: Colors.green
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children:  [
                      //           const Icon(Icons.mic,color: Colors.white,),
                      //           Text(localization.getLocaleData.alertToast!.searchSymptomsByVoice.toString(),style: const TextStyle(color: Colors.white,fontSize: 20),),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),


                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(16, 0, 5, 5),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 25),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(UserData().getUserName.toString(),
                      //                 style: MyTextTheme().largePCB.copyWith(
                      //                     color: AppColor.primaryColorLight,
                      //                     fontSize: 25)),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                     UserData()
                      //                                 .getUserGender
                      //                                 .toString() ==
                      //                             '1'
                      //                         ? 'Male'
                      //                         : 'Female',
                      //                     style: MyTextTheme()
                      //                         .mediumGCN
                      //                         .copyWith(fontSize: 18)),
                      //                 Text(
                      //                     " ${DateTime.now().year - int.parse(UserData().getUserDob.split('/')[2])} years ",
                      //                     style: MyTextTheme()
                      //                         .mediumGCN
                      //                         .copyWith(fontSize: 18)),
                      //               ],
                      //             ),
                      //             Text(UserData().getUserMobileNo,
                      //                 style: MyTextTheme()
                      //                     .mediumGCN
                      //                     .copyWith(fontSize: 18)),
                      //             Text(UserData().getUserEmailId,
                      //                 style: MyTextTheme()
                      //                     .mediumGCN
                      //                     .copyWith(fontSize: 18)),
                      //           ],
                      //         ),
                      //       ),
                      //       //Expanded(child: SizedBox()),
                      //       Expanded(
                      //           flex: 8,
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             children: const [
                      //               // Expanded(child: SizedBox()),
                      //               ProfileInfoWidget()
                      //             ],
                      //           )
                      //
                      //           // Row(
                      //           //   crossAxisAlignment: CrossAxisAlignment.start,
                      //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           //   children: [
                      //           //     Image.asset("assets/kiosk_home.png",height: 25,),
                      //           //     SizedBox(width: 10,),
                      //           //
                      //           //     Container(
                      //           //       decoration: BoxDecoration(
                      //           //         shape: BoxShape.circle,
                      //           //         color: AppColor.greyLight,
                      //           //         boxShadow: [
                      //           //           BoxShadow(
                      //           //               blurRadius: 5,
                      //           //               color: AppColor.greyDark,
                      //           //               spreadRadius: 0.2)
                      //           //         ],
                      //           //       ),
                      //           //       child: Row(
                      //           //         //  crossAxisAlignment: CrossAxisAlignment.start,
                      //           //         mainAxisAlignment:
                      //           //         MainAxisAlignment.center,
                      //           //         children: [
                      //           //
                      //           //           Center(
                      //           //             child: CircleAvatar(
                      //           //               radius: 15,
                      //           //               backgroundImage: const AssetImage(
                      //           //                   'assets/noProfileImage.png'),
                      //           //               foregroundImage: NetworkImage(
                      //           //                 UserData()
                      //           //                     .getUserProfilePhotoPath
                      //           //                     .toString(),
                      //           //               ),
                      //           //             ),
                      //           //           ),
                      //           //         ],
                      //           //       ),
                      //           //     ),  SizedBox(width: 10,),
                      //           //
                      //           //     Text(UserData().getUserName.toString(),style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                      //           //     // ,SizedBox(width: 8,),
                      //           //
                      //           //     InkWell(
                      //           //
                      //           //         onTap: (){
                      //           //           dashboardModal.onPressLogout(context);
                      //           //         }
                      //           //         ,child: Image.asset("assets/logout_kiosk.png",height: 20,)),
                      //           //     Visibility(
                      //           //       visible:UserData().getUserData.isNotEmpty,
                      //           //       child: SizedBox(
                      //           //         width: 110,
                      //           //         child: MyCustomSD(
                      //           //             hideSearch: true,
                      //           //             listToSearch:languageList,
                      //           //             valFrom: 'name',
                      //           //             onChanged: (val){
                      //           //
                      //           //             }),
                      //           //       ),
                      //           //     ),
                      //           //     Image.asset("assets/qr_kiosk.png",height: 60,)
                      //           //   ],
                      //           // ),
                      //           ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //   Text(
                      //     "Select your localize and unlocalized problem",
                      //     style: MyTextTheme()
                      //         .mediumGCB
                      //         .copyWith(fontSize: 20),
                      //   ),
                      //   Text(
                      //     "Please select organ where having problem ",
                      //     style: MyTextTheme()
                      //         .mediumGCN
                      //         .copyWith(fontSize: 20),
                      //   ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                       //   color: Colors.red,
                          height: double.infinity,
                          child: Padding(
                            padding: Platform.isAndroid
                                ? const EdgeInsets.all(0)
                                : const EdgeInsets.all(8.0),
                            child: GetBuilder(
                                init: SelectDoctorController(),
                                builder: (_) {
                                return _body(selectedSymptomsSorted,
                                    listItemsOne[0]);
                              }
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
  List<BodyOrganDataModal> get getListItemsOne=>List<BodyOrganDataModal>.from(
      listItemsOne.map((element) => BodyOrganDataModal.fromJson(element)));
  Widget _body(selectedSymptomsSorted, Map Organ) {

    List selectedSymptoms = modal.controller.selectedOrganSymptomList
        .where((element) => element['organ']['id'] == Organ['id'])
        .toList();

    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);

    return Column(
      children: [
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          //Orientation.portrait==MediaQuery.of(context).orientation?60:2
          crossAxisCount: Orientation.portrait==MediaQuery.of(context).orientation?5:5,
          crossAxisSpacing: 0,
          mainAxisSpacing:Orientation.portrait==MediaQuery.of(context).orientation?1:0.01,
          childAspectRatio: Orientation.portrait==MediaQuery.of(context).orientation?1.7:2.5,
          //           crossAxisSpacing: 0.5,
          //           mainAxisSpacing:0.1,
          // scrollDirection: Axis.vertical,
          // itemCount: modal.controller.getListItemsOne.length,
          //itemBuilder:
          children:
              List.generate(getListItemsOne.length, (index) {
            BodyOrganDataModal oragans = getListItemsOne[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {


                    for (var element in listItemsOne) {
                      element["isSelected"] = false;
                    }
                  var a =  listItemsOne[index]["id"];


                    // Create a new map with a different organId
                    Map<String, String> newOrgan = {"organId": a}; // Change 30 to your desired value

                    // Add the new map to the list
                    modal2.controller.organList.add(newOrgan);

                    // Now, organList contains [{"organId": 50}, {"organId": 19}, {"organId": 30}]

                    print(modal2.controller.organList.toString()+'abcd');


                    listItemsOne[index]['isSelected'] = true;

                    modal.controller.updateSelectedLangId =
                        listItemsOne[index]['language'];
                    modal.getOrganSymptomList(context, setState,
                        listItemsOne[index],listItemsOne[index]['id'].toString());
                    // modal.getBodyPartList(context);
                  },
                  child: Container(
                    width: 150,
                    // height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: listItemsOne[index]
                                ['isSelected']
                            ? AppColor.primaryColor
                            : AppColor.white,
                        border: Border.all(color: AppColor.greyLight)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 57,
                              height: 55,
                              child:oragans.id.toString()=='50'? SvgPicture.asset(
                oragans.img.toString(),color: Colors.orange,):SvgPicture.asset(
                                  oragans.img.toString(),)),
                          const SizedBox(width: 5),
                          Text(
                            oragans.title.toString(),
                            style: TextStyle(
                                color: listItemsOne[index]['isSelected']
                                    ? AppColor.white
                                    : AppColor.black,fontWeight: FontWeight.w900,letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            );
          }),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       flex: 2,
          //       child: ListView.builder(
          //         shrinkWrap: true,
          //           scrollDirection: Axis.vertical,
          //           itemCount: modal.controller.getListItemsOne.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             BodyOrganDataModal oragans =
          //                 modal.controller.getListItemsOne[index];
          //             return Column(
          //               children: [
          //                 InkWell(
          //                   onTap: () {
          //
          //                     for (var element
          //                     in  modal.controller.listItemsOne) {
          //                       element["isSelected"] = false;
          //                     }
          //                     modal.controller.listItemsOne[index]['isSelected']=true;
          //
          //                     modal.controller.updateSelectedLangId = modal
          //                         .controller
          //                         .listItemsOne[index]['language'];
          //                     modal.getOrganSymptomList(context, setState,
          //                         modal.controller.listItemsOne[index]);
          //
          //
          //
          //                   },
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(10.0),
          //                     child: Row(
          //                       children: [
          //                         // (selectedSymptomsSorted
          //                         //         .map((e) => e['organ']['id'])
          //                         //         .toList()
          //                         //         .contains(modal.controller
          //                         //             .listItemsOne[index]['id']))
          //                         //     ? Icon(
          //                         //         Icons.check_box,
          //                         //         color: AppColor.primaryColor,
          //                         //       )
          //                         //     : const Icon(
          //                         //         Icons.check_box_outline_blank), // (selectedSymptomsSorted
          //                         //         .map((e) => e['organ']['id'])
          //                         //         .toList()
          //                         //         .contains(modal.controller
          //                         //             .listItemsOne[index]['id']))
          //                         //     ? Icon(
          //                         //         Icons.check_box,
          //                         //         color: AppColor.primaryColor,
          //                         //       )
          //                         //     : const Icon(
          //                         //         Icons.check_box_outline_blank),
          //                         const SizedBox(width: 5),
          //                         Container(
          //                           width: 120,
          //                           decoration: BoxDecoration(
          //                               borderRadius:
          //                                   BorderRadius.circular(10.0),
          //                               color: modal.controller.listItemsOne[index]['isSelected']?AppColor.primaryColor: AppColor.white,
          //                               border: Border.all(
          //                                   color: AppColor.greyLight)),
          //                           child: Padding(
          //                             padding: const EdgeInsets.all(5.0),
          //                             child: Row(
          //                               children: [
          //                                 SizedBox(
          //                                     width: 25,
          //                                     height: 25,
          //                                     child: SvgPicture.asset(
          //                                         oragans.img.toString())),
          //                                 const SizedBox(width: 5),
          //                                 Text(
          //                                   oragans.title.toString(),
          //                                   style: TextStyle(
          //                                     color: modal.controller.listItemsOne[index]['isSelected']?AppColor.white:AppColor.black
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             );
          //           }),
          //     ),
          //     // Expanded(
          //     //     flex: 3,
          //     //     child: Padding(
          //     //       padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
          //     //       child: SvgPicture.asset(
          //     //         'assets/body_digi.svg',
          //     //         fit: BoxFit.fitHeight,
          //     //       ),
          //     //     )),
          //     Expanded(
          //         flex: 4,
          //         child: Padding(
          //           padding: const EdgeInsets.only(right: 20),
          //           child: Container(
          //               //height: Get.height,
          //               decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.circular(10)),
          //               child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(8, 5, 8, 0),
          //                       child: Visibility(
          //                         visible: modal.controller
          //                             .getOrganSymptomList.isNotEmpty,
          //                         child: Row(
          //                           children: [
          //                             Text(
          //                               localization.getLocaleData.diseaseList
          //                                   .toString(),
          //                               style: MyTextTheme().mediumBCB,
          //                             ),
          //                            // const Expanded(child: SizedBox()),
          //                             // IconButton(
          //                             //     onPressed: () {
          //                             //       Navigator.pop(context);
          //                             //       modal.clearSelectedList();
          //                             //     },
          //                             //     icon: const Icon(
          //                             //       Icons.clear,
          //                             //     )),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: MyTextField(
          //                         labelText: 'Search...',
          //                         controller:
          //                             modal.controller.searchC.value,
          //                         onChanged: (val) {
          //                           modal.controller.update();
          //                           setState(() {});
          //                         },
          //                       ),
          //                     ),
          //                     modal.controller
          //                         .getOrganSymptomList.isNotEmpty?
          //                     Expanded(
          //                       child: GetBuilder(
          //                           init: OrganController(),
          //                           builder: (_) {
          //                             return ListView.separated(
          //                               itemCount: modal.controller
          //                                   .getOrganSymptomList.length,
          //                               shrinkWrap: true,
          //                               separatorBuilder:
          //                                   (BuildContext context,
          //                                           int index) =>
          //                                       const SizedBox(
          //                                 height: 10,
          //                               ),
          //                               itemBuilder: (BuildContext context,
          //                                   int index) {
          //                                 OrganSymptom fields = modal
          //                                     .controller
          //                                     .getOrganSymptomList[index];
          //                                 return Padding(
          //                                   padding:
          //                                       const EdgeInsets.fromLTRB(
          //                                           8, 5, 8, 5),
          //                                   child: Column(
          //                                     children: [
          //                                       InkWell(
          //                                         onTap: (() {
          //                                           modal.selectOrganSymptomList(
          //                                               modal.controller
          //                                                       .organSymptomList[
          //                                                   index],
          //                                               Organ);
          //                                         }),
          //                                         child: Row(
          //                                           children: [
          //                                             Icon(Icons.circle,
          //                                                 color: (modal
          //                                                         .controller
          //                                                         .selectedOrganSymptomList
          //                                                         .map((e) =>
          //                                                             e['id'])
          //                                                         .toList()
          //                                                         .contains(
          //                                                             fields
          //                                                                 .id))
          //                                                     ? AppColor
          //                                                         .primaryColor
          //                                                     : AppColor.red),
          //                                             const SizedBox(
          //                                               width: 10,
          //                                             ),
          //                                             Expanded(
          //                                                 child: Text(
          //                                               fields.symptoms
          //                                                   .toString(),
          //                                               style: MyTextTheme()
          //                                                   .smallBCN,
          //                                             )),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 );
          //                               },
          //                             );
          //                           }),
          //                     ):Center(
          //                       child: Text("No Symptom Found",style: MyTextTheme().smallBCN,),
          //                     ),
          //                     Row(
          //                       mainAxisAlignment: MainAxisAlignment.end,
          //                       children: [
          //                         Visibility(
          //                           visible:
          //                               selectedSymptomsSorted.isNotEmpty,
          //                           child: MyButton2(
          //                             width: 100,
          //                             title: localization
          //                                 .getLocaleData.proceed
          //                                 .toString(),
          //                             color: AppColor.blue,
          //                             onPress: () async {
          //                               if (selectedSymptomsSorted
          //                                   .isNotEmpty) {
          //                                 await modal
          //                                     .getDoctorListData(context);
          //                               } else {
          //                                 alertToast(context,
          //                                     'Please select Symptoms');
          //                               }
          //                             },
          //                           ),
          //                         ),
          //                       ],
          //                     )
          //                   ])),
          //         )),
          //   ],
          // ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GetBuilder(
                    init: OrganController(),
                    builder: (_) {
                      //**
                      return
                        GridView.count(
                          shrinkWrap: true,
                          //Orientation.portrait==MediaQuery.of(context).orientation?60:2
                          crossAxisCount: Orientation.portrait==MediaQuery.of(context).orientation?2:5,
                          crossAxisSpacing: 0,
                          mainAxisSpacing:Orientation.portrait==MediaQuery.of(context).orientation?1:0.01,
                          childAspectRatio: Orientation.portrait==MediaQuery.of(context).orientation?9:5,
                          children:
                        List.generate(modal.controller
                          .getOrganSymptomList.length,(index){
                          const SizedBox( height: 10 );
                          ProblemName fields = modal
                                .controller
                                .getOrganSymptomList[index];
                            return Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: (() {
                                        modal.selectOrganSymptomList(
                                            modal.controller.organSymptomList[index], Organ);

                                     //   modal.controller.onTapProblem(organId: , problemId: fields.id.toString());
                                       // print(  modal.controller.selectedOrganSymptomList.toString()+'kbjk');
                                        List<Map<String, dynamic>> convertedList = [];

                                        for (var item in modal.controller.selectedOrganSymptomList) {
                                          convertedList.add({
                                            "organId": item['organ']['id'].toString(),
                                            "problemId": int.parse(item['id'].toString()),
                                          });
                                        }
                                        modal3.controller.updatePrblmOrgn=convertedList;

                                        print(  '${modal3.controller.getProblemAndOrganData}kbjk');

                                      }),
                                      child: Row(
                                        children: [
                                          Icon(Icons.circle,
                                              color: (modal.controller.selectedOrganSymptomList.map((e) => e['id']).toList().contains(fields.id))
                                                  ? AppColor
                                                  .primaryColor
                                                  : AppColor.red),
                                          const SizedBox(width: 10),
                                          Expanded(
                                              child: Text(
                                                fields.problemName
                                                    .toString(),
                                                style: MyTextTheme()
                                                    .smallBCN,overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        );

                    }),
              ),

            ],
          ),
        ),
        Visibility(
          visible:
          selectedSymptomsSorted.isNotEmpty,
          child: MyButton2(
            width: 100,
            title: localization
                .getLocaleData.proceed
                .toString(),
            color: AppColor.blue,
            onPress: () async {
              if (selectedSymptomsSorted
                  .isNotEmpty) {
                await modal
                    .getDoctorListData(context);
              } else {
                alertToast(context,
                    'Please select Symptoms');
              }
            },
          ),
        )
        // Visibility(
        //   visible:
        //   selectedSymptomsSorted.isNotEmpty,
        //   child: MyButton2(
        //     width: 100,
        //     title: localization
        //         .getLocaleData.proceed
        //         .toString(),
        //     color: AppColor.blue,
        //     onPress: () async {
        //       if (selectedSymptomsSorted
        //           .isNotEmpty) {
        //         await modal
        //             .getDoctorListData(context);
        //       } else {
        //         alertToast(context,
        //             'Please select Symptoms');
        //       }
        //     },
        //   ),
        // ),


        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Expanded(
        //       flex: 2,
        //       child: ListView.builder(
        //         shrinkWrap: true,
        //           scrollDirection: Axis.vertical,
        //           itemCount: modal.controller.getListItemsOne.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             BodyOrganDataModal oragans =
        //                 modal.controller.getListItemsOne[index];
        //             return Column(
        //               children: [
        //                 InkWell(
        //                   onTap: () {
        //
        //                     for (var element
        //                     in  modal.controller.listItemsOne) {
        //                       element["isSelected"] = false;
        //                     }
        //                     modal.controller.listItemsOne[index]['isSelected']=true;
        //
        //                     modal.controller.updateSelectedLangId = modal
        //                         .controller
        //                         .listItemsOne[index]['language'];
        //                     modal.getOrganSymptomList(context, setState,
        //                         modal.controller.listItemsOne[index]);
        //
        //
        //
        //                   },
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(10.0),
        //                     child: Row(
        //                       children: [
        //                         // (selectedSymptomsSorted
        //                         //         .map((e) => e['organ']['id'])
        //                         //         .toList()
        //                         //         .contains(modal.controller
        //                         //             .listItemsOne[index]['id']))
        //                         //     ? Icon(
        //                         //         Icons.check_box,
        //                         //         color: AppColor.primaryColor,
        //                         //       )
        //                         //     : const Icon(
        //                         //         Icons.check_box_outline_blank), // (selectedSymptomsSorted
        //                         //         .map((e) => e['organ']['id'])
        //                         //         .toList()
        //                         //         .contains(modal.controller
        //                         //             .listItemsOne[index]['id']))
        //                         //     ? Icon(
        //                         //         Icons.check_box,
        //                         //         color: AppColor.primaryColor,
        //                         //       )
        //                         //     : const Icon(
        //                         //         Icons.check_box_outline_blank),
        //                         const SizedBox(width: 5),
        //                         Container(
        //                           width: 120,
        //                           decoration: BoxDecoration(
        //                               borderRadius:
        //                                   BorderRadius.circular(10.0),
        //                               color: modal.controller.listItemsOne[index]['isSelected']?AppColor.primaryColor: AppColor.white,
        //                               border: Border.all(
        //                                   color: AppColor.greyLight)),
        //                           child: Padding(
        //                             padding: const EdgeInsets.all(5.0),
        //                             child: Row(
        //                               children: [
        //                                 SizedBox(
        //                                     width: 25,
        //                                     height: 25,
        //                                     child: SvgPicture.asset(
        //                                         oragans.img.toString())),
        //                                 const SizedBox(width: 5),
        //                                 Text(
        //                                   oragans.title.toString(),
        //                                   style: TextStyle(
        //                                     color: modal.controller.listItemsOne[index]['isSelected']?AppColor.white:AppColor.black
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             );
        //           }),
        //     ),
        //     // Expanded(
        //     //     flex: 3,
        //     //     child: Padding(
        //     //       padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
        //     //       child: SvgPicture.asset(
        //     //         'assets/body_digi.svg',
        //     //         fit: BoxFit.fitHeight,
        //     //       ),
        //     //     )),
        //     Expanded(
        //         flex: 4,
        //         child: Padding(
        //           padding: const EdgeInsets.only(right: 20),
        //           child: Container(
        //               //height: Get.height,
        //               decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.circular(10)),
        //               child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     Padding(
        //                       padding:
        //                           const EdgeInsets.fromLTRB(8, 5, 8, 0),
        //                       child: Visibility(
        //                         visible: modal.controller
        //                             .getOrganSymptomList.isNotEmpty,
        //                         child: Row(
        //                           children: [
        //                             Text(
        //                               localization.getLocaleData.diseaseList
        //                                   .toString(),
        //                               style: MyTextTheme().mediumBCB,
        //                             ),
        //                            // const Expanded(child: SizedBox()),
        //                             // IconButton(
        //                             //     onPressed: () {
        //                             //       Navigator.pop(context);
        //                             //       modal.clearSelectedList();
        //                             //     },
        //                             //     icon: const Icon(
        //                             //       Icons.clear,
        //                             //     )),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: MyTextField(
        //                         labelText: 'Search...',
        //                         controller:
        //                             modal.controller.searchC.value,
        //                         onChanged: (val) {
        //                           modal.controller.update();
        //                           setState(() {});
        //                         },
        //                       ),
        //                     ),
        //                     modal.controller
        //                         .getOrganSymptomList.isNotEmpty?
        //                     Expanded(
        //                       child: GetBuilder(
        //                           init: OrganController(),
        //                           builder: (_) {
        //                             return ListView.separated(
        //                               itemCount: modal.controller
        //                                   .getOrganSymptomList.length,
        //                               shrinkWrap: true,
        //                               separatorBuilder:
        //                                   (BuildContext context,
        //                                           int index) =>
        //                                       const SizedBox(
        //                                 height: 10,
        //                               ),
        //                               itemBuilder: (BuildContext context,
        //                                   int index) {
        //                                 OrganSymptom fields = modal
        //                                     .controller
        //                                     .getOrganSymptomList[index];
        //                                 return Padding(
        //                                   padding:
        //                                       const EdgeInsets.fromLTRB(
        //                                           8, 5, 8, 5),
        //                                   child: Column(
        //                                     children: [
        //                                       InkWell(
        //                                         onTap: (() {
        //                                           modal.selectOrganSymptomList(
        //                                               modal.controller
        //                                                       .organSymptomList[
        //                                                   index],
        //                                               Organ);
        //                                         }),
        //                                         child: Row(
        //                                           children: [
        //                                             Icon(Icons.circle,
        //                                                 color: (modal
        //                                                         .controller
        //                                                         .selectedOrganSymptomList
        //                                                         .map((e) =>
        //                                                             e['id'])
        //                                                         .toList()
        //                                                         .contains(
        //                                                             fields
        //                                                                 .id))
        //                                                     ? AppColor
        //                                                         .primaryColor
        //                                                     : AppColor.red),
        //                                             const SizedBox(
        //                                               width: 10,
        //                                             ),
        //                                             Expanded(
        //                                                 child: Text(
        //                                               fields.symptoms
        //                                                   .toString(),
        //                                               style: MyTextTheme()
        //                                                   .smallBCN,
        //                                             )),
        //                                           ],
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 );
        //                               },
        //                             );
        //                           }),
        //                     ):Center(
        //                       child: Text("No Symptom Found",style: MyTextTheme().smallBCN,),
        //                     ),
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.end,
        //                       children: [
        //                         Visibility(
        //                           visible:
        //                               selectedSymptomsSorted.isNotEmpty,
        //                           child: MyButton2(
        //                             width: 100,
        //                             title: localization
        //                                 .getLocaleData.proceed
        //                                 .toString(),
        //                             color: AppColor.blue,
        //                             onPress: () async {
        //                               if (selectedSymptomsSorted
        //                                   .isNotEmpty) {
        //                                 await modal
        //                                     .getDoctorListData(context);
        //                               } else {
        //                                 alertToast(context,
        //                                     'Please select Symptoms');
        //                               }
        //                             },
        //                           ),
        //                         ),
        //                       ],
        //                     )
        //                   ])),
        //         )),
        //   ],
        // ),
      ],
    );
  }
}






// Row(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Expanded(
//       flex: 2,
//       child: ListView.builder(
//         shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           itemCount: modal.controller.getListItemsOne.length,
//           itemBuilder: (BuildContext context, int index) {
//             BodyOrganDataModal oragans =
//                 modal.controller.getListItemsOne[index];
//             return Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//
//                     for (var element
//                     in  modal.controller.listItemsOne) {
//                       element["isSelected"] = false;
//                     }
//                     modal.controller.listItemsOne[index]['isSelected']=true;
//
//                     modal.controller.updateSelectedLangId = modal
//                         .controller
//                         .listItemsOne[index]['language'];
//                     modal.getOrganSymptomList(context, setState,
//                         modal.controller.listItemsOne[index]);
//
//
//
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Row(
//                       children: [
//                         // (selectedSymptomsSorted
//                         //         .map((e) => e['organ']['id'])
//                         //         .toList()
//                         //         .contains(modal.controller
//                         //             .listItemsOne[index]['id']))
//                         //     ? Icon(
//                         //         Icons.check_box,
//                         //         color: AppColor.primaryColor,
//                         //       )
//                         //     : const Icon(
//                         //         Icons.check_box_outline_blank), // (selectedSymptomsSorted
//                         //         .map((e) => e['organ']['id'])
//                         //         .toList()
//                         //         .contains(modal.controller
//                         //             .listItemsOne[index]['id']))
//                         //     ? Icon(
//                         //         Icons.check_box,
//                         //         color: AppColor.primaryColor,
//                         //       )
//                         //     : const Icon(
//                         //         Icons.check_box_outline_blank),
//                         const SizedBox(width: 5),
//                         Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.circular(10.0),
//                               color: modal.controller.listItemsOne[index]['isSelected']?AppColor.primaryColor: AppColor.white,
//                               border: Border.all(
//                                   color: AppColor.greyLight)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                     width: 25,
//                                     height: 25,
//                                     child: SvgPicture.asset(
//                                         oragans.img.toString())),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   oragans.title.toString(),
//                                   style: TextStyle(
//                                     color: modal.controller.listItemsOne[index]['isSelected']?AppColor.white:AppColor.black
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }),
//     ),
//     // Expanded(
//     //     flex: 3,
//     //     child: Padding(
//     //       padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
//     //       child: SvgPicture.asset(
//     //         'assets/body_digi.svg',
//     //         fit: BoxFit.fitHeight,
//     //       ),
//     //     )),
//     Expanded(
//         flex: 4,
//         child: Padding(
//           padding: const EdgeInsets.only(right: 20),
//           child: Container(
//               //height: Get.height,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.fromLTRB(8, 5, 8, 0),
//                       child: Visibility(
//                         visible: modal.controller
//                             .getOrganSymptomList.isNotEmpty,
//                         child: Row(
//                           children: [
//                             Text(
//                               localization.getLocaleData.diseaseList
//                                   .toString(),
//                               style: MyTextTheme().mediumBCB,
//                             ),
//                            // const Expanded(child: SizedBox()),
//                             // IconButton(
//                             //     onPressed: () {
//                             //       Navigator.pop(context);
//                             //       modal.clearSelectedList();
//                             //     },
//                             //     icon: const Icon(
//                             //       Icons.clear,
//                             //     )),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: MyTextField(
//                         labelText: 'Search...',
//                         controller:
//                             modal.controller.searchC.value,
//                         onChanged: (val) {
//                           modal.controller.update();
//                           setState(() {});
//                         },
//                       ),
//                     ),
//                     modal.controller
//                         .getOrganSymptomList.isNotEmpty?
//                     Expanded(
//                       child: GetBuilder(
//                           init: OrganController(),
//                           builder: (_) {
//                             return ListView.separated(
//                               itemCount: modal.controller
//                                   .getOrganSymptomList.length,
//                               shrinkWrap: true,
//                               separatorBuilder:
//                                   (BuildContext context,
//                                           int index) =>
//                                       const SizedBox(
//                                 height: 10,
//                               ),
//                               itemBuilder: (BuildContext context,
//                                   int index) {
//                                 OrganSymptom fields = modal
//                                     .controller
//                                     .getOrganSymptomList[index];
//                                 return Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(
//                                           8, 5, 8, 5),
//                                   child: Column(
//                                     children: [
//                                       InkWell(
//                                         onTap: (() {
//                                           modal.selectOrganSymptomList(
//                                               modal.controller
//                                                       .organSymptomList[
//                                                   index],
//                                               Organ);
//                                         }),
//                                         child: Row(
//                                           children: [
//                                             Icon(Icons.circle,
//                                                 color: (modal
//                                                         .controller
//                                                         .selectedOrganSymptomList
//                                                         .map((e) =>
//                                                             e['id'])
//                                                         .toList()
//                                                         .contains(
//                                                             fields
//                                                                 .id))
//                                                     ? AppColor
//                                                         .primaryColor
//                                                     : AppColor.red),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Expanded(
//                                                 child: Text(
//                                               fields.symptoms
//                                                   .toString(),
//                                               style: MyTextTheme()
//                                                   .smallBCN,
//                                             )),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           }),
//                     ):Center(
//                       child: Text("No Symptom Found",style: MyTextTheme().smallBCN,),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Visibility(
//                           visible:
//                               selectedSymptomsSorted.isNotEmpty,
//                           child: MyButton2(
//                             width: 100,
//                             title: localization
//                                 .getLocaleData.proceed
//                                 .toString(),
//                             color: AppColor.blue,
//                             onPress: () async {
//                               if (selectedSymptomsSorted
//                                   .isNotEmpty) {
//                                 await modal
//                                     .getDoctorListData(context);
//                               } else {
//                                 alertToast(context,
//                                     'Please select Symptoms');
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   ])),
//         )),
//   ],
// ),




// ListView.separated(
//                         itemCount: modal.controller
//                             .getOrganSymptomList.length,
//                         shrinkWrap: true,
//                         separatorBuilder:
//                             (BuildContext context,
//                             int index) =>
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         itemBuilder: (BuildContext context,
//                             int index) {
//                           OrganSymptom fields = modal
//                               .controller
//                               .getOrganSymptomList[index];
//                           return Padding(
//                             padding:
//                             const EdgeInsets.fromLTRB(
//                                 8, 5, 8, 5),
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                   onTap: (() {
//                                     modal.selectOrganSymptomList(
//                                         modal.controller
//                                             .organSymptomList[
//                                         index],
//                                         Organ);
//                                   }),
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.circle,
//                                           color: (modal
//                                               .controller
//                                               .selectedOrganSymptomList
//                                               .map((e) =>
//                                           e['id'])
//                                               .toList()
//                                               .contains(
//                                               fields
//                                                   .id))
//                                               ? AppColor
//                                               .primaryColor
//                                               : AppColor.red),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Expanded(
//                                           child: Text(
//                                             fields.symptoms
//                                                 .toString(),
//                                             style: MyTextTheme()
//                                                 .smallBCN,
//                                           )),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );