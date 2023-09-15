


import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Dashboard/AssociationDoctor/associationDoctorClinicMap.dart';
import 'package:digi_doctor/Pages/Dashboard/AssociationDoctor/association_doctor_data_modal.dart';
import 'package:digi_doctor/Pages/Dashboard/AssociationDoctor/association_doctor_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../../../AppManager/widgets/MyTextField.dart';
import '../../../../AppManager/widgets/common_widgets.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';


class AssociationDoctorView extends StatefulWidget {

  const AssociationDoctorView({Key? key,}) : super(key: key);

  @override
  State<AssociationDoctorView> createState() => _AssociationDoctorViewState();
}

class _AssociationDoctorViewState extends State<AssociationDoctorView> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
  }

  get() async {
    await modal.getAssociationDoctorList(context);
  }

  final rnd = math.Random();
  Color getRandomColor() => Color(rnd.nextInt(0xffffffff)).withAlpha(0xff);

  AssociationDoctorListModal modal =  AssociationDoctorListModal();

  @override
  Widget build(BuildContext context)  {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Scaffold(
      appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.associationDoctor.toString()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15,10,15,0),
            child: MyTextField(hintText:localization.getLocaleData.search,
              controller: modal.controller.searchName,
              suffixIcon: const Icon(Icons.search,),
              onChanged: (val){
                modal.controller.update();
              },
            ),
          ),
          GetBuilder(
              init: modal.controller,
              builder: (_) {
                return Expanded(
                  child: CommonWidgets().showNoData(
                    show:modal.controller.getAssociationDoctorList.isEmpty&&modal.controller.showNoData.value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 15,),
                          itemCount: modal.controller.getAssociationDoctorList.length,
                          itemBuilder:(BuildContext context, int index){
                            AssociationDoctorModal associationDoctor =
                            modal.controller.getAssociationDoctorList[index];
                            return CustomInkwell(onPress:(){
                              String? trimmedLatitude = associationDoctor.lat?.substring(0, 7);
                              String? trimmedLongitude = associationDoctor.long?.substring(0, 7);
                              App().navigate(context,  AssociationDoctorClinicMap(latitude: trimmedLatitude, longitude:trimmedLongitude));
                            },elevation: 3,borderRadius: 10,shadowColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      Container(
                                        width: 3,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color:getRandomColor(),
                                        ),),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(associationDoctor.name.toString(),overflow: TextOverflow.visible,style: MyTextTheme().mediumBCB,maxLines: 2),
                                              Text(associationDoctor.address.toString(),overflow: TextOverflow.ellipsis,style: MyTextTheme().mediumGCB,maxLines: 2)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                      ),
                    ),
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}
