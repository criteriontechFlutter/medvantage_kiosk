import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Localization/app_localization.dart';
import 'Local_Storage.dart';
import '../../AppManager/widgets/common_widgets.dart';
import '../../AppManager/widgets/my_app_bar.dart';
import 'DataModal/medicineDataModal.dart';
import 'DataModal/notification.dart';
import 'medicine_Controller.dart';
import 'medicine_Modal.dart';

class MedicineView extends StatefulWidget {
  const MedicineView({Key? key}) : super(key: key);

  @override
  State<MedicineView> createState() => _MedicineViewState();
}

class _MedicineViewState extends State<MedicineView> {
  late final int id;
  late final Color color;
  late final String title;
  late final String content;
  late String dateFormate;

  DateTime? selectedDate = DateTime.now();
  DateTime? fullDate = DateTime.now();

  // final MedicineNotificationService _notificationService =
  //     MedicineNotificationService();

    LocalData localData = Get.put(LocalData());

  MedicineModal modal = MedicineModal();
  Future<DateTime> _selectDate(
    BuildContext context,
  ) async {
    final date = await showDatePicker(

        context: context,
        firstDate: DateTime.now(),
        initialDate: selectedDate!,
        lastDate: DateTime(2100));

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate!),
      );
      if (time != null) {
        setState(() {
          fullDate = DateTimeField.combine(date, time);
        });
        print('--------------------------time' + time.toString());
        print('--------------------------fullDate' + fullDate.toString());
        //
        // await _notificationService.scheduleNotifications(
        //     MID: modal.controller.getSelectedMID,
        //     title: modal.controller.getSelectedMNAME.toString(),
        //     body: "Please Take: " +
        //         modal.controller.getSelectedMNAME.toString() +
        //         " Medicine",
        //     time: fullDate);
        alertToast(context, 'Reminder Added Successfully');
      }
      return DateTimeField.combine(date, time);
    }
    else {
      return selectedDate!;
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    var data = LocalData()
        .getLocalData
        .where((element) => element['id'].Containes('1'))
        .toString();
    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv' + data);
    await modal.medicineReminder(context);
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(context,
              title: localization.getLocaleData.medicineReminder.toString()),
          body: GetBuilder(
              init: MedicineController(),
              builder: (_) {
                return Column(
                  children: [
                    Expanded(
                        child: Center(
                      child: CommonWidgets().showNoData(
                        title: localization
                            .getLocaleData.medicineReminderDataNotFound
                            .toString(),
                        show: (modal.controller.getShowNoData &&
                            modal.controller.getMedicineList.isEmpty),
                        loaderTitle: localization
                            .getLocaleData.loadingMedicineReminderData
                            .toString(),
                        showLoader: (!modal.controller.getShowNoData &&
                            modal.controller.getMedicineList.isEmpty),
                        child: ListView.builder(
                            itemCount: modal.controller.medicineList.length,
                            itemBuilder: (BuildContext context, int index) {
                              MedicineReminderDataModal medicineData =
                                  modal.controller.getMedicineList[index];
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                child: Card(
                                  child: Container(
                                    decoration:
                                        const BoxDecoration(color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            medicineData.medicineName.toString(),
                                            style: MyTextTheme().largeBCB,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            medicineData.dosageFormName.toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  localization
                                                          .getLocaleData.frequency
                                                          .toString() +
                                                      medicineData.frequencyName
                                                          .toString() +
                                                      ' ' +
                                                      medicineData.durationInDays
                                                          .toString(),
                                                  style: MyTextTheme().smallBCN,
                                                ),
                                                Text(localization.getLocaleData.days
                                                    .toString())
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 8, 15, 8),
                                            child: InkWell(
                                              onTap: () async {
                                                modal.controller
                                                        .updateSelectedMNAME =
                                                    medicineData.medicineName
                                                        .toString();
                                                modal.controller.updateSelectedMID =
                                                    int.parse(
                                                        medicineData.id.toString());
                                                MyDate(
                                                  medicineData,
                                                );
                                              },
                                              child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    color: Colors.green),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                  children: [
                                                    const SizedBox(
                                                      width: 80,
                                                    ),
                                                    Text(
                                                      localization
                                                          .getLocaleData.setReminder
                                                          .toString(),
                                                      style: MyTextTheme().smallWCB,
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    const Icon(
                                                      Icons.alarm_add,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ))
                  ],
                );
              }),
        ),
      ),
    );
  }

  MyDate(
    MedicineReminderDataModal medicineData,
  ) {


     AlertDialogue()
        .show(context, title: medicineData.medicineName.toString(), newWidget: [

       GetBuilder(
           init: MedicineController(),
           builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder(
                  init: LocalData(),
                  builder: (_) {
                    List medicineReminder=[];
                     medicineReminder = localData.getLocalData
                        .where((element) => element['MId'] == medicineData.id)
                        .toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: medicineReminder.length,

                      itemBuilder: (BuildContext context, int index) {
                        var reminder = medicineReminder[index];
                        return Row(
                          children: [
                            Expanded(child: Text(DateFormat('dd-MM-yyyy hh:mm a').format((DateFormat('yyyy-MM-dd hh:mm').parse(reminder['time'].toString()))))),
                            // InkWell(
                            //   onTap: () async {
                            //       await MedicineNotificationService()
                            //           .deleteMyReminder(reminder['id']);
                            //       localData.deleteReminder(reminder['id']);
                            //     },
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Icon(
                            //       Icons.delete,
                            //       color: AppColor.red,
                            //     ),
                            //   ),
                            // )
                          ],
                        );
                      },
                    );
                  }),
              MyButton2(
                // title: localization.getLocaleData.done.toString(),
                title: 'Select Date Time',
                width: 200,
                onPress: () {
                  Navigator.pop(context);
                  _selectDate(context);
                },
              ),
            ],
          );
        }
      )
    ]);
  }
}
