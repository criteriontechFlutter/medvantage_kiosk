
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../AppManager/app_util.dart';
import '../../../../../Localization/app_localization.dart';
import '../../../../Dashboard/dashboard_view.dart';
import '../../../../StartUpScreen/startup_screen.dart';
import 'appointment_booked_view.dart';

class AppointmentSuccessful extends StatefulWidget {
  const AppointmentSuccessful({Key? key}) : super(key: key);

  @override
  State<AppointmentSuccessful> createState() => _AppointmentSuccessfulState();
}

class _AppointmentSuccessfulState extends State<AppointmentSuccessful> {
  TimeSlotModal modal = TimeSlotModal();
  backButton(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                const StartupPage()),
            (Route<dynamic> route) => false);
    // App().replaceNavigate(context, DashboardView());
    // Get.offAll(());
  }
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: (){
            return backButton();
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,100,0,0),
                    child: SizedBox(
                        height: 200,
                        child: SvgPicture.asset('assets/noDoctor.svg')),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    localization.getLocaleData.yourAppointmentDoneSuccessfully.toString(),
                    textAlign: TextAlign.center,
                    style: MyTextTheme().largeBCB,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    localization.getLocaleData.yourAppointmentBookedWith.toString() +
                        modal.controller.getAppointmentDetailList.doctorName
                            .toString() +
                        localization.getLocaleData.on.toString()+modal.controller.getAppointmentDetailList.visitDate
                        .toString()+ localization.getLocaleData.at.toString()+modal.controller.getAppointmentDetailList.visitTime
                        .toString(),
                    textAlign: TextAlign.center,
                    style: MyTextTheme().mediumBCN,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    localization.getLocaleData.thankYouOurServices.toString(),
                    textAlign: TextAlign.center,
                    style: MyTextTheme().mediumBCB,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  MyButton2(
                    title: localization.getLocaleData.appointmentDetails.toString(),
                    color: AppColor.primaryColor,
                    width: 300,
                    onPress: () {
                      App().navigate(context, const StartupPage());
                     // App().navigate(context, AppointmentBookedView(details: modal.controller.getAppointmentDetailList,));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
