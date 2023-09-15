

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
        flexibleSpace,
        toolbarHeight,
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
      backgroundColor: AppColor.primaryColor,
      actions: action,
      flexibleSpace: flexibleSpace,
      toolbarHeight: toolbarHeight,
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


  mySilverAppBar(
      context,
      {
        elevation,
        leadingIcon,
        subtitle,
        bool? hideLeadingIcon,
        title,
        List<Widget>? action,
        flexibleSpace,
        toolbarHeight,
      }){
    return SliverAppBar(
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
      backgroundColor: AppColor.primaryColor,
      actions: action,
      flexibleSpace: flexibleSpace,
      toolbarHeight: toolbarHeight,
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