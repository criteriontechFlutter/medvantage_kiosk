import 'package:digi_doctor/AppManager/ImageView.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:flutter/material.dart';

import '../../app_color.dart';
import '../../user_data.dart';

class UserImage extends StatelessWidget {
  const UserImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        App().navigate(context, ImageView(url: UserData().getUserProfilePhotoPath.toString(),));
      },
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: AppColor.primaryColor,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppColor.white,
              child: CircleAvatar(
                radius: 21,
                backgroundImage: const AssetImage('assets/noProfileImage.png'),
                foregroundImage: NetworkImage(
                  UserData().getUserProfilePhotoPath.toString(),
                ),
              ),
            ),
          )),
    );
  }
}
