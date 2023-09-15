import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  final Function onPress;
  final Widget child;
  final Color? color;
  final Color? shadowColor;
  final double? elevation;
  final double? borderRadius;
  const CustomInkwell({Key? key, required this.onPress, required this.child, this.color, this.shadowColor, this.elevation, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:(){
      onPress();
    },
        style:ElevatedButton.styleFrom(
          foregroundColor: Colors.grey.withOpacity(.05),
          backgroundColor: color??Colors.white,
          splashFactory:InkRipple.splashFactory,
          shadowColor:shadowColor??Colors.transparent,
          elevation:elevation??0.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius??0.0)
          ),
        ),
        child: child
    );
  }
}