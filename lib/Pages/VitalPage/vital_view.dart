import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/VitalPage/vital_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart'; 
import '../../AppManager/widgets/my_app_bar.dart';

class VitalView extends StatefulWidget {
  const VitalView({Key? key}) : super(key: key);
  @override
  State<VitalView> createState() => _VitalViewState();
}

class _VitalViewState extends State<VitalView> {

  VitalModal modal = VitalModal();



  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.vital.toString()),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 40, 15, 30),
            child: Column(
              children: [
                Expanded(
                    child:   ListView(
                      children: [
                        StaggeredGrid.count(
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 0.0,
                          crossAxisCount: MediaQuery.of(context).size.width>600? 2:1,
                          children: List.generate(
                              modal.controller.getVitalCardList(context).length,
                                  (index) {
                                // ListView.builder(
                                //
                                //     itemCount: modal.controller.vitalCardList.length,
                                //     itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color:AppColor.white,
                                  child: InkWell(
                                    onTap: () async {
                                 // await modal.onPressedVitalOption(context, modal.controller.getVitalCardList(context)[index]['title']);
                                 await modal.onPressedVitalOption(context, index);

                                      // if(index==0){
                                      //   App().navigate(
                                      //       context,
                                      //       modal.controller.vitalCardList[index]
                                      //           ['onPressed']);
                                      // }
                                      // else{
                                      //   alertToast(context, 'Coming Soon...');
                                      // }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              modal.controller.getVitalCardList(context)[index]['img']
                                                  .toString(),color: Colors.blue,
                                              height: 30,
                                              width: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  modal.controller
                                                      .getVitalCardList(context)[index]['title']
                                                      .toString(),
                                                  style: MyTextTheme().mediumBCB,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                          modal.controller
                                                              .getVitalCardList(context)[index]['subTitle']
                                                              .toString(),
                                                          style:  MyTextTheme().smallBCN,
                                                        )),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColor.orangeColorDark,
                                                          borderRadius:
                                                          BorderRadius.circular(100)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4),
                                                        child: Icon(
                                                          Icons.arrow_forward,
                                                          color: AppColor.white,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 5,)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                )],
            ),
          ),
        ),
      ),
    );
  }
}
