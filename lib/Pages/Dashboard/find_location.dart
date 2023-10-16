

import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/widgets/my_custom_sd.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Localization/app_localization.dart';
import 'find_location_provider.dart';
import 'locationDataModal.dart';

class FindLocation extends StatefulWidget {
  const FindLocation({Key? key}) : super(key: key);

  @override
  State<FindLocation> createState() => _FindLocationState();
}

class _FindLocationState extends State<FindLocation> {


@override
  void initState() {
    // TODO: implement initState
  LocationProvider provider=Provider.of<LocationProvider>(context,listen: false);
  provider.updateDepList=[];
  provider.getAllDepartments();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    LocationProvider provider=Provider.of<LocationProvider>(context,listen: true);
    ApplicationLocalizations localization = Provider.of<ApplicationLocalizations>(context, listen: false);
    return Container(
      color: AppColor.primaryColor,

      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:   BoxDecoration(
                  color: AppColor.white,
                  image: const DecorationImage(
                      image:  AssetImage("assets/kiosk_bg_img.png",
                      ),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children:  [
                    Text(localization.getLocaleData.location!.toString(),style: MyTextTheme().customLargePCB,),
                    MyCustomSD(
                      label: 'Choose location',
                      height: 500,
                      listToSearch: provider.departmentList, valFrom:'departmentName', onChanged: (value) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          if(value!=null){
                            provider.getLocation( id:value!['id'].toString()??'');
                          }
                        }
                        );
                    },),
                    const SizedBox(height: 20,),
                    Container(
                      color: AppColor.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text('Building Name',style:MyTextTheme().largeWCN,),
                            Text('Department Name',style:MyTextTheme().largeWCN,),
                            Text('Floor Number',style:MyTextTheme().largeWCN,),
                            Text('Room Number',style:MyTextTheme().largeWCN,),
                          ],
                        ),
                      ),
                    ), Visibility(
                      visible: provider.locations.isEmpty,
                      child: Container(
                        color: AppColor.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Text('No data found',style:MyTextTheme().largeWCN,),
                            ],
                          ),
                        ),
                      ),
                    ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height-350,
                     child: ListView.builder(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: provider.locations.length,
                       itemBuilder: (BuildContext context, int index) {
                         var location= provider.locations[index];
                       return  Container(
                         color: AppColor.lightBlue,
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children:  [
                               Text(location['buildingName'].toString(),style:MyTextTheme().largePCB,),
                               Text(location['departMentName'].toString(),style:MyTextTheme().largePCB,),
                               Text(location['floorName'].toString(),style:MyTextTheme().largePCB,),
                               Text(location['roomNumber'].toString(),style:MyTextTheme().largePCB,),
                             ],
                           ),
                         ),
                       );
                     },),
                   ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
