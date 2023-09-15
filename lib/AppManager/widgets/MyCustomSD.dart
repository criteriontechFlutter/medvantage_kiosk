
import 'package:custom_searchable_dropdown/Custom_Searchable_Dropdown.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_color.dart';
import '../my_text_theme.dart';




class MyCustomSD extends StatefulWidget {

  final InputDecoration? decoration;
  final ValueChanged onChanged;
  final List listToSearch;
  final String? label;
  final String valFrom;
  final IconData? prefixIcon;
  final List? initialValue;
  final bool? hideSearch;
  final double? height;
  final Color? borderColor;

  const MyCustomSD({Key? key,

    this.decoration,
    this.label,
    this.prefixIcon,
    required this.listToSearch,
    this.initialValue,
    this.hideSearch,
    this.height,
    this.borderColor,
    required this.valFrom,
    required this.onChanged,}) : super(key: key);

  @override
  _MyCustomSDState createState() => _MyCustomSDState();
}

class _MyCustomSDState extends State<MyCustomSD> {

  bool obscure=false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }





  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return CustomSearchableDropDown(

      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: 5),
        child:widget.prefixIcon!=null? Icon(widget.prefixIcon,size: 21,color: Colors.blue):const SizedBox(),
      ),
      searchBarHeight: 40,
      padding: const EdgeInsets.all(0),
      initialValue: widget.initialValue,
      primaryColor: AppColor.greyDark,
      hideSearch: widget.hideSearch?? false,
      menuHeight: widget.height??80,
      menuMode: true,
      labelStyle: MyTextTheme().mediumBCN,
      items: widget.listToSearch,
      label: widget.label??localization.getLocaleData.selectName.toString(),
      dropdownItemStyle: MyTextTheme().mediumBCN,

      dropDownMenuItems: widget.listToSearch.map((item) {
        return item[widget.valFrom];
      }).toList(),
      onChanged: (val){
        widget.onChanged(val);
      },
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(color: widget.borderColor??Colors.transparent)
      ),

    );
  }
}


