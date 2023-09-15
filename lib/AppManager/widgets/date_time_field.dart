
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../app_color.dart';
import '../my_text_theme.dart';






class MyDateTimeField extends StatelessWidget {
  final String? hintText;
  final DateTimePickerType? dateTimePickerType;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final int? maxLength;
  final bool? enabled;
  final bool? useAsTimeField;
  final bool? useFutureDate;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final ValueChanged? onChanged;
  final String? initialValue;
  final Color? borderColor;
  final Widget? label;
  final BorderRadius? borderRadius;
  final Function? onTap;

  const MyDateTimeField({Key? key, this.hintText, this.controller,
    this.validator,
    this.dateTimePickerType,
    this.prefixIcon,
    this.useAsTimeField,
    this.suffixIcon,
    this.maxLength,
    this.enabled,
    this.textAlign,
    this.keyboardType,
    this.decoration,
    this.onChanged,
    this.initialValue,
    this.useFutureDate,
    this.borderColor,
    this.label,
    this.borderRadius,
    this.onTap,
    this.maxLine}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: AppColor.primaryColor,
          ),
        ),
        child: DateTimePicker(
          enabled: enabled??true,
          //  locale: Locale('en_US', 'en'),
          controller: controller,
          minLines: maxLine,
          maxLines: maxLine==null? 1:100,
          maxLength: maxLength,
          textAlign: textAlign?? TextAlign.start,
          onChanged:  onChanged==null? null:(val){
            onChanged!(val);
          },
          type: dateTimePickerType?? DateTimePickerType.date,
          dateMask: (dateTimePickerType==DateTimePickerType.dateTime)?'yyyy/MM/dd    hh:mm a':
          (dateTimePickerType==DateTimePickerType.time)?
              'hh:mm a'
              :
          'yyyy/MM/dd',
          initialValue: initialValue,
          firstDate: (useFutureDate?? false)? DateTime.now():DateTime(1800),
          lastDate: (useFutureDate?? false)? DateTime.now().add(const Duration(days: 30)):DateTime.now(),
          icon: const Icon(Icons.event),

          selectableDayPredicate: (date) {
            // Disable weekend days to select from the calendar
            return true;
          },
          // onSaved: (val) => print(val),
          style:  MyTextTheme().mediumBCN,
          decoration: decoration??InputDecoration(
            label: label,
            filled: true,
            isDense: true,
            fillColor: enabled==false?  AppColor.greyLight:Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            counterText: '',
            //contentPadding: isPasswordField==null? EdgeInsets.all(5):isPasswordField? EdgeInsets.fromLTRB(5,5,5,5):EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: MyTextTheme().mediumBCN.copyWith(
                color: Colors.grey
            ),
            errorStyle: MyTextTheme().mediumBCB.copyWith(
                color: AppColor.red
            ),
            prefixIcon: prefixIcon??null,
            // suffixIcon:   !(dateTimePickerType==DateTimePickerType.dateTime)? Container(
            //     height: 40,
            //     decoration: BoxDecoration(
            //         color: AppColor.primaryColor,
            //         borderRadius: const BorderRadius.only(
            //           topRight: Radius.circular(5),
            //           bottomRight: Radius.circular(5),
            //         )
            //
            //     ),
            //     child:  Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: (
            //
            //           Icon(dateTimePickerType==DateTimePickerType.time?
            //           Icons.access_time_outlined:
            //           Icons.date_range_sharp,
            //             color: Colors.white,)
            //       ),
            //     )):Container(
            //     height: 40,
            //     decoration: BoxDecoration(
            //         color: AppColor.primaryColor,
            //         borderRadius: const BorderRadius.only(
            //           topRight: Radius.circular(5),
            //           bottomRight: Radius.circular(5),
            //         )
            //
            //     ),
            //     child: const Padding(
            //       padding: EdgeInsets.all(10.0),
            //       child: Image(image: AssetImage('assets/calender.png'),),
            //     )),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 10,
              minWidth: 10,
            ),
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
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: borderColor?? AppColor.greyLight,
                  width: 2
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: borderColor?? AppColor.greyDark,

              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: borderColor?? AppColor.greyLight,

              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: borderColor?? AppColor.greyLight,

              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: borderColor?? AppColor.greyLight,
              ),
            ),
          ),
          validator: validator,
        )
    );
  }
}

