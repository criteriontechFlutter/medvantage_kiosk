import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CervicalQuestionaireWidgets/cervical_start_time_widget.dart';
import 'CervicalQuestionaireWidgets/driving_question_widget.dart';
import 'CervicalQuestionaireWidgets/pain_intensity_widget.dart';
import 'cervical_questionaire_controller.dart';

class CervicalQuestionnaireView extends StatelessWidget {
  const CervicalQuestionnaireView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CervicalQuestionnaireController controller = Get.put(
        CervicalQuestionnaireController());
    PageController pageController = PageController();
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.bgColor,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(left: 30,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn);
                      print(controller.getCurrentPage);
                      //pageController.animateToPage(controller.getCurrentPage+1, duration: Duration(seconds: 1), curve: Curves.bounceIn);

                      // else {
                      //   pageController.jumpToPage(0);
                      // }
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade300),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(Icons.arrow_back_ios, size: 15,
                              color: Colors.white,),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Text("Previous", style: MyTextTheme().largeBCN.copyWith(
                          color: Colors.black54,),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //if (controller.getCurrentPage!=controller.totalPage-1) {
                      pageController.animateToPage(
                          controller.getCurrentPage + 1,
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeIn);
                      //}
                      // else {
                      //   pageController.jumpToPage(0);
                      // }
                    },
                    child: Row(
                      children: [
                        Text("Next", style: MyTextTheme().largeBCN.copyWith(
                            color: Colors.black54),),
                        const SizedBox(width: 8,),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.buttonColor),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(Icons.arrow_forward_ios, size: 15,
                              color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColor.primaryColor,
              title: GetBuilder<CervicalQuestionnaireController>(builder: (_) {
                return Text(
                  "${controller.getCurrentPage + 1} of ${controller.totalPage}",
                  style: MyTextTheme().veryLargeWCB,);
              }),
              elevation: 0,
              leading: const Icon(Icons.arrow_back_ios),
            ),
            body: GetBuilder<CervicalQuestionnaireController>(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                      color: AppColor.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LinearProgressIndicator(
                              backgroundColor: Colors.white,
                              color: AppColor.buttonColor,
                              value: controller.getCurrentPage /
                                  (controller.totalPage - 1),
                            ),
                            const SizedBox(height: 20,),
                            Text(controller.questions[controller.getCurrentPage],
                              style: MyTextTheme().largeWCN.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 25),)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (val) {
                          controller.updateCurrentPage = val;
                          print(controller.getCurrentPage);
                        },
                        scrollDirection: Axis.horizontal,
                        children:  [
                          const CervicalStartTimeWidget(),
                          PainIntensityWidget(lowerValue: controller.lowerValue, upperValue: controller.upperValue,
                            painIntensity: controller.painIntensity,updatePainIntensity: controller.updatePainIntensity,
                            intensityPicture:controller.intensityPicture,
                            intensityPictureHeight: controller.intensityPictureHeight, labelPain:controller.painLabel, activeColor: controller.activeColor,),
                           DrivingQuestionWidget(question:controller.drivingQuestions, isChecked: controller.updateIsChecked,),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          )

      ),
    );
  }
}
