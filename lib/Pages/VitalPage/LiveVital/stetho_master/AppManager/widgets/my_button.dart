
import 'package:flutter/material.dart';

import '../app_color.dart';
import '../my_text_theme.dart';


class MyButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? elevation;
  final double? width;
  final Function? onPress;
  final Color? color;
  final bool? animate;
  final TextStyle? textStyle;
  final Widget? suffixIcon;

  const MyButton({Key? key, required this.title, this.onPress,
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
      height: height?? 40,
      child: TextButton(
          style: TextButton.styleFrom(
            shadowColor: AppColor.primaryColor,
            padding: const EdgeInsets.all(6),
            elevation: elevation??0,
            primary: Colors.black,
            backgroundColor: color??AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: (){
           onPress!();
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
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
            ),
          )
      ),
    );
  }
}



