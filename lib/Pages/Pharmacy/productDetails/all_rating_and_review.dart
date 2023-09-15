import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/productdetailsModal.dart';
import 'package:flutter/material.dart';

import '../../../AppManager/app_color.dart';

class AllRatingAndReviews extends StatefulWidget {
  AllRatingAndReviews({Key? key}) : super(key: key);

  @override
  State<AllRatingAndReviews> createState() => _AllRatingAndReviewsState();
}

class _AllRatingAndReviewsState extends State<AllRatingAndReviews> {
  ProductDetailsModal modal = ProductDetailsModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidget()
          .pharmacyAppBar(context, title: 'All Ratings and Review Fragmented'),
      backgroundColor: AppColor.lightBackground,
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: modal.controller.getReview.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          modal.controller.getReview[index].reviewBy
                              .toString()
                              .toUpperCase(),
                          style: MyTextTheme().mediumBCB,
                        ),
                        Text(
                          modal.controller.getReview[index].reviewDate
                              .toString(),
                          style: MyTextTheme().smallGCN,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            child: Row(
                              children: [
                                Text(
                                  modal.controller.getReview[index].starRating
                                      .toString(),
                                  style: MyTextTheme().smallWCN,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: AppColor.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      modal.controller.getReview[index].review.toString(),
                      textAlign: TextAlign.start,
                      style: MyTextTheme().mediumBCN,
                    ),
                    Divider(
                      color: AppColor.black,
                      thickness: 0.5,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
