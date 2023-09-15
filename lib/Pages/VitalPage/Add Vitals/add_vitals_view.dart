
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/VitalHistory/vital_history_view.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/add_vitals_controller.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/add_vitals_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/tab_responsive.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import '../../../Localization/app_localization.dart';
import '../../Specialities/SpecialistDoctors/TimeSlot/AppointmentBookedDetails/appointment_booked_controller.dart';


class AddVitalsView extends StatefulWidget {
  const AddVitalsView({Key? key}) : super(key: key);

  @override
  AddVitalsViewState createState() => AddVitalsViewState();
}

class AddVitalsViewState extends State<AddVitalsView> {
  AddVitalsModel modal = AddVitalsModel();


  get(){
    for(int i=0;i<modal.controller.vitalTextX.length;i++){
      modal.controller.vitalTextX[i].clear();
    }

  }

  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<AddVitalsController>();
    Get.delete<AppointmentBookedController>();
  }


  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyWidget().myAppBar(context,title: localization.getLocaleData.addVitals.toString(),action: [
            GestureDetector(
              onTap: (){
                App().navigate(context, const VitalHistoryView());


              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SvgPicture.asset('assets/vital-signs.svg'),
              ),
            )
          ]),
          body: TabResponsive().wrapInTab(
            context: context,
            child: GetBuilder(
              init: AddVitalsController(),
              builder: (AddVitalsController controller) {
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(localization.getLocaleData.vital.toString(),style: MyTextTheme().mediumBCB,),
                                    const SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                                'assets/bloodPressureImage.svg')),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          localization.getLocaleData.bloodPressure.toString(),
                                          style: MyTextTheme().smallBCB,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: MyTextField2(
                                              controller: modal.controller.systolicC.value,
                                              hintText: localization.getLocaleData.hintText!.systolic.toString(),
                                              maxLength: 3,
                                              keyboardType: TextInputType.number,
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: MyTextField2(
                                              controller: modal.controller.diastolicC.value,
                                              hintText:  localization.getLocaleData.hintText!.diastolic.toString(),
                                              maxLength: 3,
                                              keyboardType: TextInputType.number,
                                            ))
                                      ],
                                    ),

                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: modal.controller.getVitalsList(context).length,
                                      itemBuilder: (BuildContext context, int index) {
                                        // print('-------------'+modal.controller.getVitalsList(context)[index]['controller'].value.text.toString());
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor: Colors.white,
                                                    child: SvgPicture.asset(modal
                                                        .controller
                                                        .getVitalsList(context)[index]['image']
                                                        .toString())),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    modal.controller
                                                        .getVitalsList(context)[index]['title']
                                                        .toString(),
                                                    style: MyTextTheme().smallBCB,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),

                                            MyTextField2(
                                              controller:modal.controller.vitalTextX[index],
                                              hintText: modal.controller
                                                  .getVitalsList(context)[index]['leading']
                                                  .toString(),
                                              maxLength:index==1? 6:3,
                                              onChanged: (val){
                                                setState(() {

                                                });
                                              },
                                              keyboardType: TextInputType.number,
                                            ),

                                          ],
                                        );
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 30,),
                                        Text("Height & Weight",style: MyTextTheme().mediumBCB,),
                                        const SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: MyTextField2(hintText: "Height",controller: modal.controller.heightC.value,)),
                                            const SizedBox(width: 15,),
                                            Expanded(child: MyTextField2(hintText: "Weight",controller: modal.controller.weightC.value)),
                                          ],
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0,15, 15),
                      child: MyButton(
                        title: localization.getLocaleData.submit.toString(),
                        buttonRadius: 25,
                        color: AppColor.orangeButtonColor,
                        onPress: () {
                          modal.onPressedSubmit(context);
                        },
                      ),
                    ),
                  ],
                );
              },

            ),
          ),
        ),
      ),
    );
  }
}
