import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/widgets/my_app_bar.dart';

class TestDetailView extends StatefulWidget {
  const TestDetailView({Key? key}) : super(key: key);

  @override
  State<TestDetailView> createState() => _TestDetailViewState();
}

class _TestDetailViewState extends State<TestDetailView> {
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.investigation.toString(), action: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: AppColor.orangeColorDark,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [const Icon(Icons.add), Text(localization.getLocaleData.addManually.toString())],
              ),
            ),
          )
        ]),
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: TabBar(
                isScrollable: true,
                labelColor: AppColor.primaryColor,
                unselectedLabelColor: AppColor.greyDark,

                tabs:   [
                  Tab(
                    icon: Row(
                      children: [
                        SvgPicture.asset('assets/manuallyReport.svg'),
                        const SizedBox(width: 5,),
                        Text(localization.getLocaleData.manuallyReport.toString()),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      children: [
                        SvgPicture.asset('assets/investigation.svg'),
                        const SizedBox(width: 5,),
                        Text(localization.getLocaleData.erasInvestigation.toString()),
                      ],
                    ),),
                  Tab(
                    icon: Row(
                      children: [
                        SvgPicture.asset('assets/radiology.svg'),
                        const SizedBox(width: 5,),
                        Text(localization.getLocaleData.radiologyReport.toString()),
                      ],
                    ),),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  manuallyReport(),
                  manuallyReport(),
                  manuallyReport(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  manuallyReport() {
    return const Text('data');
  }

}
