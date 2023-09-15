import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/MyAppointment/AppointmentDetails/appointment_details_controller.dart';
import 'package:digi_doctor/Pages/MyAppointment/AppointmentDetails/appointment_details_modal.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/widgets/my_text_field_2.dart';
import '../../../../Localization/app_localization.dart';

addReview(context) async {
  ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
  AppointmentDetailsModal modal = AppointmentDetailsModal();
  await modal.controller.clearData();
  AlertDialogue().show(context,
      title: localization.getLocaleData.rateYourExperience.toString(),
      showCancelButton: true,
      newWidget: [
        GetBuilder(
            init: AppointmentDetailsController(),
            builder: (_) {
              return Column(
                children: [
                  MyTextField2(
                    controller: modal.controller.reviewC.value,
                    label: Text(localization.getLocaleData.review.toString()),
                    hintText: localization.getLocaleData.writeAReview.toString(),
                    maxLine: 5,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return localization.getLocaleData.pleaseWriteReview.toString();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      if (kDebugMode) {
                        print(rating);
                      }
                      modal.controller.ratingData.value = rating.toInt();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton2(
                    title: localization.getLocaleData.submit.toString(),
                    width: 200,
                    onPress: () async {
                     await modal.onPressedSubmit(context);
                    },
                  )
                ],
              );
            })
      ]);
}
