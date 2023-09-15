
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../Localization/app_localization.dart';
import '../DataModal/isolation_history_data_modal.dart';

class IsolationRequestDetailsView extends StatefulWidget {
  final IsolationHistoryDataModal requestDetail;

  const IsolationRequestDetailsView({Key? key, required this.requestDetail})
      : super(key: key);

  @override
  State<IsolationRequestDetailsView> createState() =>
      _IsolationRequestDetailsViewState();
}

class _IsolationRequestDetailsViewState
    extends State<IsolationRequestDetailsView> {
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.isolationRequestDetail.toString()),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(45, 20, 15, 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.greyLight)),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.transparent,
                            child: widget.requestDetail.homeIsolationStatus
                                        .toString() ==
                                    localization.getLocaleData.approved.toString()
                                ? Lottie.asset('assets/approveIsolation.json')
                                :widget.requestDetail.homeIsolationStatus
                                .toString() ==
                                localization.getLocaleData.pending.toString()?
                            Lottie.asset('assets/pending.json',): Lottie.asset('assets/failedIsolation.json',)
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.requestDetail.hospitalName.toString(),
                              style: MyTextTheme().mediumBCB,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.requestDetail.homeIsolationStatus.toString(),
                              style: MyTextTheme()
                                  .mediumBCB
                                  .copyWith(color: AppColor.orangeButtonColor),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(45, 15, 15, 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.greyLight)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.getLocaleData.hintText!.name.toString().toString(),
                          style: MyTextTheme().mediumBCB,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.requestDetail.name.toString(),
                          style: MyTextTheme()
                              .smallBCB
                              .copyWith(color: AppColor.greyDark),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(localization.getLocaleData.mobileNumber.toString().toString(),
                            style: MyTextTheme().smallBCB),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.requestDetail.userMobileNo.toString(),
                            style: MyTextTheme()
                                .smallBCB
                                .copyWith(color: AppColor.greyDark))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(45, 15, 15, 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.greyLight)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.getLocaleData.symptoms.toString().toString(),
                          style: MyTextTheme().mediumBCB,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.requestDetail.stymptoms.toString(),
                          style: MyTextTheme()
                              .smallBCB
                              .copyWith(color: AppColor.greyDark),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(localization.getLocaleData.onSetDate.toString().toString(),
                            style: MyTextTheme().smallBCB),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.requestDetail.onSetDate.toString(),
                            style: MyTextTheme()
                                .smallBCB
                                .copyWith(color: AppColor.greyDark)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(localization.getLocaleData.comorbidies.toString().toString(),
                            style: MyTextTheme().smallBCB),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.requestDetail.comoribid.toString(),
                            style: MyTextTheme()
                                .smallBCB
                                .copyWith(color: AppColor.greyDark)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(localization.getLocaleData.package.toString(), style: MyTextTheme().smallBCB),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.requestDetail.packageName.toString(),
                            style: MyTextTheme()
                                .smallBCB
                                .copyWith(color: AppColor.greyDark)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(localization.getLocaleData.coronaTestDate.toString().toString(),
                            style: MyTextTheme().smallBCB),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.requestDetail.testDate.toString(),
                            style: MyTextTheme()
                                .smallBCB
                                .copyWith(color: AppColor.greyDark)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(localization.getLocaleData.allergy.toString(), style: MyTextTheme().smallBCB),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.requestDetail.allergires.toString(),
                            style: MyTextTheme()
                                .smallBCB
                                .copyWith(color: AppColor.greyDark)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(localization.getLocaleData.lifeSupport.toString().toString(),
                            style: MyTextTheme().smallBCB),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(''.toString(),
                            style: MyTextTheme()
                                .smallBCB
                                .copyWith(color: AppColor.greyDark)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(localization.getLocaleData.o2Value.toString(), style: MyTextTheme().smallBCB),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.requestDetail.o2.toString(),
                            style: MyTextTheme()
                                .smallBCB
                                .copyWith(color: AppColor.greyDark)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
