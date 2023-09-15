
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_color.dart';
import '../my_text_theme.dart';




// ignore: must_be_immutable
class MyTextField2 extends StatefulWidget {

  final String? hintText;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final bool? isPasswordField;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final ValueChanged? onChanged;
  final Color? borderColor;
  List<TextInputFormatter>? inputFormatters;
  final BorderRadius? borderRadius;

   MyTextField2({Key? key, this.hintText, this.controller,
    this.isPasswordField,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.enabled,
    this.textAlign,
    this.keyboardType,
    this.decoration,
    this.onChanged,
    this.inputFormatters,
    this.borderColor,
    this.borderRadius,
    this.maxLine,
    this.minLine,
   }) : super(key: key);

  @override
  _MyTextField2State createState() => _MyTextField2State();
}

class _MyTextField2State extends State<MyTextField2> {

  bool obscure=false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isPasswordField??false){
      obscure=widget.isPasswordField!;
      setState(() {

      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      inputFormatters: widget.inputFormatters,
        enabled: widget.enabled??true,
        cursorColor: AppColor.black,
        controller: widget.controller,
        minLines: widget.minLine,
        maxLines: widget.maxLine,
        obscureText: widget.isPasswordField==null? false:obscure,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign?? TextAlign.start,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged==null? null:(val){
          widget.onChanged!(val);

        },
        style:  MyTextTheme().mediumBCN,
        decoration: widget.decoration??InputDecoration(
          filled: true,
          isDense: true,
          fillColor: Colors.white,
          counterText: '',
          //contentPadding: widget.isPasswordField==null? EdgeInsets.all(5):widget.isPasswordField? EdgeInsets.fromLTRB(5,5,5,5):EdgeInsets.all(5),
          contentPadding: const EdgeInsets.all(15),
          hintText: widget.hintText,
          hintStyle: MyTextTheme().mediumPCN.copyWith(
              color: AppColor.greyDark
          ),
          errorStyle: MyTextTheme().mediumBCB.copyWith(
              color: AppColor.red
          ),
          prefixIcon: widget.prefixIcon,

          suffixIcon:  (widget.isPasswordField==null || widget.isPasswordField==false)? widget.suffixIcon:IconButton(
            splashRadius: 5,
            icon: obscure? Icon(Icons.visibility,
              color: AppColor.black,
           )
                : Icon(Icons.visibility_off,
              color:  AppColor.black,),
            onPressed: (){
              setState(() {
                obscure=!obscure;
              });

            },),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.white,
          //     width: 2
          //   )
          // ),
          // disabledBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         color: Colors.white,
          //         width: 2
          //     )
          // ),
          // enabledBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         color: Colors.white,
          //         width: 2
          //     )
          // ),
          // border: UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         color: Colors.white,
          //         width: 2
          //     )
          // ),
          // errorBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         color: Colors.white,
          //         width: 2
          //     )
          // ),
          // focusedErrorBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         color: Colors.white,
          //         width: 2
          //     )
          // ),

          focusedBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius?? const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
                color: widget.borderColor?? AppColor.greyLight,
                width: 2
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius?? const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
                color: widget.borderColor?? AppColor.greyLight,
                width: 2
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius?? const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
                color: widget.borderColor?? AppColor.greyLight,
                width: 2
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius?? const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
                color: widget.borderColor?? AppColor.greyLight,
                width: 2
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius?? const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
                color: widget.borderColor?? AppColor.greyLight,
                width: 2
            ),
          ),
        ),
        validator: widget.validator
    );
  }
}


