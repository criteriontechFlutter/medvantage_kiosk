import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/widgets/my_button2.dart';
import 'package:flutter/material.dart';
import '../AppManager/my_text_theme.dart';
import 'app_color.dart';



class FunctionalSheet extends StatelessWidget {

  final String message;
  final String buttonName;
  final Function onPressButton;
  final bool showCancelButton;
  final TextAlign? textAlign;
  final Widget? child;
  final  Color? confirmButtonColor;

  const FunctionalSheet({Key? key,
    required this.message,
    required this.buttonName,
    required this.onPressButton,
    this.showCancelButton=true,
    this.textAlign,
    this.child, this.confirmButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12,right: 12),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20,40,20,20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child??Container(),
                child==null? Container():const SizedBox(height: 20,),
                Text(message.toString(),
                  textAlign: textAlign??TextAlign.center,
                  style: MyTextTheme().mediumBCB.copyWith(fontSize: 18),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,20,20,20),
            child: Row(
              children: [
                showCancelButton? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,20,0),
                    child: MyButton2(
                        elevation: 0.0,
                        color: Colors.black26,
                        onPress: (){
                          Navigator.pop(context);
                        }, title: "Cancel"),
                  ),
                ):Container(),
                Expanded(
                  child: MyButton2(
                      color:confirmButtonColor?? AppColor.green,
                      onPress: (){
                        Navigator.pop(context);
                        onPressButton();
                      }, title: buttonName),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}