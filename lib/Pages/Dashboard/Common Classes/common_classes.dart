import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';

class Features {
  late final String text; // grid 4 parts
  late final String text2;
  late final Color colorOfCard;
  late final String imgUrl;
  late final Function onTap;

  Features({
    required this.text,
    required this.text2,
    required this.colorOfCard,
    required this.imgUrl,
    required this.onTap,
  });
}

class Slide {
  late String imageUrl;
  late String imageText;

  Slide({required this.imageUrl, required this.imageText});
}

class NumbersList1 {
  final String text;

  NumbersList1({
    required this.text,
  });
}

class NumbersList {
  final String text;
  final String smallText;

  NumbersList({
    required this.text,
    required this.smallText,
  });
}

class SelectFeatures extends StatelessWidget {
  const SelectFeatures({Key? key, required this.features}) : super(key: key);
  final Features features;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              features.imgUrl,
                            ),
                            alignment: const Alignment(1, 0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 2, //spread radius
                            blurRadius: 5, // blur radius
                            offset: const Offset(
                              0,
                              0,
                            ), // changes position of shadow
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.white),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.white.withOpacity(0.8),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: -28,
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: features.colorOfCard,
                      ),
                      child: Image.asset(features.imgUrl),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 50,
                    child: Text(
                      features.text,
                      style: MyTextTheme().mediumBCN,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 70,
                    child: Text(
                      features.text2.toString(),
                      style: MyTextTheme().mediumBCB,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}




