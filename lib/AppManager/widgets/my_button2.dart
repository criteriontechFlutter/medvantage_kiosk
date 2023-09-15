
import 'package:flutter/material.dart';

import '../app_color.dart';
import '../my_text_theme.dart';


class MyButton2 extends StatelessWidget  {
  final String title;
  final double? height;
  final double? elevation;
  final double? width;
  final Function? onPress;
  final Color? color;
  final bool? animate;
  final TextStyle? textStyle;
  final Widget? suffixIcon;

  const MyButton2({Key? key, required this.title, this.onPress,
    this.color,
    this.height,
    this.textStyle,
    this.elevation,
    this.animate,
    this.suffixIcon,
    this.width}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width:  width,
      child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, shadowColor: AppColor.primaryColor,
            elevation: elevation??0,
            backgroundColor: color??AppColor.orangeButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: (){
            onPress!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    suffixIcon?? Container(),
                    Visibility(
                        visible: suffixIcon!=null,
                        child: const SizedBox(width: 2,)),

                    Text(title,
                        textAlign: TextAlign.center,
                        style: textStyle?? MyTextTheme().mediumWCB),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}



