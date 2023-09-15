
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';
import 'my_text_theme.dart';






class NewTextField extends StatefulWidget {

  final String? hintText;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
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
  List<TextInputFormatter>? inputFormatters;

   NewTextField({Key? key, this.hintText, this.controller,
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
    this.maxLine}) : super(key: key);

  @override
  _NewTextFieldState createState() => _NewTextFieldState();
}

class _NewTextFieldState extends State<NewTextField> {

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





  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
        enabled: widget.enabled??true,
        controller: widget.controller,
        minLines: widget.maxLine,
        maxLines: widget.maxLine==null? 1:100,
        obscureText: widget.isPasswordField==null? false:obscure,
        maxLength: widget.maxLength??null,
        textAlign: widget.textAlign?? TextAlign.center,
        keyboardType: widget.keyboardType?? null,
        onChanged: widget.onChanged==null? null:(val){
          widget.onChanged!(val);
        },
        style:  MyTextTheme().mediumPCN,
        decoration: widget.decoration??InputDecoration(constraints: const BoxConstraints(minHeight: 30),
          filled: true,
          isDense: true,
          fillColor: Colors.grey,
          counterText: '',
          contentPadding: const EdgeInsets.all(10),
          hintText: widget.hintText??null,
          hintStyle: MyTextTheme().mediumBCN.copyWith(
            color: Colors.grey,
          ),
          errorStyle: MyTextTheme().smallPCB.copyWith(
            color: Colors.red,
          ),
          prefixIcon: Center(child: widget.prefixIcon??null),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 40,
            maxWidth: 40
          ),
          suffixIconConstraints: const BoxConstraints(
              maxHeight: 40,
              maxWidth: 40
          ),
          suffixIcon:  Center(
            child: (widget.isPasswordField==null || widget.isPasswordField==false)? widget.suffixIcon??null:IconButton(
              splashRadius: 2,
              icon: obscure? Icon(
                Icons.visibility_off,
                color: Colors.blue,)
                  : Icon(Icons.visibility,
                color:  Colors.lightBlue,),
              onPressed: (){
                setState(() {
                  obscure=!obscure;
                });
              },),
          ),
          border: OutlineInputBorder(
            borderSide:  BorderSide(color:Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey,width: 0.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: widget.validator??null
    );
  }
}


