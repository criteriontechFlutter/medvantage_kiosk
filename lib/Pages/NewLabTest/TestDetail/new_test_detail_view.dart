import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import 'chart/new_chart_view.dart';
import 'new_test_detail_controller.dart';
import 'DataModal/new_test_detail_data_modal.dart';
class NewTestDetailView extends StatelessWidget {
  const NewTestDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewTestDetailController controller = Get.put(NewTestDetailController());
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar:MyWidget().myAppBar(context, title: "View Reports"),
          body: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Obx(() =>controller.getTestDetailList.isEmpty?Expanded(
                    child: Center(child: CommonWidgets().showNoData(loaderTitle:"loading...",showLoader:!controller.showNoData.value,
                      show:controller.showNoData.value&&controller.getTestDetailList.isEmpty,)),
                  )
                      : Flexible(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: controller.getTestDetailList.length,
                      separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 15,),
                      itemBuilder: (BuildContext context, int index){
                        NewTestDetailDataModal testData = controller.getTestDetailList[index];
                        return CustomInkwell(
                          borderRadius: 12,
                          color: AppColor.white,elevation: 3,shadowColor:Colors.grey,
                          onPress: (){},
                          child: ExpansionTile(
                              leading:  const Icon(Icons.text_snippet),
                              trailing: const Icon(Icons.arrow_drop_down_circle_rounded,color:Colors.grey,),
                              title: Padding(
                                padding: const EdgeInsets.fromLTRB(5,10,5,10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(testData.itemName.toString(),style: MyTextTheme().largeBCB,),
                                    Row(
                                      children: [
                                        Text('${testData.collectionDate!.substring(0, testData.collectionDate!.indexOf('T'))}  ${testData.testTime}',style: MyTextTheme().mediumGCN,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              children: [
                                ListTile(
                                  title: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              Expanded(child: Text('Test Name',style: MyTextTheme().mediumBCB,)),
                                              const VerticalDivider(),
                                              Expanded(child: Text('Result',style: MyTextTheme().mediumBCB)),
                                              const VerticalDivider(),
                                              Expanded(child: Text('Normal Range',style: MyTextTheme().mediumBCB)),
                                              const VerticalDivider(),
                                              Expanded(child: Text('Analysis',style: MyTextTheme().mediumBCB)),
                                            ]
                                        ),
                                        const SizedBox(height: 10,),
                                        ...List.generate(testData.subTest!.length, (i) {
                                          SubTest subTestData = testData.subTest![i];
                                          return Column(
                                            children: [
                                              Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(subTestData.subTestName.toString(),
                                                        style: MyTextTheme().smallGCN,),
                                                    ),
                                                    const VerticalDivider(),
                                                    Expanded(
                                                      child: Text('${subTestData.result.toString()} ${subTestData.unitname}',
                                                        style: MyTextTheme().smallGCN,),
                                                    ),
                                                    const VerticalDivider(),
                                                    Expanded(
                                                      child: Text(subTestData.normalRange.toString(),
                                                        style: MyTextTheme().smallGCN,),
                                                    ),
                                                    const VerticalDivider(),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                            onTap:(){
                                                              bool isNumeric(String s) {
                                                                if (s == null) {
                                                                  return false;
                                                                }
                                                                return double.tryParse(s) != null;
                                                              }
                                                              //print(isNumeric(subTestData.result.toString()));
                                                              //print(subTestData.result.toString().replaceAll(new RegExp(r"\D"), ""));
                                                              if(isNumeric(subTestData.result.toString().replaceAll(RegExp(r"\D"), ""))) {
                                                                Get.to(() =>
                                                                    const NewEraChartView(),
                                                                    arguments: {
                                                                      "id": subTestData.id
                                                                          .toString(),
                                                                      "testName": subTestData
                                                                          .subTestName
                                                                          .toString()
                                                                    });
                                                              }
                                                              else{
                                                                alertToast(context, "No graph available");
                                                              }
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                                                              child: Icon(Icons.bar_chart,color: AppColor.primaryColor,),
                                                            )),
                                                        InkWell(
                                                          onTap:(){
                                                            if (kDebugMode) {
                                                              print(subTestData.id);
                                                            }
                                                            controller.modal.getTestInfo(context,subTestData.id.toString());
                                                            showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {

                                                                  return Obx(() => AlertDialog(
                                                                    title:Text(controller.getTestInfo.isEmpty?"Test Details":controller.getTestInfo[0].subTest.toString(),style: MyTextTheme().largeBCB,),
                                                                    actions: [
                                                                      InkWell(onTap: (){
                                                                        Navigator.pop(context);
                                                                      },
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.fromLTRB(10,10,15,5),
                                                                            child: Text("Ok",style: MyTextTheme().smallBCB,),
                                                                          ))
                                                                    ],
                                                                    actionsPadding: const EdgeInsets.only(right: 20,bottom: 10),
                                                                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                    insetPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                                                    scrollable: true,
                                                                    content:CommonWidgets().showNoData(show:controller.showNoData2.value&&controller.getTestInfo.isEmpty,showLoader:!controller.showNoData2.value,loaderTitle:"loading test details",
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children:[
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.remove_red_eye,size: 20,color: AppColor.primaryColor,),
                                                                                const SizedBox(width: 10,),
                                                                                Text("Overview",style: MyTextTheme().mediumBCB,),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 10,),
                                                                            Text(controller.getTestInfo.isEmpty?"":controller.getTestInfo[0].overView.toString(),style: MyTextTheme().smallGCN,),
                                                                            const SizedBox(height: 15,),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.view_headline,size: 20,color: AppColor.primaryColor,),
                                                                                const SizedBox(width: 10,),
                                                                                Text("Results",style: MyTextTheme().mediumBCB,),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 10,),
                                                                            Text(controller.getTestInfo.isEmpty?"":controller.getTestInfo[0].resultInterpretation.toString(),style: MyTextTheme().smallGCN),
                                                                            const SizedBox(height: 15,),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.check_box_outlined,size: 18,color: AppColor.primaryColor,),
                                                                                const SizedBox(width: 10,),
                                                                                Text("Preparation",style: MyTextTheme().mediumBCB,),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 10,),
                                                                            Text(controller.getTestInfo.isEmpty?"Test Details":controller.getTestInfo[0].patientPreperation.toString(),style: MyTextTheme().smallGCN),
                                                                            const SizedBox(height: 15,),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.wysiwyg,size: 18,color: AppColor.primaryColor,),
                                                                                const SizedBox(width: 10,),
                                                                                Text("Test Reason",style: MyTextTheme().mediumBCB,),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 10,),
                                                                            Text(controller.getTestInfo.isEmpty?"":controller.getTestInfo[0].testReason!.isEmpty?"No data available for test reason":controller.getTestInfo[0].testReason![0].testReason.toString(),style: MyTextTheme().smallGCN),
                                                                            const SizedBox(height: 15,),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.noise_control_off,size: 20,color: AppColor.primaryColor,),
                                                                                const SizedBox(width: 10,),
                                                                                Text("Remark",style: MyTextTheme().mediumBCB,),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 10,),
                                                                            Text(controller.getTestInfo.isEmpty?"Test Details":controller.getTestInfo[0].remark.toString(),style: MyTextTheme().smallGCN),
                                                                          ],
                                                                        )),
                                                                  ));
                                                                }
                                                            );

                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                                                            child: Icon(Icons.info,color: AppColor.primaryColor,size: 19),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]
                                              ),
                                              const SizedBox(height: 10,),
                                            ],
                                          );
                                        }
                                        ),
                                      ]
                                  ),
                                )]
                          ),
                        );
                      }, ),
                  ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
