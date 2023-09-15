import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalList extends StatefulWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.Hospitalbackground,
          appBar: MyWidget().myAppBar(context,title: localization.getLocaleData.hospitals.toString()),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 8.0, 15.0,8.0),
                    child: Card(shadowColor: AppColor.greyDark,
                      color: AppColor.white,
                      shape: const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10))),
                      child: SizedBox(
                          height: 160,

                          child: Padding(
                            padding:  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(localization.getLocaleData.chaitanyaHospital.toString(),style: MyTextTheme().largeBCB,),
                                    TextButton.icon(
                                      icon: const Image(image: AssetImage('assets/directions.png'),),
                                      label: Text(localization.getLocaleData.duration.toString(),style: MyTextTheme().smallGCN,),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                                Expanded(child: Text(localization.getLocaleData.eraMedicalCollegeLucknow.toString() ,style:MyTextTheme().smallGCN ,)),
                                const SizedBox(height: 20,),
                                const Divider(thickness: 1,),
                                Row(
                                  children: [
                                 Icon(Icons.call,color: AppColor.primaryColor,),
                                    const SizedBox(width: 4,),
                                    Text(localization.getLocaleData.hospitalNumber.toString()),
                                    const SizedBox(width: 110,),
                                    Expanded(child:  MyButton(title: localization.getLocaleData.shareDetails.toString(),color: AppColor.orangeButtonColor,))
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  );

                }),
          ),
        ),
      ),
    );
  }
}
