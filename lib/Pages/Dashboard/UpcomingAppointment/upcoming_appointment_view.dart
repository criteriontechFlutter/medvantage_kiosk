

import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_modal.dart';
import 'package:digi_doctor/Pages/MyAppointment/MyAppointmentDataModal/my_appointment_data_modal.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class UpcomingAppointmentView extends StatefulWidget {
  const UpcomingAppointmentView({Key? key}) : super(key: key);

  @override
  State<UpcomingAppointmentView> createState() => _UpcomingAppointmentViewState();
}

class _UpcomingAppointmentViewState extends State<UpcomingAppointmentView> {

  DashboardModal modal = DashboardModal();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return SizedBox(
        height: 160,
        child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              PageView.builder(
                itemCount: modal.controller.upcomingAppointmentsData.length,
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemBuilder: (BuildContext context, int index) {
                  MyAppointmentDataModal detail =
                  modal.controller.upcomingAppointmentsData[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                    child: Container(
                      height: 135,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 130,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.primaryColor
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Text(DateFormat('E').format(
                                      DateFormat('dd/MM/yyyy').parse(detail.appointDate.toString())), style: MyTextTheme().mediumWCN,),
                                  Text(DateFormat('d').format(
                                      DateFormat('dd/MM/yyyy').parse(detail.appointDate.toString())),
                                      style: MyTextTheme().largeWCB.copyWith(
                                          fontSize: 30)),
                                  Text(DateFormat('MMM').format(
                                      DateFormat('dd/MM/yyyy').parse(detail.appointDate.toString())), style: MyTextTheme().mediumWCB,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 0, 5, 0),
                                    child: Divider(color: AppColor.white,),
                                  ),
                                  Text(
                                    detail.appointTime.toString(), style: MyTextTheme().smallWCN,),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(detail.doctorName.toString(),
                                    style: MyTextTheme().largeBCB, maxLines: 1,),
                                  Text(detail.specialty.toString(),
                                    style: MyTextTheme().mediumBCN, maxLines: 1,),
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/location.svg',height: 15,width: 15,),
                                      const SizedBox(width: 5),
                                      Expanded(child: Text(
                                        detail.location.toString(),
                                        style: MyTextTheme().mediumBCN,
                                        maxLines: 2,)),
                                    ],
                                  ),
                                  Divider(color: AppColor.greyLight,),


                                  Expanded(child: Container(
                                    alignment: Alignment.topRight,
                                    child: MyButton(
                                      width: 100,
                                      height: 35,
                                      title: localization.getLocaleData.alertToast!.cancel.toString(),
                                      color: AppColor.orangeColorDark,
                                      onPress: () async {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Stack(
                                                  clipBehavior:Clip.none ,
                                                  children: [
                                                    Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children:[
                                                          Text(localization.getLocaleData.doYouWantCancelThisAppointment.toString()),
                                                          const SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              InkWell(onTap: (){
                                                                Navigator.of(context).pop();},
                                                                  child: Text(localization.getLocaleData.no.toString(),style: MyTextTheme().mediumGCB.copyWith(fontSize: 16))),
                                                              const SizedBox(width: 100),
                                                              InkWell(onTap: (){
                                                                modal.cancelAppointment(context, detail.appointmentId.toString());
                                                                _currentPage=0;
                                                                setState(() {

                                                                });
                                                                },
                                                                  child: Text(localization.getLocaleData.yes.toString(),style: MyTextTheme().mediumGCB.copyWith(fontSize: 16))),
                                                            ],
                                                          ),
                                                        ]
                                                    )
                                                  ],
                                                ),
                                              );
                                            });

                                      },),
                                  ))
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),


                    ),
                  );
                },
              ),
              Positioned(
                bottom: 0,
                child: DotsIndicator(
                  decorator: DotsDecorator(
                    activeColor: Colors.grey.shade200,
                  ),
                  dotsCount: modal.controller.upcomingAppointmentsData.length,
                  position: double.parse(_currentPage.toString()),
                ),
              ),
            ]
        )
    );
  }
}



