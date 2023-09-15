

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/common_widgets.dart';
import '../../../../AppManager/widgets/my_button.dart';
import '../../../../AppManager/widgets/my_text_field_2.dart';
import 'Widget/select_body_part_widget.dart';
import 'Widget/sideAnimationWidget.dart';
import 'symptomCheckerController.dart';
import 'symptomCheckerDataModal.dart';
import 'symptomCheckerModal.dart';

class AnimationPage extends StatefulWidget {
  String pageSwitch ="";
  int activeStep;
  AnimationPage({Key? key, required this.pageSwitch, required this.activeStep}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPage();
}

class _AnimationPage extends State<AnimationPage> {

  SymptomCheckerModal modal = SymptomCheckerModal();


  PageController controller = PageController();

  BodyPart selectedBodyPart = BodyPart.notSelected;

  @override
  void initState() {
    if (widget.pageSwitch == "Yes") {
      count = 0;
    }
    else {
      count = 2;
    }
    super.initState();
    get();
  }

  int count = 0;

  get() async {
    await modal.onAddAnyOtherDisease(context);
    await modal.onSuggestedProblem(context,);
    modal.onTapProblemSearch(context);
    modal.onTapDiseaseSearch(context);


  }

  @override
  void dispose() {
    Get.delete<SymptomCheckerController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[
      Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: SelectBodyPartWidget(
              activeStep: 1,
              selectedBodyPart: selectedBodyPart,
              onTapBodyPart: (BodyPart val, String id) async {
                print(val.toString());
                print('nkjghdfhgkjhfgk' + id.toString());
                print('nkjghdfhgkjhfgk' +
                    modal.controller.getBodyOrganRegionList.length.toString());
                selectedBodyPart = BodyPart.notSelected;
                setState(() {

                });

                modal.controller.updateSelectedId = id.toString();


                Timer(const Duration(milliseconds: 500), () async {
                  await modal.onClickAnimation(context);
                  selectedBodyPart = val;
                  setState(() {

                  });
                });
              },
            ),
          ),
          SideAnimationPart(
            bodyPartList:
            (
                modal.controller.getBodyOrganRegionList.length > 6
                    ?
                modal.controller.getBodyOrganRegionList.getRange(0, 5).toList()
                    :
                modal.controller.getBodyOrganRegionList
            )
            ,
            selectedBodyPart: selectedBodyPart, onTapBodyPart: (val, id) {

          },),
          SideAnimationPart(
            reversePosition: true,
            bodyPartList:
            (
                modal.controller.getBodyOrganRegionList.length > 6
                    ?
                modal.controller.getBodyOrganRegionList.getRange(
                    5, modal.controller.getBodyOrganRegionList.length).toList()
                    :
                []
            ),
            selectedBodyPart: selectedBodyPart, onTapBodyPart: (val, id) {},),
        ],
      ),
      allSymptomsWidget(),
      suggestedUnlocalizedProblemWidget(),

    ];
    return SafeArea(
      child: Scaffold(
        //drawer: NavigationDrawerWidget(),
        backgroundColor: AppColor.white,
        // appBar: AppBar(
        //   backgroundColor: AppColor.primaryColor,
        //   title: Text('Symptom Checker', style: MyTextTheme().largeWCB,),
        // ),
        body: GetBuilder(
            init: SymptomCheckerController(),
            builder: (_) {
              return Column(
                children: [
                  SizedBox(height: 25,),
                  Expanded(
                    child: PageView.builder(
                      pageSnapping: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return list[count];
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      onPageChanged: (num) {
                        setState(() {
                          count = num;
                          print(num.toString());
                        });
                      },
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: count,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: AppColor.green,
                      dotColor: AppColor.greyDark,
                    ),
                  ),
                  const SizedBox(height: 10,)
                ],
              );
            }
        ),
        floatingActionButton: GetBuilder(
            init: SymptomCheckerController(),
            builder: (_) {
              return Visibility(
                visible: modal.controller.getSelectSymptomId != '' ||
                    count == 2,
                child: FloatingActionButton(
                    child: const Icon(Icons.arrow_forward_ios),
                    onPressed: () async {
                      if (count <= list.length) {
                        setState(() {
                          if (count < 2) {
                            count++;
                          }
                          else {
                            if (modal.controller.unlocalizedProblemId.isEmpty) {
                              alertToast(context,
                                  'Please select at least one symptom');
                            }
                            else {
                              //App().navigate(context, ThirdPage(activeStep: 2,));
                            }
                          }
                        });
                      }
                      print('faheem');
                      if (count == 1) {
                        await modal.onSymptomsClick(context);
                        modal.controller.update();
                      }
                      else if (count == 2) {
                        modal.controller.update();
                      }
                    }),
              );
            }
        ),
      ),
    );
  }


  allSymptomsWidget() {
    return
      GetBuilder(
          init: SymptomCheckerController(),
          builder: (_) {
            return Column(
              children: [
                // SizedBox(
                //   height:40,
                //   child:
                //   StepperWidget(activeStep: widget.activeStep),
                // ),
                CommonWidgets().showNoData(
                  title: 'Medicine List Data Not Found',
                  show: (modal.controller.getShowNoData &&
                      modal.controller.getAllSymptomsList.isEmpty),
                  loaderTitle: 'Loading Medicine List',
                  showLoader: (!modal.controller.getShowNoData &&
                      modal.controller.getAllSymptomsList.isEmpty),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 10, top: 5),
                          child: Text("Symptoms related to selected body part.",
                              style: MyTextTheme().mediumBCB),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Wrap(
                                  children: List.generate(
                                      modal.controller.getAllSymptomsList.length,
                                          (index) {
                                        SymptomRelatedBodyPartDataModal symptomsData=modal.controller.getAllSymptomsList[index];
                                        return Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                modal.onBodyPartSymptomsTap(index);
                                              });

                                            },
                                            child: Container(
                                                padding: const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: modal.controller.onTapBodyPartSymptomsId.contains(modal.controller.getAllSymptomsList[index].id)?AppColor.primaryColor:Colors.yellow.shade50,
                                                  borderRadius: BorderRadius.circular(5),
                                                  boxShadow:  [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.5),
                                                      blurRadius: 2,
                                                      blurStyle: BlurStyle.solid,
                                                      offset: Offset(1.0,1.0),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  symptomsData.problemName.toString(),
                                                  style:modal.controller.onTapBodyPartSymptomsId.contains(modal.controller.getAllSymptomsList[index].id)? MyTextTheme()
                                                      .smallWCN:MyTextTheme().smallBCN,
                                                )),
                                          ),
                                        );
                                      },
                                      growable: true)),
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            setState(() {
                              count--;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.greyDark),
                                borderRadius: BorderRadius.circular(20),
                                //color: AppColor.orangeButtonColor,
                              ),
                              child: const Icon(Icons.arrow_back),

                            ),
                          ),
                        )
                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       count--;
                        //     });
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 8,top: 12),
                        //     child: Container(
                        //       width: 80,
                        //       padding: const EdgeInsets.fromLTRB(6, 6, 10, 6),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(50),
                        //         border: Border.all(color: AppColor.greyDark),
                        //       ),
                        //       child:
                        //       Row(
                        //         //mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Icon(Icons.arrow_back_ios_new,
                        //               color: AppColor.greyDark),
                        //           const SizedBox(
                        //             width: 10,
                        //           ),
                        //           Text(
                        //             "Back",
                        //             style: MyTextTheme().smallGCN,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
      );
  }

  suggestedUnlocalizedProblemWidget() {
    return GetBuilder(
        init: SymptomCheckerController(),
        builder: (_) {
          return CommonWidgets().showNoData(
            title: 'Medicine List Data Not Found',
            show: (modal.controller.getShowNoData &&
                modal.controller.getSuggestedProblemList.isEmpty),
            loaderTitle: 'Loading Medicine List',
            showLoader: (!modal.controller.getShowNoData &&
                modal.controller.getSuggestedProblemList.isEmpty),
            child: SingleChildScrollView(
              reverse:  true,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Stack(
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //     height: 40,
                        //     child:StepperWidget(activeStep: widget.activeStep,)
                        // ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text("Suggested Unlocalized Problems",
                              style: MyTextTheme().mediumBCB),
                        ),
                        MyTextField2(
                          hintText: "Search & add problems",
                          controller: modal.controller.searchC.value,
                          suffixIcon:
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.search, color: Colors.grey, size: 25),
                          ),
                          onChanged: (val){
                            setState((){
                            });
                          },
                        ),
                        SizedBox(
                            height:Get.height*0.77,
                            child:GetBuilder(
                                init: SymptomCheckerController(),
                                builder: (_) {
                                  return GridView.builder(
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio: 7 / 2,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5),
                                      padding: const EdgeInsets.only(top: 15, left: 1, right: 5),
                                      itemCount: modal.controller.getSuggestedProblemList.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        SuggestedProblemDataModal allProblems=modal.controller.getSuggestedProblemList[index];
                                        return InkWell(
                                          onTap: () async{
                                            modal.controller.updateSelectedPid=allProblems.id.toString();
                                            print('nnnnnnnnnnnnnnnnnnnnnnnn'+allProblems.id.toString());
                                            modal.controller.updateSelectedProblemIndex=index;
                                            modal.onSuggestProblemTap(context,allProblems.id.toString());

                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: modal.controller.unlocalizedProblemId.contains(allProblems.id.toString())?AppColor.primaryColor:Colors.yellow.shade50,
                                                // color: Colors.yellow.shade50,
                                                borderRadius: BorderRadius.circular(5),
                                                boxShadow:  [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    blurRadius: 2,
                                                    blurStyle: BlurStyle.solid,
                                                    offset: const Offset(1.0,1.0),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                allProblems.problemName.toString(),
                                                style:modal.controller.unlocalizedProblemId.contains(allProblems.id.toString())?MyTextTheme().smallWCN:
                                                MyTextTheme().smallBCN,overflow: TextOverflow.ellipsis,
                                              )),
                                        );
                                      });
                                }
                            )

                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                        //   child: Text("Add any other disease you suffered from",
                        //       style: MyTextTheme().mediumBCB),
                        // ),
                        // MyTextField2(
                        //   hintText: "Search disease",
                        //   suffixIcon:
                        //   const Padding(
                        //     padding: EdgeInsets.only(right: 8.0),
                        //     child: Icon(Icons.search, color: Colors.grey, size: 25),
                        //   ),
                        //   controller: modal.controller.diseaseSearchC.value,
                        //   onChanged: (val){
                        //     setState(() {
                        //     });
                        //   },
                        // ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height/4,
                        //   child: GridView.builder(
                        //       gridDelegate:
                        //       const SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisCount: 3,
                        //           childAspectRatio: 7 / 2,
                        //           crossAxisSpacing: 5,
                        //           mainAxisSpacing: 5),
                        //       padding: const EdgeInsets.only(top: 15, left: 1, right: 5),
                        //       itemCount: modal.controller.getAddOtherDiseaseList.length,
                        //       itemBuilder: (BuildContext ctx, index) {
                        //         AddAnyOtherDiseaseDataModal diseaseData =modal.controller.getAddOtherDiseaseList[index];
                        //         return InkWell(
                        //           onTap: (){
                        //             setState(() {
                        //               modal.onTapDisease(diseaseData.id.toString(),context);
                        //             });
                        //           },
                        //           child: Container(
                        //               padding: const EdgeInsets.all(6),
                        //               decoration: BoxDecoration(
                        //                 color: modal.controller.diseaseSufferedId.contains(diseaseData.id.toString())?Colors.lightGreen:Colors.yellow.shade50,
                        //                 borderRadius: BorderRadius.circular(5),
                        //                 boxShadow:  [
                        //                   BoxShadow(color: Colors.grey.withOpacity(0.5),
                        //                     blurRadius: 2,
                        //                     blurStyle: BlurStyle.solid,
                        //                     offset: const Offset(1.0,1.0),)
                        //                 ],
                        //               ),
                        //               child: Text(
                        //                 diseaseData.problemName.toString(),
                        //                 style:modal.controller.diseaseSufferedId.contains(diseaseData.id.toString())?MyTextTheme().smallWCN:
                        //                 MyTextTheme().smallBCN,
                        //                 overflow: TextOverflow.ellipsis,
                        //               )),
                        //         );
                        //       }),
                        // ),
                        const SizedBox(
                          height: 10,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              count--;
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.greyDark),
                              borderRadius: BorderRadius.circular(20),
                              //color: AppColor.orangeButtonColor,
                            ),
                            child: const Icon(Icons.arrow_back),

                          ),
                        )
                      ],
                    ),
                    Positioned(top: 125,left:1,
                        child: AnimatedContainer(
                          height:  modal.controller.searchC.value.text == ""?0: 170,
                          width:400,
                          color: AppColor.white,
                          duration: const Duration(milliseconds: 300),
                          child: ListView.builder(
                            itemCount:modal.controller.getSuggestedSearchList.length,
                            itemBuilder: (BuildContext context, int index){
                              SuggestedUnlocalizedProblemDataModal searchData=modal.controller.getSuggestedSearchList[index];
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8,4,8,4),
                                child: InkWell(
                                    onTap:() async {

                                      modal.addedOption(context, searchData,);

                                    },child: Text( searchData.problemName.toString(),overflow:TextOverflow.ellipsis,)
                                ),
                              );
                            },
                          ),
                        )
                    ),


                    // Positioned(
                    //     bottom: 78,left: 1,
                    //     child: AnimatedContainer(
                    //       duration: const Duration(milliseconds: 300),
                    //       height:modal.controller.getDiseaseSearchList.isEmpty || modal.controller.diseaseSearchC.value.text == ""?0: 170,
                    //       width: 400,
                    //       color: AppColor.white,
                    //       child: ListView.builder(
                    //         itemCount:modal.controller.getDiseaseSearchList.length,
                    //         itemBuilder: (BuildContext context, int index){
                    //           AddAnyOtherDiseaseDataModal diseaseData =modal.controller.getDiseaseSearchList[index];
                    //           return Padding(
                    //             padding: const EdgeInsets.fromLTRB(8,4,8,4),
                    //             child: InkWell(
                    //                 onTap: (){
                    //                   modal.addedDisease(context,diseaseData);
                    //                 },
                    //                 child: Text(diseaseData.problemName.toString())),
                    //           );
                    //         },
                    //       ),
                    //     ))
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}




onTapSuggestedProblemSymptomsWidget(context){
  SymptomCheckerModal modal=SymptomCheckerModal();

  AlertDialogue2().show(context, "", "",
      newWidget: Container(
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
              child: Row(
                children: [
                  Text("Attribute List",style: MyTextTheme().mediumBCB,),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                      )),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder(
                  init: SymptomCheckerController(),
                  builder: (_) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: modal.controller.getProblemsSymptomsTapList.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProblemSymptomsDataModal attributeData=modal.controller.getProblemsSymptomsTapList[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        attributeData.attributeName.toString(),
                                        style: MyTextTheme().mediumBCB,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 2,
                                    children: List.generate( attributeData.attribute!.length,
                                            (index2) {
                                          var details =
                                          attributeData
                                              .attribute![index2];
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 8, 5),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: (()   {
                                                    modal.onTapAttribute(context,modal.controller.problemsSymptomsTapList[index]['attribute'][index2],index,index2,attributeData.attributeName.toString());
                                                  }),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.circle,
                                                          color:  details.isSelected==true? Colors.red:Colors.grey
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                            details.attributeValue.toString()  ,
                                                            style: MyTextTheme()
                                                                .smallBCN,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        })),
                              ],
                            ),
                          );
                        });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
              child: Divider(
                color: AppColor.greyDark,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5,left: 0,right: 10,bottom: 10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [

                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft:Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: MyButton(
                      width: 80,
                      color: AppColor.primaryColor,
                      title: 'OK',
                      onPress: ()async{
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ])));





}
