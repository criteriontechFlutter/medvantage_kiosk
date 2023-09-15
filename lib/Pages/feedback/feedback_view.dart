import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/my_text_theme.dart';
import '../../AppManager/widgets/common_widgets.dart';
import '../../AppManager/widgets/my_button2.dart';
import '../../AppManager/widgets/my_text_field_2.dart';
import 'DataModal/feedback_data_model.dart';
import 'feedback_controller.dart';
import 'feedback_modal.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  Color pageColor = AppColor.primaryColor;
  FeedbackModal feedbackModal = FeedbackModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    await feedbackModal.getFeedbackList(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<FeedbackController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pageColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(context, title: "Feedback"),
          body: Form(
            key: feedbackModal.controller.formKey.value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GetBuilder(
                    init: FeedbackController(),
                    builder: (_) {
                      return CommonWidgets().showNoData(
                          title: 'Feedback Form Data Not Found',
                          show: (feedbackModal.controller.getShowNoData &&
                              (feedbackModal.controller.getNursingList.isEmpty &&
                                  feedbackModal.controller.getQuestionList.isEmpty &&
                                  feedbackModal
                                      .controller.getTechnicianList.isEmpty &&
                                  feedbackModal.controller.getWardBoyList.isEmpty)),
                          loaderTitle: 'Fetching Feedback Form',
                          showLoader: (!feedbackModal.controller.getShowNoData &&
                              (feedbackModal.controller.getNursingList.isEmpty &&
                                  feedbackModal.controller.getQuestionList.isEmpty &&
                                  feedbackModal
                                      .controller.getTechnicianList.isEmpty &&
                                  feedbackModal.controller.getWardBoyList.isEmpty)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //*****
                                        Visibility(
                                          visible: feedbackModal
                                              .controller.getNursingList.isNotEmpty,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    12, 8, 0, 8),
                                                child: Text(
                                                  feedbackModal.controller
                                                          .getNursingList.isEmpty
                                                      ? " "
                                                      : "Nursing Staff",
                                                  style: MyTextTheme().mediumPCB,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: feedbackModal.controller
                                                      .getNursingList.length,
                                                  itemBuilder: (context, index) {
                                                    NursingList nurse = feedbackModal
                                                        .controller
                                                        .getNursingList[index];
                                                    return Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                            color: AppColor.fdColor),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  5.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 20,
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: nurse
                                                                        .imagePath
                                                                        .toString()
                                                                        .replaceAll(
                                                                            '\\',
                                                                            '/'),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                      Icons.person,
                                                                      size: 30,
                                                                    ),
                                                                  ),
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
                                                                      nurse.nurseName
                                                                          .toString(),
                                                                      style: MyTextTheme()
                                                                          .mediumPCB,
                                                                    ),
                                                                    RatingBar(
                                                                      unratedColor:
                                                                          Colors
                                                                              .yellow,
                                                                      glowColor: AppColor
                                                                          .orangeButtonColor,
                                                                      itemSize: 20,
                                                                      initialRating:
                                                                          0,
                                                                      direction: Axis
                                                                          .horizontal,
                                                                      allowHalfRating:
                                                                          false,
                                                                      itemCount: 5,
                                                                      ratingWidget:
                                                                          RatingWidget(
                                                                        full: Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        half: Icon(
                                                                            Icons
                                                                                .star_half,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        empty: Icon(
                                                                            Icons
                                                                                .star_border,
                                                                            color: AppColor
                                                                                .primaryColorLight),
                                                                      ),
                                                                      itemPadding:
                                                                          const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  2.0),
                                                                      onRatingUpdate:
                                                                          (rating) {
                                                                        feedbackModal
                                                                            .controller
                                                                            .updateNurseRating(
                                                                          index,
                                                                          rating
                                                                              .toDouble(),
                                                                          //nurse.controller!.clear()
                                                                        );
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),

                                                                    SizedBox(
                                                                        width: 180,
                                                                        child: Visibility(
                                                                            visible: (nurse.rating ?? 0.0) > 0.0,
                                                                            child:
                                                                                // saveQuestionRating(questions)
                                                                                MyTextField2(
                                                                              validator:
                                                                                  (value) {
                                                                                if (value!
                                                                                    .isEmpty) {
                                                                                  return "Please write review";
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              },
                                                                              controller:
                                                                                  nurse.controller,

                                                                              hintText: nurse.rating! <
                                                                                      3
                                                                                  ? 'What did you not like?'
                                                                                  : "What did you like?",
                                                                            ))
                                                                        ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Visibility(
                                          visible: feedbackModal
                                              .controller.getNursingList.isNotEmpty,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    12, 8, 0, 8),
                                                child: Text(
                                                  "Nursing Staff",
                                                  style: MyTextTheme().mediumPCB,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: feedbackModal.controller
                                                      .getNursingList.length,
                                                  itemBuilder: (context, index) {
                                                    NursingList nurse = feedbackModal
                                                        .controller
                                                        .getNursingList[index];
                                                    return Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                            color: AppColor.fdColor),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  5.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 20,
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: nurse
                                                                        .imagePath
                                                                        .toString()
                                                                        .replaceAll(
                                                                            '\\',
                                                                            '/'),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                      Icons.person,
                                                                      size: 30,
                                                                    ),
                                                                  ),
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
                                                                      nurse.nurseName
                                                                          .toString(),
                                                                      style: MyTextTheme()
                                                                          .mediumPCB,
                                                                    ),
                                                                    RatingBar(
                                                                      unratedColor:
                                                                          Colors
                                                                              .yellow,
                                                                      glowColor: AppColor
                                                                          .orangeButtonColor,
                                                                      itemSize: 20,
                                                                      initialRating:
                                                                          0,
                                                                      direction: Axis
                                                                          .horizontal,
                                                                      allowHalfRating:
                                                                          false,
                                                                      itemCount: 5,
                                                                      ratingWidget:
                                                                          RatingWidget(
                                                                        full: Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        half: Icon(
                                                                            Icons
                                                                                .star_half,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        empty: Icon(
                                                                            Icons
                                                                                .star_border,
                                                                            color: AppColor
                                                                                .primaryColorLight),
                                                                      ),
                                                                      itemPadding:
                                                                          const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  2.0),
                                                                      onRatingUpdate:
                                                                          (rating) {
                                                                        feedbackModal
                                                                            .controller
                                                                            .updateNurseRating(
                                                                          index,
                                                                          rating
                                                                              .toDouble(),
                                                                          //nurse.controller!.clear()
                                                                        );
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    SizedBox(
                                                                        width: 180,
                                                                        child: Visibility(
                                                                            visible: (nurse.rating ?? 0.0) > 0.0,
                                                                            child:
                                                                                // saveQuestionRating(questions)
                                                                                MyTextField2(
                                                                              validator:
                                                                                  (value) {
                                                                                if (value!
                                                                                    .isEmpty) {
                                                                                  return "Please write review";
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              },
                                                                              controller:
                                                                                  nurse.controller,
                                                                              hintText: nurse.rating! <
                                                                                      3
                                                                                  ? 'What did you not like?'
                                                                                  : "What did you like?",
                                                                            ))
                                                                        ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Visibility(
                                          visible: feedbackModal
                                              .controller.getWardBoyList.isNotEmpty,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    12, 8, 0, 8),
                                                child: Text(
                                                  "Aya/Ward Boy Care",
                                                  style: MyTextTheme().mediumPCB,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: feedbackModal.controller
                                                      .getWardBoyList.length,
                                                  itemBuilder: (context, index) {
                                                    Table4 wardBoy = feedbackModal
                                                        .controller
                                                        .getWardBoyList[index];
                                                    return Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                            color: AppColor.fdColor),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  5.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 20,
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: wardBoy
                                                                        .imagePath
                                                                        .toString()
                                                                        .replaceAll(
                                                                            '\\',
                                                                            '/'),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                      Icons.person,
                                                                      size: 30,
                                                                    ),
                                                                  ),
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
                                                                      wardBoy
                                                                          .ayaWardBoy
                                                                          .toString(),
                                                                      style: MyTextTheme()
                                                                          .mediumPCB,
                                                                    ),
                                                                    RatingBar(
                                                                      unratedColor:
                                                                          Colors
                                                                              .yellow,
                                                                      glowColor: AppColor
                                                                          .orangeButtonColor,
                                                                      itemSize: 20,
                                                                      initialRating:
                                                                          0,
                                                                      direction: Axis
                                                                          .horizontal,
                                                                      allowHalfRating:
                                                                          false,
                                                                      itemCount: 5,
                                                                      ratingWidget:
                                                                          RatingWidget(
                                                                        full: Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        half: Icon(
                                                                            Icons
                                                                                .star_half,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        empty: Icon(
                                                                            Icons
                                                                                .star_border,
                                                                            color: AppColor
                                                                                .primaryColorLight),
                                                                      ),
                                                                      itemPadding:
                                                                          const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  2.0),
                                                                      onRatingUpdate:
                                                                          (rating) {
                                                                        feedbackModal
                                                                            .controller
                                                                            .updateWardBoyRating(
                                                                          index,
                                                                          rating
                                                                              .toDouble(),
                                                                        );
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    SizedBox(
                                                                        width: 180,
                                                                        child:
                                                                            Visibility(
                                                                                visible: (wardBoy.rating ?? 0.0) >
                                                                                    0.0,
                                                                                child:
                                                                                    MyTextField2(
                                                                                  validator:
                                                                                      (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return "Please write review";
                                                                                    } else {
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                  controller:
                                                                                      wardBoy.controller,
                                                                                  hintText: wardBoy.rating! < 3
                                                                                      ? 'What did you not like?'
                                                                                      : "What did you like?",
                                                                                ))
                                                                        ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Visibility(
                                          visible: feedbackModal
                                              .controller.getNursingList.isNotEmpty,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    12, 8, 0, 8),
                                                child: Text(
                                                  "Technician Services",
                                                  style: MyTextTheme().mediumPCB,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: feedbackModal.controller
                                                      .getTechnicianList.length,
                                                  itemBuilder: (context, index) {
                                                    Table5 technician = feedbackModal
                                                        .controller
                                                        .getTechnicianList[index];
                                                    return Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                            color: AppColor.fdColor),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  5.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 20,
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: technician
                                                                        .imagePath
                                                                        .toString()
                                                                        .replaceAll(
                                                                            '\\',
                                                                            '/'),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                      Icons.person,
                                                                      size: 30,
                                                                    ),
                                                                  ),
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
                                                                      technician
                                                                          .technician
                                                                          .toString(),
                                                                      style: MyTextTheme()
                                                                          .mediumPCB,
                                                                    ),
                                                                    RatingBar(
                                                                      unratedColor:
                                                                          Colors
                                                                              .yellow,
                                                                      glowColor: AppColor
                                                                          .orangeButtonColor,
                                                                      itemSize: 20,
                                                                      initialRating:
                                                                          0,
                                                                      direction: Axis
                                                                          .horizontal,
                                                                      allowHalfRating:
                                                                          false,
                                                                      itemCount: 5,
                                                                      ratingWidget:
                                                                          RatingWidget(
                                                                        full: Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        half: Icon(
                                                                            Icons
                                                                                .star_half,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        empty: Icon(
                                                                            Icons
                                                                                .star_border,
                                                                            color: AppColor
                                                                                .primaryColorLight),
                                                                      ),
                                                                      itemPadding:
                                                                          const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  2.0),
                                                                      onRatingUpdate:
                                                                          (rating) {
                                                                        feedbackModal
                                                                            .controller
                                                                            .updateTechnicianRating(
                                                                          index,
                                                                          rating
                                                                              .toDouble(),
                                                                        );
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    SizedBox(
                                                                        width: 180,
                                                                        child:
                                                                            Visibility(
                                                                                visible: (technician.rating ?? 0.0) >
                                                                                    0.0,
                                                                                child:
                                                                                    MyTextField2(
                                                                                  validator:
                                                                                      (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return "Please write review";
                                                                                    } else {
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                  controller:
                                                                                      technician.controller,
                                                                                  hintText: technician.rating! < 3
                                                                                      ? 'What did you not like?'
                                                                                      : "What did you like?",
                                                                                ))
                                                                        // TextField(decoration: InputDecoration(contentPadding:
                                                                        // EdgeInsets.zero),)
                                                                        ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: feedbackModal
                                                  .controller.getQuestionList.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                QuestionList questions = feedbackModal
                                                    .controller
                                                    .getQuestionList[index];
                                                return Visibility(
                                                  visible:
                                                      questions.isExpendable == false,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(5),
                                                        border: Border.all(
                                                            color:
                                                                AppColor.greyLight)),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  questions.question
                                                                      .toString(),
                                                                  style: MyTextTheme()
                                                                      .mediumPCB,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    RatingBar(
                                                                      unratedColor:
                                                                          Colors
                                                                              .yellow,
                                                                      glowColor: AppColor
                                                                          .orangeButtonColor,
                                                                      itemSize: 20,
                                                                      initialRating:
                                                                          0,
                                                                      direction: Axis
                                                                          .horizontal,
                                                                      allowHalfRating:
                                                                          false,
                                                                      itemCount: 5,
                                                                      ratingWidget:
                                                                          RatingWidget(
                                                                        full: Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        half: Icon(
                                                                            Icons
                                                                                .star_half,
                                                                            color: AppColor
                                                                                .orangeButtonColor),
                                                                        empty: Icon(
                                                                            Icons
                                                                                .star_border,
                                                                            color:
                                                                                pageColor),
                                                                      ),
                                                                      itemPadding:
                                                                          const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  2.0),
                                                                      onRatingUpdate:
                                                                          (rating) {
                                                                        print(rating);
                                                                        questions
                                                                            .controller!
                                                                            .clear();
                                                                        //if()
                                                                        //
                                                                        feedbackModal
                                                                            .controller
                                                                            .updateQuestionRatingData(
                                                                                index,
                                                                                rating
                                                                                    .toDouble());
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SizedBox(
                                                                    width: 180,
                                                                    child: Visibility(
                                                                        visible: (questions
                                                                                    .rating ??
                                                                                0.0) >
                                                                            0.0,
                                                                        child:
                                                                            // saveQuestionRating(questions)
                                                                            MyTextField2(
                                                                          validator:
                                                                              (value) {
                                                                            if (value!
                                                                                .isEmpty) {
                                                                              return "Please write review";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                          controller:
                                                                              questions
                                                                                  .controller,

                                                                          hintText: questions.rating! <
                                                                                  3
                                                                              ? 'What did you not like?'
                                                                              : "What did you like?",
                                                                        ))

                                                                    ),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context, int index) {
                                                return const SizedBox(
                                                  height: 10,
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyButton2(
                                      title: "Submit",
                                      color: pageColor,
                                      onPress: () async {


                                        if (feedbackModal
                                            .controller.formKey.value.currentState!
                                            .validate()) {
                                          //
                                          await feedbackModal.onPressSubmit(context);
                                        }
//
                                        //
                                        else {
                                          alertToast(
                                              context, 'Please fill data properly');
                                        }
//
                                      }),
                                )
                              ]));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//******
