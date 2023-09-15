import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/widgets/MyTextField.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../Localization/app_localization.dart';
import '../DataModal/dashboard_data_modal.dart';
import '../Hospital/hospital_view.dart';

class TopClinicsView extends StatefulWidget {


  const TopClinicsView({Key? key,}) : super(key: key);

  @override
  State<TopClinicsView> createState() => _TopClinicsViewState();
}

class _TopClinicsViewState extends State<TopClinicsView> {


  DashboardController controller = Get.find();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.searchTopClinics.value.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
        color:AppColor.primaryColor,
        child: SafeArea(
          child: Scaffold(
            appBar: MyWidget().myAppBar(
              context,
              title: localization.getLocaleData.topClinics.toString(),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 15),
                  child: MyTextField(hintText:localization.getLocaleData.search,
                    controller: controller.searchTopClinics.value,
                    suffixIcon: const Icon(Icons.search,),
                    onChanged: (val){
                      controller.update();
                    },
                  ),
                ),
                GetBuilder<DashboardController>(
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 15),
                        child: CommonWidgets().showNoData(
                          show: controller.getTopClinics.isEmpty,
                          title: "No clinics found",
                          child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 12,
                            children: List.generate(controller.getTopClinics.length, (index) {
                              TopClinicDataModal details = controller.getTopClinics[index];
                              return CustomInkwell(
                                onPress: (){
                                  App().navigate(
                                      context,
                                      Hospital(
                                        hospitalDetails: details,
                                      ));
                                },
                                borderRadius: 10,elevation: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Center(
                                      child: CachedNetworkImage(
                                        imageUrl: details.profilePhotoPath.toString(),
                                        placeholder: (context, url) => Image.asset(
                                          'assets/logo.png',
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(
                                          'assets/logo.png',
                                        ),
                                        height: 60,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            details.name.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: MyTextTheme().smallBCB,
                                          ),
                                          // Text(
                                          //   details.cityName.toString(),
                                          //   style: MyTextTheme()
                                          //       .smallBCN,
                                          // ),
                                          Text(
                                            details.address.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: MyTextTheme().smallBCN,
                                          ),
                                          Text(
                                            details.cityName.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: MyTextTheme().smallBCN,
                                          ),
                                          Text(
                                            details.stateName.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: MyTextTheme().smallBCN,
                                          ),
                                          // Text(
                                          //   details..toString(),
                                          //   style: MyTextTheme()
                                          //       .smallBCN,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ));
  }
}
