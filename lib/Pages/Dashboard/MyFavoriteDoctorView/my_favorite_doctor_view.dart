import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/Dashboard/DataModal/dashboard_data_modal.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../AppManager/app_util.dart';
import '../../Specialities/SpecialistDoctors/DoctorProfile/doctor_profile_view.dart';
import '../dashboard_controller.dart';

class MyFavoriteDoctorView extends StatelessWidget {
  const MyFavoriteDoctorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardModal modal = DashboardModal();
    return SizedBox(
      height: 240,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<DashboardController>(builder: (_) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: modal.controller.favouriteDoctorsData.length,
              itemBuilder: (BuildContext context, int index) {
                FavouriteDoctorsModal detail =
                modal.controller.favouriteDoctorsData[index];
                return
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            App().navigate(context,
                                DoctorProfile(doctorId: detail.id.toString(),));
                          },
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 0.7,
                                    color: AppColor.greyLight
                                ),
                                color: AppColor.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 110,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.lightBlue
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: detail.profilePhotoPath
                                          .toString(),
                                      errorWidget: (context, url,
                                          error) =>
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 10, 15, 15),
                                            child: SizedBox(
                                                child: SvgPicture.asset(
                                                    'assets/user_image.svg')),
                                          ),
                                      imageBuilder:
                                          (context, imageProvider) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(
                                                      10),
                                                  topRight:
                                                  Radius.circular(
                                                      10)),
                                              image: DecorationImage(
                                                image: imageProvider,
                                              ),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          SizedBox(
                                              height: 10, width: 10,
                                              child: SvgPicture.asset(
                                                  'assets/user_image.svg')),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          detail.name
                                              .toString()
                                              .capitalize!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: MyTextTheme().mediumBCB
                                              .copyWith(fontSize: 13),
                                        ),
                                        Text(
                                          detail.hospitalName.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: MyTextTheme().smallBCN,
                                        ),
                                        Text(
                                          detail.subDepartmentName.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: MyTextTheme().smallBCN,
                                        ),
                                        detail.yearOfExperience == "" ?
                                        const Text(
                                            "--"
                                        ) : detail.yearOfExperience
                                            .toString() == "1" ?
                                        Text(
                                          "${detail
                                              .yearOfExperience} Year experience",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: MyTextTheme().smallBCN,
                                        ) : Text(
                                          "${detail
                                              .yearOfExperience} Years of experience",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: MyTextTheme().smallBCN,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 20,
                            top: 18,
                            child: SvgPicture.asset('assets/heart.svg',
                              height: 15, width: 15,))
                      ],
                    ),
                  );
              }
          );
        }),
      ),
    );
  }
}

