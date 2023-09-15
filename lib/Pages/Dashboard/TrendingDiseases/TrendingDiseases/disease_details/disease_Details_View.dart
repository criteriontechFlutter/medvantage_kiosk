

import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/MyCustomSD.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../trending_disease_data_modal.dart';
import '../trending_disease_modal.dart';
import 'disease_Details_Controller.dart';
import 'disease_Details_DataModal.dart';
import 'disease_Details_Modal.dart';



class DiseaseDetails extends StatefulWidget {
  final String index;

  const DiseaseDetails({Key? key, required this.index}) : super(key: key);

  @override
  State<DiseaseDetails> createState() => _DiseaseDetailsState();
}

class _DiseaseDetailsState extends State<DiseaseDetails> {
  //ScrollController _controller = ScrollController();
  ItemScrollController _scrollController1 = ItemScrollController();

  DiseaseDetailsModal modal = DiseaseDetailsModal();
  TrendingDiseaseListModal disease_Modal = TrendingDiseaseListModal();

  var justifyText = TextAlign.justify;

  bool showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    get();
  }


  get() async {
    await modal.getDepartmentId(context,widget.index.toString());
    await modal.diseaseDetails(context, widget.index);
  }

  @override
  void dispose() {
    Get.delete<DiseaseDetailsController>();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController1.scrollTo(
        index: 0, duration: const Duration(milliseconds: 500));
  }


  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.diseaseDiseases.toString()),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.grey.withOpacity(0.1),
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 40,
              color: AppColor.bgColor,
            ),
            onPressed: () {
              _scrollToTop();
            },
          ),
          body:
          GetBuilder(
              init: DiseaseDetailsController(),
              builder: (_) {
                return Center(
                  child: CommonWidgets().showNoData(
                    title: 'Data Not Found',
                    show: (modal.controller.getShowNoData &&
                        modal.controller.getMedicineDetailsList.isEmpty),
                    loaderTitle: 'Loading...',
                    showLoader: (!modal.controller.getShowNoData &&
                        modal.controller.getMedicineDetailsList.isEmpty),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                          child: MyCustomSD(
                              borderColor: AppColor.greyLight,
                              initialValue: [
                                {
                                  "parameter": 'departmentName',
                                  "value": modal.controller.departmentList.isNotEmpty?
                                  modal.controller.departmentList[0]['departmentName'].toString():''
                                }
                              ],
                              listToSearch: modal.controller.departmentList,
                              valFrom: 'departmentName',
                              hideSearch: true,
                              onChanged: (val){
                                if(val!=null){
                                  modal.controller.updateDepartmentID=val['departmentId'];
                                  print(modal.controller.getDepartmentID.toString());
                                  modal.diseaseDetails(context, widget.index);
                                  modal.controller.update();
                                }
                              }),
                        ),
                        Expanded(
                          child: ScrollablePositionedList.builder(
                              itemScrollController: _scrollController1,
                              //controller:  _controller,
                              scrollDirection: Axis.vertical,
                              itemCount: modal.controller.getMedicineDetailsList.length,
                              itemBuilder: (context, index3) {
                                DiseaseDetailsDataModal modalData =
                                modal.controller.getMedicineDetailsList[index3];
                                TrendingDiseaseDataModal medicineData = disease_Modal.controller.getTrendingDiseaseList[index3];
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                index3 == 0
                                                    ? Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                    4,
                                                    0,
                                                    0,
                                                    2,
                                                  ),
                                                  child: Text(
                                                    medicineData.problemName
                                                        .toString(),
                                                    style:
                                                    MyTextTheme().mediumBCB,
                                                  ),
                                                )
                                                    : const SizedBox(),
                                                //index3 == 0?SizedBox(height: 2,):SizedBox(),
                                                index3 == 0
                                                    ? Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      4, 0, 0, 8),
                                                  child: Text(
                                                    'Know your medicine for better treatment',
                                                    style:
                                                    MyTextTheme().mediumBCN,
                                                  ),
                                                )
                                                    : const SizedBox(),
                                                Wrap(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/${modalData.heading}.svg",
                                                      height: 20,
                                                      width: 20,
                                                      color: Colors.blue,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      modalData.heading.toString(),
                                                      style: MyTextTheme()
                                                          .mediumBCB
                                                          .copyWith(
                                                          color: Colors.blue),
                                                    ),

                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                _getWidgetAccordingToType(modalData),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                        child: Visibility(
                                          visible: index3 == 0 ? true : false,
                                          child: Wrap(
                                            children: List.generate(
                                                modal
                                                    .controller
                                                    .getMedicineDetailsList
                                                    .length, (index2) {
                                              return InkWell(
                                                onTap: () {
                                                  _scrollController1.scrollTo(
                                                      index: index2,
                                                      duration: const Duration(
                                                          milliseconds: 500));
                                                },
                                                child: modal
                                                    .controller
                                                    .getMedicineDetailsList[
                                                index2]
                                                    .heading
                                                    .toString() ==
                                                    "Overview"
                                                    ? const Text("")
                                                    : Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      3, 4, 4, 3),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColor.primaryColor,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                    ),
                                                    child: RichText(
                                                        text:
                                                        TextSpan(children: [
                                                          WidgetSpan(
                                                              child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      8,
                                                                      0,
                                                                      2,
                                                                      3),
                                                                  child:
                                                                  SvgPicture.asset(
                                                                    "assets/${modal
                                                                            .controller
                                                                            .getMedicineDetailsList[
                                                                        index2]
                                                                            .heading}.svg",
                                                                    height: 20,
                                                                    width: 20,
                                                                    color: Colors
                                                                        .white,
                                                                  ))),
                                                          WidgetSpan(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    3, 5, 5, 7),
                                                                child: Text(
                                                                  modal
                                                                      .controller
                                                                      .getMedicineDetailsList[
                                                                  index2]
                                                                      .heading
                                                                      .toString(),
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                  style: MyTextTheme()
                                                                      .smallWCB,
                                                                ),
                                                              )),
                                                        ])),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _getWidgetAccordingToType(DiseaseDetailsDataModal medicine) {
    var data = medicine.body;

    if (data is List) {
      switch (int.parse(medicine.headingId.toString())) {
        case 11:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate((data).length, (index) {
              var newData = (data)[index];

              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 2, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   newData['text'].toString(),
                    //   style: MyTextTheme().smallBCN,
                    // ),
                    Html(data:newData['value'].toString()),
                    const SizedBox(height: 5,),
                    // Text('Sub Overview:',style: MyTextTheme().smallBCB,),

                    Column(
                      children: List.generate(medicine.subOverview!.length, (index2){
                        var overview=medicine.subOverview![index2];
                        return Column(
                          children: [
                            Column(
                              children: List.generate(overview.subOverview!.length, (index){
                                var subOverview=overview.subOverview![index];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: Html(data:subOverview.subOverview.toString()))
                                    ],
                                  ),
                                );
                              }),
                            )
                          ],
                        );
                      }),
                    )
                  ],
                ),
              );
            }),
          );

        case 13:
          List<ClinicalFeaturesDataModal> clinicalFeatures =
          List<ClinicalFeaturesDataModal>.from((data).map(
                  (element) => ClinicalFeaturesDataModal.fromJson(element)));
          return Column(
            children: List.generate(clinicalFeatures.length, (index) {
              var newData = clinicalFeatures[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newData.inputType.toString(),
                    style: MyTextTheme().smallRCB,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Column(
                      children:
                      List.generate(newData.concern!.length, (index2) {
                        return Column(
                          children: List.generate(
                              newData.concern![index2].data!.length, (index3) {
                            var concern =
                            newData.concern![index2].data![index3];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:15),
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: AppColor.black,
                                  ),
                                ),
                                Expanded(
                                    child: Html(data:concern.problemName.toString(),)),
                              ],
                            );
                          }),
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
          );

        case 14:
          List<DiagnosticsDataModal> diagnostics =
          List<DiagnosticsDataModal>.from((data).map(
                  (element) => DiagnosticsDataModal.fromJson(element)));
          return Column(
            children: List.generate(diagnostics.length, (index) {
              var newData = diagnostics[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newData.type.toString(),
                    style: MyTextTheme().smallBCB,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Column(
                      children:
                      List.generate(newData.investigation!.length, (index2) {
                        return
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Test",style: MyTextTheme().smallBCN),
                                  Text("Result",style: MyTextTheme().smallBCN)
                                ],
                              ),
                              Divider(
                                color: AppColor.greyLight,
                                thickness: 0.5,
                              ),
                              Column(
                                children: List.generate(
                                    newData.investigation![index2].data!.length, (index3) {
                                  var diagnosticData = newData.investigation![index2].data![index3];
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,10,0,2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text(diagnosticData.subTestName.toString(),style: MyTextTheme().smallBCN)),
                                            Expanded(child: Text(diagnosticData.remarkValue.toString(),style: MyTextTheme().smallBCN)),
                                          ],
                                        ),
                                      )
                                    ],
                                  );

                                }),
                              ),
                            ],
                          );
                      }),
                    ),
                  ),
                ],
              );
            }),
          );

        case 15:
          List<TreatmentDataModal> treatment =
          List<TreatmentDataModal>.from((data).map(
                  (element) => TreatmentDataModal.fromJson(element)));
          return Column(
            children: [
              Column(
                children: List.generate(treatment.length, (index) {
                  var newData = treatment[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          newData.subHeading.toString(),
                          style: MyTextTheme().smallRCB,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
                        child: Column(
                          children:
                          List.generate(newData.data!.length, (index2) {
                            return
                              Column(
                                children: List.generate(
                                    newData.data![index2].treatmentType!.length, (index3) {
                                  var treatmentData = newData.data![index2].treatmentType![index3];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(treatmentData.treatmentType!.length, (index4) =>
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0,right: 8),
                                          child: InkWell(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0,4,5,0),
                                                  child: CircleAvatar(
                                                    radius: 2,
                                                    backgroundColor: AppColor.black,
                                                  ),
                                                ),
                                                Expanded(child: Text(treatmentData.treatmentType![index4].medName.toString(),style: MyTextTheme().smallBCN,)),
                                                Icon(Icons.info_outline_rounded,color: AppColor.primaryColor,size: 18,)

                                              ],
                                            ),
                                            onTap: (){
                                              // App().navigate(context, MedicineDetails(index: index4,));
                                            },
                                          ),
                                        ),
                                    ),
                                  );


                                }),
                              );

                          }),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              Column(
                  children: List.generate(medicine.treatment!.length, (index5) {
                    return
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,10,0,6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Html(data:medicine.treatment![index5].treatmentName.toString(),),
                            Html(data:medicine.treatment![index5].treatment.toString(),),
                          ],
                        ),
                      );
                  }
                  )
              ),
            ],
          );

        case 17:
          List<PrecautionDataModal> precaution =
          List<PrecautionDataModal>.from((data).map(
                  (element) => PrecautionDataModal.fromJson(element)));
          return Column(
              children: List.generate(precaution.length, (index) {
                var newData = precaution[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newData.subHeading.toString(),
                      style: MyTextTheme().smallRCB,
                    ),
                    const SizedBox(height: 8,),
                    Column(
                        children: List.generate(newData.data!.length, (index2) {
                          return Column(
                              children: List.generate(newData.data![index2].precautionType!.length, (index3){
                                var preData = newData.data![index2].precautionType![index3];
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15,4,5,0),
                                          child: CircleAvatar(
                                            radius: 2,
                                            backgroundColor: AppColor.black,
                                          ),
                                        ),
                                        Expanded(child: Text(preData.precautionType.toString(),style: MyTextTheme().smallBCN,))
                                      ],
                                    )
                                  ],
                                );
                              })
                          );
                        })
                    )
                  ],
                );
              })
          );

        case 18:
          List<ConcernsDataModal> concerns =
          List<ConcernsDataModal>.from((data).map(
                  (element) => ConcernsDataModal.fromJson(element)));
          return Column(
            children: List.generate(concerns.length, (index) {
              var newData = concerns[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newData.subHeading.toString(),
                    style: MyTextTheme().smallRCB,
                  ),
                  const SizedBox(height: 8,),
                  Column(
                    children:
                    List.generate(newData.data!.length, (index2) {
                      return
                        Column(
                          children: List.generate(
                              newData.data![index2].precautionType!.length, (index3) {
                            var concernsData = newData.data![index2].precautionType![index3];
                            List<String> dataList = concernsData.concernType.toString().split(',');
                            return Column(
                              children: List.generate(dataList.length, (index4) =>

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(15,4,5,0),
                                        child: CircleAvatar(
                                          radius: 2,
                                          backgroundColor: AppColor.black,
                                        ),
                                      ),
                                      Expanded(child: Text(dataList[index4].toString(),style: MyTextTheme().smallBCN,))
                                    ],
                                  )
                              ),
                            );

                          }),

                        );
                    }),
                  ),
                ],
              );
            }),
          );

        case 20:
          List<DietDataModal> diet =
          List<DietDataModal>.from((data).map(
                  (element) => DietDataModal.fromJson(element)));
          return Column(
            children: List.generate(diet.length, (index) {
              var newData = diet[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newData.departmentName.toString(),
                    style: MyTextTheme().smallBCB,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
                    child: Column(
                      children:
                      List.generate(newData.provisionalDiet!.length, (index2) {
                        var provisionalDiet=newData.provisionalDiet![index2];
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,4,5,0),
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: AppColor.black,
                                  ),
                                ),
                                Expanded(child: Text(provisionalDiet.provisionalDiet.toString(),style: MyTextTheme().smallBCN,))
                              ],
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
          );
        case 21:
          List<RelatedDiseaseDataModal> relatedDisease =
          List<RelatedDiseaseDataModal>.from((data).map(
                  (element) => RelatedDiseaseDataModal.fromJson(element)));
          return Column(
            children: List.generate(relatedDisease.length, (index) {
              var newData = relatedDisease[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   newData.departmentName.toString(),
                  //   style: MyTextTheme().smallBCB,
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
                    child: Column(
                      children:
                      List.generate(newData.differentialDiagnosis!.length, (index2) {
                        var relatedDieaseData=newData.differentialDiagnosis![index2];
                        return Column(
                            children: List.generate(relatedDieaseData.differentialDiagnosis!.length, (index3) {
                              var problem=relatedDieaseData.differentialDiagnosis![index3];
                              return
                                Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,10,5,0),
                                          child: CircleAvatar(
                                            radius: 2,
                                            backgroundColor: AppColor.black,
                                          ),
                                        ),
                                        Expanded(child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(problem.problemName.toString(),style: MyTextTheme().smallBCN,),
                                        ))
                                      ],
                                    )
                                  ],
                                );
                            }

                            )
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
          );
        case 28:
          List<PathophysiologyDataModal> pathophysiology =
          List<PathophysiologyDataModal>.from((data).map(
                  (element) => PathophysiologyDataModal.fromJson(element)));
          return Column(
            children: List.generate(pathophysiology.length, (index) {
              var newData = pathophysiology[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   newData.departmentName.toString(),
                  //   style: MyTextTheme().smallBCB,
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
                    child: Column(
                      children:
                      List.generate(newData.pathophysiology!.length, (index2) {
                        var pathophysiologyData=newData.pathophysiology![index2];
                        return Column(
                          children: [
                            Html(data:pathophysiologyData.pathophysiology.toString())
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
          );

        case 29:
          List<MetabolicPathwayDataModal> Metabolic =
          List<MetabolicPathwayDataModal>.from((data).map(
                  (element) => MetabolicPathwayDataModal.fromJson(element)));
          return Column(
            children: List.generate(Metabolic.length, (index) {
              var newData = Metabolic[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newData.subHeading.toString(),
                    style: MyTextTheme().smallBCB,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
                    child: Column(
                      children:
                      List.generate(newData.data!.length, (index2) {
                        return
                          Column(
                            children: List.generate(
                                (newData.data![index2].metabolicPathway?? []).length, (index3) {
                              var metabolicData = newData.data![index2].metabolicPathway![index3];
                              return Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 5),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Metabolism Name",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.metabolismName.toString(),style: MyTextTheme().smallBCN,),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Cycle",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.cycleName.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Metabolitic",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.metabolismName.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Tissue",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.tissue.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Bio- Fluid",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.biofluids.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Cell Location",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.cellLocation.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Inheritance",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.inheretance.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Prevalence",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.prevalence.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Fate",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.fate.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Feeder",style: MyTextTheme().mediumRCB,),
                                                Text(metabolicData.feeder.toString(),style: MyTextTheme().smallBCN,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20,),

                                      Text("Description",style: MyTextTheme().mediumRCB,),
                                      const SizedBox(height: 5,),
                                      Text(metabolicData.disorderDescription.toString(),style: MyTextTheme().smallBCN),
                                      const SizedBox(height: 20,),
                                      Text("Test",style: MyTextTheme().mediumRCB,),
                                      Text(metabolicData.testDetails.toString(),style: MyTextTheme().smallBCN)
                                    ],
                                  )
                              );

                            }),

                          );
                      }),
                    ),
                  ),
                ],
              );
            }),
          );
        case 30:
          List<EpidemiologyDataModal> epidemiology =
          List<EpidemiologyDataModal>.from((data).map(
                  (element) => EpidemiologyDataModal.fromJson(element)));
          return Column(
            children: List.generate(epidemiology.length, (index) {
              var newData = epidemiology[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newData.subHeading.toString(),
                    style: MyTextTheme().smallBCB,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
                    child: Column(
                      children:
                      List.generate(newData.data!.length, (index2) {
                        return
                          Column(
                            children: List.generate(
                                (newData.data![index2].prognosis?? []).length, (index3) {
                              var epidemiologyData = newData.data![index2].prognosis![index3];
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,4,5,0),
                                        child: CircleAvatar(
                                          radius: 2,
                                          backgroundColor: AppColor.black,
                                        ),
                                      ),
                                      Expanded(child: Text(epidemiologyData.prognosis.toString(),style: MyTextTheme().smallBCN,))
                                    ],
                                  )

                                ],
                              );

                            }),

                          );
                      }),
                    ),
                  ),
                ],
              );
            }),
          );
        default:
          return Container();
      }
    } else if (data is String) {
      return Html(data: data.toString());
    } else {
      return Container();
    }
  }
}
