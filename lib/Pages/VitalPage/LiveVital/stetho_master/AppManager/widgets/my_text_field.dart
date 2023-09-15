
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_color.dart';
import '../my_text_theme.dart';




class MyTextField extends StatefulWidget {

  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final int? maxLength;
  final bool? isPasswordField;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final ValueChanged? onChanged;
  final Color? borderColor;
  final String? labelText;

  const MyTextField({Key? key, this.hintText, this.controller,
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
    this.borderColor,
    this.maxLine,
    this.labelText}) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  bool obscure=false;
  late OutlineInputBorder  border;




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
    border=OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
          color: widget.borderColor??AppColor.greyLight,
          width: 1
      ),
    );
    return TextFormField(
        cursorColor: AppColor.black,
        enabled: widget.enabled??true,
        controller: widget.controller,
        minLines: widget.maxLine,
        maxLines: widget.maxLine==null? 1:100,
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
          fillColor: (widget.enabled??true)? Colors.white:Colors.grey.shade200,
          counterText: '',
          //contentPadding: widget.isPasswordField==null? EdgeInsets.all(5):widget.isPasswordField? EdgeInsets.fromLTRB(5,5,5,5):EdgeInsets.all(5),
          contentPadding: const EdgeInsets.all(12),
          hintText: widget.hintText,
          hintStyle: MyTextTheme().mediumPCN.copyWith(
              color: AppColor.greyDark
          ),
          labelText: widget.labelText,
          labelStyle: MyTextTheme().smallPCB,
          errorStyle: MyTextTheme().mediumBCN.copyWith(
              color: AppColor.red
          ),
          prefixIconConstraints:const BoxConstraints(minWidth: 30, maxHeight: 30),
          prefixIcon: widget.prefixIcon,
          suffixIconConstraints:const BoxConstraints(minWidth: 30, maxHeight: 30),

          suffixIcon:  (widget.isPasswordField==null || widget.isPasswordField==false)? widget.suffixIcon:IconButton(
            splashRadius: 5,
            icon: obscure? Center(
              child: Icon(Icons.visibility,
                color: AppColor.greyDark,
              size: 20,),
            )
                : Center(
                  child: Icon(Icons.visibility_off,
                    size: 20,
              color:  AppColor.greyLight,),
                ),
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

          focusedBorder:  border,
          enabledBorder:  border,
          disabledBorder: border,
          errorBorder:   border,
          focusedErrorBorder:  border,
        ),
        validator: widget.validator
    );
  }
}


