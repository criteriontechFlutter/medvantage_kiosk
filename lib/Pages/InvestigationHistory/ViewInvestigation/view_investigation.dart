import 'package:cached_network_image/cached_network_image.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../AppManager/ImageView.dart';
import '../../../../AppManager/app_util.dart';
import '../DataModal/investigation_history_data_modal.dart';


class ViewInvestigation extends StatefulWidget {
  final int index;
  final List<InvestigationDetails> investigation;
  final List<FilePath> filePath;
  final String hospitalName, date, receipt;


  const ViewInvestigation(
      {Key? key,
      required this.index,
      required this.hospitalName,
      required this.date,
      required this.receipt,
        required this.investigation, required this.filePath,
      })
      : super(key: key);

  @override
  State<ViewInvestigation> createState() => _ViewInvestigationState();
}

class _ViewInvestigationState extends State<ViewInvestigation> {


  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.bgColor,
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.investigation.toString()),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  decoration:   BoxDecoration(
                    color:
            AppColor.primaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColor.bgColor,
                          child: Center(
                            child: SizedBox(
                              height: 37,
                              child:
                                  SvgPicture.asset('assets/investigation.svg'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.hospitalName.toString(),
                              style: MyTextTheme().mediumWCB,
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              widget.date.toString(),
                              style: MyTextTheme().smallWCB,
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              localization.getLocaleData.rNo.toString()+widget.receipt.toString(),
                              style: MyTextTheme().smallWCB,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView.separated(
                        itemCount:widget.investigation.isNotEmpty? widget.investigation.length:widget.filePath.length,//controller.getInvestigationData[widget.index].investigation!.length,
                        separatorBuilder: (context, index2) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index2) =>widget.investigation.isNotEmpty? Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 15, 10, 12),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 22,
                                          backgroundColor: AppColor.bgColor,
                                          child: Center(
                                            child: Text(widget.investigation[index2].testDetails![0].subTestName!.substring(0, 1).toUpperCase().toString(),textAlign: TextAlign.center,style: MyTextTheme().largeWCB.copyWith(color: Colors.deepPurpleAccent),),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.investigation[index2].testDetails![0].subTestName.toString(),
                                                style: MyTextTheme().mediumBCB,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    localization.getLocaleData.testValue.toString(),
                                                    style: MyTextTheme()
                                                        .smallBCN
                                                  ),
                                                  Text(
                                                      localization.getLocaleData.unit.toString(),
                                                      style: MyTextTheme()
                                                          .smallBCN
                                                  ),
                                                  //Text(widget.investigation[index2].testDetails![0].unitName.toString(),style: MyTextTheme().smallBCN.copyWith(color:Colors.teal))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(widget.investigation[index2].testDetails![0].testValue.toString(),style: MyTextTheme().smallBCN.copyWith(color:Colors.teal),),
                                                  Text(widget.investigation[index2].testDetails![0].unitName.toString(),style: MyTextTheme().smallBCN.copyWith(color:Colors.teal))
                                                ],
                                              ),
                                              const SizedBox(height: 8,),
                                              Text(localization.getLocaleData.remark.toString()),
                                              Text(widget.investigation[index2].testDetails![0].testRemarks.toString())
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ):
                        CachedNetworkImage(
                            placeholder:
                                (context, url) =>
                            const Center(
                              child:
                              CircularProgressIndicator(),
                            ),
                            imageBuilder: (context,
                                imageProvider) =>
                                InkWell(
                                  onTap: (){
                                    App().navigate(context, ImageView(url: widget.filePath[index2].filePath.toString(),));
                                  },
                                  child: Container(
                                    height: 200,
                                    decoration:
                                    BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: Colors
                                              .brown),
                                      image: DecorationImage(
                                          image:
                                          imageProvider,
                                          fit: BoxFit
                                              .fill),
                                    ),
                                  ),
                                ),
                            imageUrl:
                            widget.filePath[index2].filePath.toString(),
                            errorWidget: (context,
                                url, error) =>
                            const Image(
                                image: AssetImage(
                                    'assets/noProfileImage.png')))
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
