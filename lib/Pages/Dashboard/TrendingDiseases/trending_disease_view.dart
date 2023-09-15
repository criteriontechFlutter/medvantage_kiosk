


import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Dashboard/TrendingDiseases/TrendingDiseases/disease_details/disease_Details_View.dart';
import 'package:digi_doctor/Pages/Dashboard/TrendingDiseases/TrendingDiseases/trending_disease_data_modal.dart';
import 'package:digi_doctor/Pages/Dashboard/TrendingDiseases/TrendingDiseases/trending_disease_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../../../AppManager/widgets/MyTextField.dart';
import '../../../../AppManager/widgets/common_widgets.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';


class TrendingDiseasesView extends StatefulWidget {

  const TrendingDiseasesView({Key? key,}) : super(key: key);

  @override
  State<TrendingDiseasesView> createState() => _TrendingDiseasesViewState();
}

class _TrendingDiseasesViewState extends State<TrendingDiseasesView> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
  }

  get() async {
    await modal.getTrendingDiseaseList(context);
  }

  final rnd = math.Random();
  Color getRandomColor() => Color(rnd.nextInt(0xffffffff)).withAlpha(0xff);

  TrendingDiseaseListModal modal =  TrendingDiseaseListModal();

  @override
  Widget build(BuildContext context)  {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.trendingDiseases.toString()),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,0),
                child: MyTextField(hintText:localization.getLocaleData.search,
                  controller: modal.controller.searchDiseaseC,
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
                      show:modal.controller.getTrendingDiseaseList.isEmpty&&modal.controller.showNoData.value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                        child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 15,),
                            itemCount: modal.controller.getTrendingDiseaseList.length,
                            itemBuilder:(BuildContext context, int index){
                              TrendingDiseaseDataModal trendingDisease =
                              modal.controller.getTrendingDiseaseList[index];
                              return CustomInkwell(onPress:(){
                                App().navigate(context, DiseaseDetails(index: trendingDisease.problemId.toString(),));
                              },elevation: 3,borderRadius: 10,shadowColor: Colors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                children: [
                                    const SizedBox(width: 8,),
                                    Container(
                                      width: 3,
                                      height: 50,
                                      decoration: BoxDecoration(
                                      color:getRandomColor(),
                                    ),),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(trendingDisease.problemName.toString(),overflow: TextOverflow.visible,style: MyTextTheme().mediumBCB,maxLines: 2),
                                            trendingDisease.diseaseDefinition == ""?
                                            Text("NA",maxLines: 1,style: MyTextTheme().smallBCN,):
                                                Text(trendingDisease.diseaseDefinition.toString(),overflow: TextOverflow.ellipsis,style: MyTextTheme().mediumGCB,maxLines: 1)
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
        ),
      ),
    );
  }
}
