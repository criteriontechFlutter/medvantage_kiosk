
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/prescription_history/prescription_details/prescription_details_view.dart';
import 'package:digi_doctor/Pages/prescription_history/prescription_history_modal.dart';
import 'package:digi_doctor/Pages/prescription_history/prescripton_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import '../../AppManager/ImageView.dart';
import '../../AppManager/tab_responsive.dart';
import '../../AppManager/widgets/my_app_bar.dart';
import 'add_prescription/add_prescription_module.dart';
import 'dataModal/prescription_history_data_modal.dart';

class PrescriptionHistory extends StatefulWidget {
  const PrescriptionHistory({Key? key}) : super(key: key);

  @override
  _PrescriptionHistoryState createState() => _PrescriptionHistoryState();
}

class _PrescriptionHistoryState extends State<PrescriptionHistory> {


  get() async {
    modal.controller.dateController.value.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
   // await modal.getPrescriptionHistory(context);
  }


  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<PrescriptionHistoryController>();
  }

  PrescriptionHistoryModal modal = PrescriptionHistoryModal();

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.prescriptionHistory.toString()),
          body: GetBuilder(
            init: PrescriptionHistoryController(),
            builder: (_) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localization.getLocaleData.hello.toString() + UserData().getUserName,
                                  style: MyTextTheme().mediumBCB),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(localization.getLocaleData.howAreYouToday.toString(),
                                  style: MyTextTheme().smallBCN)
                            ],
                          ),
                          TabResponsive().wrapInTab(
                            context: context,
                            child: MyButton(
                              width: 150,
                              title: localization.getLocaleData.add.toString(),
                              buttonRadius: 25,
                              onPress: () {
                                AddPrescriptionModule(context);
                                // App().navigate(context, const AddPrescription());
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                      child: Text(
                        localization.getLocaleData.prescriptionHistory.toString(),
                        style: MyTextTheme().mediumBCB,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CommonWidgets().showNoData(
                          title: localization.getLocaleData.prescriptionHistoryNotFound.toString(),
                          show: (modal.controller.getShowNoData &&
                              modal.controller.getPrescriptionHistoryList.isEmpty),
                          loaderTitle: localization.getLocaleData.loadingPrescriptionHistory.toString(),
                          showLoader: (!modal.controller.getShowNoData &&
                              modal.controller.getPrescriptionHistoryList.isEmpty),
                          child:   ListView(
                            children: [
                              StaggeredGrid.count(

                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 0.0,
                                crossAxisCount: MediaQuery.of(context).size.width>600? 2:1,
                                children: List.generate(
                                  modal.controller.prescriptionHistoryList.length,
                                      (index) {
                                    PrescriptionHistoryDataModal details =
                                    modal.controller.prescriptionHistoryList.isEmpty
                                        ? PrescriptionHistoryDataModal()
                                        : modal.controller
                                        .getPrescriptionHistoryList[index];
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: InkWell(
                                        onTap: () {

                                          details.filePath.toString()==''?
                                          App().navigate(
                                              context,
                                              PrescriptionDetails(
                                                prescriptionDetail: details,
                                              )):
                                          App().navigate(
                                              context,
                                              ImageView(url: details.filePath.toString(),
                                              ));

                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          height: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(1),
                                            border:
                                            Border.all(color: AppColor.greyLight),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 5,),
                                              CircleAvatar(
                                                backgroundColor: Colors.blue.shade50,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image.asset('assets/medical-prescription.png',width: 30,height: 30,),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10,),
                                              Expanded(
                                                flex: 8,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      modal
                                                          .controller
                                                          .getPrescriptionHistoryList[
                                                      index]
                                                          .start_date
                                                          .toString(),
                                                      style: MyTextTheme().smallBCB,
                                                    ),
                                                    //   Flexible(
                                                    //     child: Text(
                                                    //       modal
                                                    //       .controller
                                                    //       .getPrescriptionHistoryList[
                                                    //           index]
                                                    //       .problem_name
                                                    //       .toString(),
                                                    // overflow: TextOverflow.clip,
                                                    //       style: MyTextTheme().smallBCB,
                                                    //     ),
                                                    //   ),

                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.double_arrow_outlined,
                                                  size: 20,
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )]);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
