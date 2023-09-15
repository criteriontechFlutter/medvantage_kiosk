import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import 'DataModal/diagnostic_labs_data_modal.dart';
import 'diagnostic_labs_controller.dart';
import 'diagnostic_labs_modal.dart';

class DiagnosticLabs extends StatefulWidget {
  const DiagnosticLabs({Key? key}) : super(key: key);

  @override
  _DiagnosticLabsState createState() => _DiagnosticLabsState();
}

class _DiagnosticLabsState extends State<DiagnosticLabs> {
  DiagnosticLabsModal modal=DiagnosticLabsModal();

  @override
  void initState() {
    // TODO: implement initState
    get();
    super.initState();
  }
  get()async{
    await modal.getAllLabs(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColor.lightBackground,
      appBar: MyWidget().myAppBar(context,title: "Diagnostic Labs"),
      body:GetBuilder(
        init: DiagnosticLabController(),
        builder: (_){
          return  Column(children: [
            Expanded(
              child: ListView.separated( itemCount:modal.diagnosticLabController.getDiagnosticLabs.length,
                itemBuilder:(BuildContext context,int index){
                DiagnosticLabsDataModal diagnosticLabs=modal.diagnosticLabController.getDiagnosticLabs[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12,12, 12,0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),color: AppColor.white
                    ),child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(imageUrl: diagnosticLabs.logo.toString(),height: 35,
                              errorWidget: (context,url,error)=>Image.asset("assets/logo.png"),
                              ),
                              const Spacer(),
                              SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                              Text("1500",
                                  style: TextStyle(decoration: TextDecoration.lineThrough,color: AppColor.greyDark)),
                            const Text("  26% off")
                            ],
                          ),
                      Row(
                        children: [
                          Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(diagnosticLabs.pathologyName.toString(),
                                style: MyTextTheme().mediumBCB.copyWith(fontWeight: FontWeight.w400),),
                              Text("Home Collection",  style: TextStyle(
                                decoration: TextDecoration.underline,color: AppColor.red
                              ),),
                            ],
                          ),
                          const Spacer(),
                          SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                          Text("1100",
                              style:MyTextTheme().largeBCB),
                        ],
                      ),


                      Row(
                        children: [
                          SvgPicture.asset("assets/chemistry.svg"),
                          const SizedBox(width: 10,),
                          Text("Vitamin Dificiency Health Checkup",style: MyTextTheme().mediumBCB.copyWith(fontWeight: FontWeight.w300),),
                        ],
                      ),
                      const Text("Total 5 tests")
                      // Html(data:widget)
                  ]),
                    ),),
                );
              },
                  separatorBuilder:(BuildContext context,int index){
                    return const SizedBox(height: 1,);
                  },
                //modal.controller.getPackageDetails.length
              ),
            )
          ]);
        },
      )
    );
  }
}
