

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/productdetailsModal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../AppManager/app_color.dart';
import '../../AppManager/my_text_theme.dart';


class SimilarProducts extends StatefulWidget {
  const SimilarProducts({Key? key}) : super(key: key);

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {

  ProductDetailsModal modal = ProductDetailsModal();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          itemCount: modal.controller.similarProducts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    // padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.greyLight),
                        color: AppColor.white,
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          10, 8, 10, 8),
                      child: Column(children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child:
                          CachedNetworkImage(

                              imageUrl:modal.controller.getSimilarProducts[index].imageURL.toString(),
                              placeholder: (context, url) =>
                                  Container(
                                    color: AppColor.white,
                                  ),
                              errorWidget: (context, url,
                                  error) =>
                                  Icon(
                                    Icons.photo,
                                    color:
                                    AppColor.greyLight,
                                    size: 50,
                                  )),

                        ),
                        Expanded(
                          child: Text(
                            modal.controller.getSimilarProducts[index].productName.toString(),
                            textAlign: TextAlign.start,
                            style: MyTextTheme().mediumBCB,
                          ),
                        ),
                        const SizedBox(height: 10,),

                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/rupee-indian.svg',
                              color: AppColor.lightGreen,
                              height: 12,
                              width: 12,
                            ),
                            const SizedBox(width: 7,),
                            Text(
                              modal.controller.getSimilarProducts[index].offeredPrice.toString(),
                              textAlign: TextAlign.start,
                              style: MyTextTheme().mediumBCB,
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),

                ],
              ),
            );
          }),
    );
  }
}
