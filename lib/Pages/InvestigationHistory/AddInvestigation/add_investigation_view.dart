import '../../../AppManager/getImage.dart';
import '../../../Localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/tab_responsive.dart';
import '../../../AppManager/widgets/date_time_field.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import 'add_investigation_controller.dart';
import 'add_investigation_modal.dart';
import 'dart:io';

class AddInvestigationView extends StatefulWidget {
  const AddInvestigationView({Key? key}) : super(key: key);

  @override
  State<AddInvestigationView> createState() => _AddInvestigationViewState();
}

class _AddInvestigationViewState extends State<AddInvestigationView> {

  AddInvestigationModal modal = AddInvestigationModal();
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    Get.delete<AddInvestigationController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
            appBar:MyWidget().myAppBar(context, title: localization.getLocaleData.addInvestigation.toString()),
            body: GetBuilder(
                init: AddInvestigationController(),
                builder: (_) {
                  return Form(
                    key: modal.controller.formKey.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child:
                    TabResponsive().wrapInTab(
                      context: context,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
                                child: Column(children: [
                                  // Text(
                                  //   localization.getLocaleData.addInvestigationDetails.toString(),
                                  //   style: MyTextTheme().largeBCN,
                                  // ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  Container(
                                      decoration:
                                      BoxDecoration(color: AppColor.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                localization.getLocaleData.addPathologyInformation.toString(),
                                              style: MyTextTheme().mediumBCB,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            MyTextField2(
                                              controller: modal.controller.pathologyC.value,
                                              prefixIcon:SizedBox(height:2,width:2,child: Center(child: SvgPicture.asset('assets/hospital.svg'))) ,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return localization.getLocaleData.validationText!.enterPathologyOrHospitalName.toString();
                                                }
                                              },
                                              hintText: localization.getLocaleData.hintText!.pathologyHospitalName.toString(),
                                              borderColor: AppColor.greyLight,
                                            ),
                                            const SizedBox(height: 10,),
                                            MyTextField2(
                                              controller: modal.controller.receiptC.value,
                                                prefixIcon:SizedBox(height: 2,width: 2,
                                                    child: Center(child: SvgPicture.asset('assets/receipt.svg'))),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return localization.getLocaleData.validationText!.enterReceiptNo.toString();
                                                }
                                              },
                                              hintText: localization.getLocaleData.hintText!.receiptNo.toString(),
                                              borderColor: AppColor.greyLight,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),

                                            MyDateTimeField(
                                              controller: modal.controller.testDateC.value,
                                              validator: (value){
                                                print(value.toString());
                                                if(value!.isEmpty){
                                                  return localization.getLocaleData.hintText!.pleaseEnterDate.toString();
                                                }
                                              },
                                              hintText: localization.getLocaleData.testDate.toString(),
                                              borderColor: AppColor.greyLight,
                                              prefixIcon:   const Icon(
                                                Icons.calendar_today,color: Colors.blue, ),
                                              // suffixIcon: Icon(Icons.person),
                                            ),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: modal.controller.files.isEmpty,
                                    child: Container(
                                        decoration:
                                        BoxDecoration(color: AppColor.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                localization.getLocaleData.testInformation.toString(),
                                                style: MyTextTheme().mediumBCB,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),

                                              const SizedBox(height: 10,),
                                              MyTextField2(
                                                controller:modal.controller.testNameC.value,
                                                suffixIcon: const Icon(Icons.arrow_drop_down_sharp),
                                                prefixIcon:SizedBox(height:2,width: 2,child: Center(child: SvgPicture.asset('assets/receipt.svg'),),),
                                                hintText: localization.getLocaleData.testName.toString(),
                                                searchedList:modal.controller.getSearchedTest,
                                                onTap: (){
                                                  modal.controller.update();
                                                },
                                                  showSearchedList:modal.controller.testNameC.value.text!='',
                                                searchParam: 'name',

                                                onTapSearchedData: (val){
                                                  if(val!=null){
                                                    print(val.toString());
                                                    modal.controller.onTapTest(val);
                                                    print(modal.controller.testID.value.toString());
                                                    //FocusManager.instance.primaryFocus?.unfocus();
                                                    modal.controller.update();
                                                  }
                                                },
                                                onChanged: (val){
                                                  print('this is value'+val.toString());
                                                  if(val.toString().isNotEmpty) {
                                                    modal.getTest(context);

                                                  }
                                                  else{
                                                    modal.controller.updateSearchedTest=[];
                                                    modal.controller.update();
                                                  }
                                                  modal.controller.update();
                                                },
                                              ),


                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [

                                                  Expanded(
                                                    child: MyTextField2(
                                                      controller: modal.controller.valueC.value,
                                                      hintText: localization.getLocaleData.value.toString(),
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(flex: 2,
                                                    child: MyTextField2(
                                                      controller: modal.controller.unitC.value,
                                                      suffixIcon: const Icon(Icons.arrow_drop_down_sharp),
                                                      hintText: localization.getLocaleData.unit.toString(),
                                                      borderColor:
                                                      AppColor.greyLight,
                                                      searchedList:modal.controller.getSearchedUnit,
                                                      onTap: (){
                                                        modal.controller.update();
                                                      },
                                                      showSearchedList:modal.controller.unitC.value.text!='',

                                                      searchParam: 'name',

                                                      onTapSearchedData: (val){
                                                        if(val!=null){
                                                          modal.controller.onTapUnit(val);
                                                          modal.controller.update();
                                                        }
                                                      },
                                                      onChanged: (val) async {

                                                        print('this is value'+val.toString());
                                                        if(val.toString().isNotEmpty) {
                                                          await modal.getUnit(context);

                                                        }
                                                        else{
                                                          //modal.controller.updateSearchedTest=[];
                                                          modal.controller.update();
                                                        }
                                                        modal.controller.update();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                              MyTextField2(hintText: localization.getLocaleData.remark.toString(),
                                                maxLine:3,
                                                controller: modal.controller.remarkC.value,),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const Expanded(child: SizedBox()),
                                                  Expanded(
                                                    child: MyButton(
                                                      title: localization.getLocaleData.addTest.toString(),
                                                      buttonRadius: 25,
                                                      width: 120,
                                                      onPress: () async {
                                                        if(modal.controller.testID.value!=''){
                                                          if(modal.controller.unitID.value!=''){
                                                            await modal.onPressedAddTest(context);
                                                            print(modal.controller.addedTestList.toString());
                                                          }
                                                          else{
                                                            alertToast(context, localization.getLocaleData.alertToast!.pleaseSelectUnit.toString());
                                                          }
                                                        }
                                                        else{
                                                          alertToast(context, localization.getLocaleData.alertToast!.pleaseSelectTest.toString());
                                                        }

                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Visibility(
                                    visible: modal.controller.files.isEmpty,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount:modal.controller.getAddedTestList.length,
                                        itemBuilder: (BuildContext context, int index) {

                                          return Container(
                                            color: AppColor.lightBackground,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 10, 5, 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      size: 15,
                                                      color: AppColor.green,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text( modal.controller.getAddedTestList[index]['testName'].toString(),
                                                        style: MyTextTheme().mediumBCB,
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            modal.controller
                                                                .getAddedTestList
                                                                .removeAt(index);
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: AppColor.red,
                                                        ))
                                                  ]),
                                                  const SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children:   [
                                                      Column(
                                                        children: [
                                                          Text(localization.getLocaleData.value.toString(),style: MyTextTheme().smallGCN,),
                                                          Text(modal.controller.getAddedTestList[index]['testValue'].toString(),style: MyTextTheme().smallBCN,),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(localization.getLocaleData.unit.toString(),style: MyTextTheme().smallGCN,),
                                                          Text(modal.controller.getAddedTestList[index]['unit'].toString(),style: MyTextTheme().smallBCN,),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Visibility(
                                                    visible:modal.controller.getAddedTestList[index]['remark'].toString()!='',
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(localization.getLocaleData.remark.toString(),style: MyTextTheme().smallGCN,),
                                                        const SizedBox(width: 15,),
                                                        Expanded(child: Text(modal.controller.getAddedTestList[index]['remark'].toString(),style: MyTextTheme().smallBCN,)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  // modal.controller.dtDataList.add()
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible:modal.controller.addedTestList.isEmpty ,
                                    child: Container(
                                        decoration:
                                        BoxDecoration(color: AppColor.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                localization.getLocaleData.attachPrescriptionFile.toString(),
                                                style: MyTextTheme().mediumBCB,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Visibility(
                                                    visible: modal.controller.getFiles.isNotEmpty,
                                                    child: GridView.builder(
                                                      shrinkWrap: true,
                                                     physics: const NeverScrollableScrollPhysics(),
                                                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                                            maxCrossAxisExtent: 150,
                                                            childAspectRatio: 2 / 4,
                                                            crossAxisSpacing: 10,
                                                            mainAxisSpacing: 10),
                                                        itemCount: modal.controller.getFiles.length,
                                                        itemBuilder: (BuildContext ctx, index) {
                                                          return Stack(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 3),
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    border: Border.all(
                                                                      color: Colors.brown,
                                                                      width: 3
                                                                    )
                                                                  ),
                                                                    child: Image.file(File(modal.controller.getFiles[index]['filePath'].toString(),),width: 200,height: 200,fit: BoxFit.fill,)),
                                                              ),
                                                              Positioned(
                                                                right: 0,
                                                                child: InkWell(
                                                                  onTap: (){
                                                                    modal.controller.files.removeAt(index);
                                                                    modal.controller.update();
                                                                  },
                                                                  child: Container(
                                                                     height: 15,width: 15,
                                                                    decoration: const BoxDecoration(
                                                                      color: Colors.red,
                                                                      shape: BoxShape.circle
                                                                    ),
                                                                    child: const Icon(Icons.clear,color: Colors.white,size: 10,),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        }),
                                                  ),
                                                  const SizedBox(height: 8,),
                                                  InkWell(
                                                    onTap: (){
                                                      if(modal.controller.getFiles.length<=3){
                                                        showAlertDialog(context);
                                                      }
                                                      else{
                                                        alertToast(context, localization.getLocaleData.alertToast!.maximumFilesLimitReached.toString());
                                                      }

                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.camera_alt,size: 18),
                                                        const SizedBox(width: 5,),
                                                        Text(localization.getLocaleData.uploadFile.toString())
                                                      ],
                                                    ),
                                                  )
                                                  // const Align(
                                                  //     alignment: Alignment.center,
                                                  //     child: Text(localization.getLocaleData.camera.toString())),
                                                  // InkWell(
                                                  //   onTap: () async{
                                                  //     //getImage(ImageSource.camera);
                                                  //     final file = await MyImagePicker().getCameraImage();
                                                  //     modal.controller.updateProfile = File(file.path);
                                                  //   },
                                                  //   child: modal.controller
                                                  //       .getProfile ==
                                                  //       null
                                                  //       ? SvgPicture.asset(
                                                  //     'assets/cameraicon.svg',
                                                  //     width: 100,
                                                  //     height: 100,
                                                  //   ):
                                                  //     Image.file(
                                                  //      File(modal.controller
                                                  //          .getProfile!.path
                                                  //          .toString()),
                                                  //      width: 100,
                                                  //     height: 100,
                                                  //    ),
                                                  // ),
                                                  // const SizedBox(
                                                  //   height: 15,
                                                  // ),
                                                  // const Text(localization.getLocaleData.or.toString()),
                                                  // const SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  // MyButton(
                                                  //   title: localization.getLocaleData.browse.toString(),
                                                  //   buttonRadius: 20,
                                                  //   width: 150,
                                                  //   onPress: () {
                                                  //     //getImage(ImageSource.gallery);
                                                  //     // AlertDialogue().show(context);
                                                  //   },
                                                  // ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:MyButton(
                              title: localization.getLocaleData.submit.toString(),
                              buttonRadius: 20,
                              onPress: ()async{
                                if(modal.controller.files.isNotEmpty){
                                  AlertDialogue().show(context,
                                      msg: localization.getLocaleData.alertToast!.youWantToSubmit.toString(),
                                      firstButtonName: localization.getLocaleData.confirm.toString(),
                                      showOkButton: false, firstButtonPressEvent: () async {
                                        Navigator.pop(context);
                                        await modal.saveMultipleFile(context);
                                      }, showCancelButton: true);
                                }
                                else{
                                  if(modal.controller.formKey.value.currentState!.validate()){
                                    if(modal.controller.addedTestList.isNotEmpty){
                                      AlertDialogue().show(context,
                                          msg: localization.getLocaleData.alertToast!.youWantToSubmit.toString(),
                                          firstButtonName: localization.getLocaleData.confirm.toString(),
                                          showOkButton: false, firstButtonPressEvent: () async {
                                            Navigator.pop(context);
                                            await  modal.addInvestigation(context,'');
                                          }, showCancelButton: true);

                                    }
                                    else{
                                      alertToast(context, localization.getLocaleData.alertToast!.pleaseAddTestInformation.toString());
                                    }

                                  }

                                }

                              },
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  );
    })
        )
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    // show the dialog
    showDialog(
      barrierDismissible: false,

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          contentPadding: EdgeInsets.zero,
          content:
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Expanded(child: Text(localization.getLocaleData.uploadFile.toString())),

                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.clear))
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: ()async{
                          Navigator.pop(context);
                               final file = await MyImagePicker().getCameraImage();
                               modal.controller.updateProfile = File(file.path);
                               modal.controller.files.add({
                                 "filePath":modal.controller.getProfile!.path
                               });
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.camera_alt,color: Colors.grey,),
                            const SizedBox(width: 5,),
                            Text(localization.getLocaleData.camera.toString(),style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: ()async{
                          Navigator.pop(context);
                          final file = await MyImagePicker().getImage();
                          modal.controller.updateProfile = File(file.path);
                          modal.controller.files.add({
                            "filePath":modal.controller.getProfile!.path
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.folder,color: Colors.grey),
                            const SizedBox(width: 5,),
                            Text(localization.getLocaleData.browse.toString(),style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
