

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_color.dart';
import '../my_text_theme.dart';
import '../user_data.dart';
import 'common_widgets.dart';




class MyWidget {

  UserData user=Get.put(UserData());

  myAppBar(
      context,
      {
        elevation,
        leadingIcon,
        subtitle,
        bool? hideLeadingIcon,
        title,
        List<Widget>? action,
      }){
    return AppBar(
      elevation: elevation??0,
      automaticallyImplyLeading: false,
      leading: (hideLeadingIcon?? false)? null:leadingIcon?? CommonWidgets().backButton(context),
      centerTitle: false,
      title:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toString(),
            style: MyTextTheme().largeBCB,),
          Visibility(
            visible: subtitle!=null,
            child: Text(subtitle.toString(),
              style: MyTextTheme().smallWCN,),
          ),
        ],
      ),
      backgroundColor: AppColor.white,
      actions: action,
      // flexibleSpace: SizedBox(
      //   height: 80,
      //   child: SvgPicture.asset(
      //       'assets/appBarBG.svg',
      //       semanticsLabel: 'Acme Logo',
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }




  myAppBarWithBG(
      context,
      {
        elevation,
        leadingIcon,
        title,
        List<Widget>? action,
      }){
    return AppBar(
      elevation: elevation??0,
      automaticallyImplyLeading: false,
      leading: leadingIcon?? CommonWidgets().backButton(context),
      centerTitle: true,
      title:  Text(title.toString(),
        style: MyTextTheme().largeWCN,),
      backgroundColor:  AppColor.primaryColor,
      actions: action,
    );
  }

  cart(context,{cartValue}){
    return
      Stack(
          children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.shopping_cart,color: AppColor.white,
            ),
          ),
            Positioned(left: 20,child: CircleAvatar(backgroundColor: AppColor.red,radius:10,child: Text(cartValue.toString(),style: MyTextTheme().smallWCB,),)
            )
          ]
      );

  }
  pharmacyAppBar(
      context,
      {
        elevation,
        leadingIcon,
        subtitle,
        bool? hideLeadingIcon,
        title,
        List<Widget>? action,
      }){
    return AppBar(
      elevation: elevation??0,
      automaticallyImplyLeading: false,
      leading: (hideLeadingIcon?? false)? null:leadingIcon?? CommonWidgets().backButton(context),
      centerTitle: false,
      title:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toString(),
            style: MyTextTheme().largeWCB,),
          Visibility(
            visible: subtitle!=null,
            child: Text(subtitle.toString(),
              style: MyTextTheme().smallWCN,),
          ),
        ],
      ),
      backgroundColor: AppColor.pharmacyPrimaryColor,
      actions: action,
      // flexibleSpace: SizedBox(
      //   height: 80,
      //   child: SvgPicture.asset(
      //       'assets/appBarBG.svg',
      //       semanticsLabel: 'Acme Logo',
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }

}