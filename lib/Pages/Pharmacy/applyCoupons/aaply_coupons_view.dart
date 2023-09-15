import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'DataModal/apply_coupons_data_modal.dart';
import 'apply_coupons_controller.dart';
import 'apply_coupons_modal.dart';

class ApplyCoupons extends StatefulWidget {
  const ApplyCoupons({Key? key}) : super(key: key);

  @override
  _ApplyCouponsState createState() => _ApplyCouponsState();
}

class _ApplyCouponsState extends State<ApplyCoupons> {
  ApplyCouponsModal modal=ApplyCouponsModal();
  //CartListModal cartmodal = CartListModal();
  @override
  void initState(){
    super.initState();
    get();

  }
  get()async{
    await modal.getCoupons(context);
  }

  @override
  void dispose(){
    super.dispose();
    Get.delete<ApplyCouponsController>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBackground,
      appBar: MyWidget().pharmacyAppBar(context,title:"Apply Coupons",),
      body:GetBuilder(
        init: ApplyCouponsController(),
        builder: (_){
          return  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,children: [
                MyTextField2(controller: modal.controller.searchC.value
                ,hintText: "Enter Coupon Code",
                  suffixIcon:TextButton(onPressed: null,child: Text("Apply",style: MyTextTheme().smallSCN,)),
               ),
                const SizedBox(height: 10,),
                Text("Available Coupons",style: MyTextTheme().mediumGCB,),
                const SizedBox(height: 10,),

                Center(
                    child: CommonWidgets().showNoData(
                      title: 'No Coupons Available',
                      show: (modal.controller.getShowNoData && modal.controller.getApplyCoupon.isEmpty),
                      loaderTitle: 'Loading Coupons',
                      showLoader: (!modal.controller.getShowNoData && modal.controller.getApplyCoupon.isEmpty),
                        //showLoader: (modal.controller.getShowNoData && modal.controller.getApplyCoupon.isNotEmpty),
                      child:
                      SizedBox(height:MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          itemCount:modal.controller.getApplyCoupon.length,
                          //modal.controller.coupons.length,
                          itemBuilder:(BuildContext context,int index){
                            ApplyCouponsDataModal coupons=modal.controller.getApplyCoupon[index];
                            return Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      //Text(modal.controller.coupons[index]['title'].toString()),
                                      // Text(coupons.id.toString()),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.lightBackground,
                                              borderRadius: BorderRadius.circular(5)
                                          )
                                          ,child: Padding(
                                        padding:  EdgeInsets.all(3.0),
                                        child:  GestureDetector(
                                          child: new CustomToolTip(text: coupons.couponCode.toString()),
                                          onTap: () {

                                          },
                                        ),

                                      )),
                                      const Spacer(),
                                      InkWell(
                                      onTap: (){
                                        //cartmodal.validateCoupon(context);
                                      }
                                      ,child: Text("Apply",style: MyTextTheme().smallSCB,))
                                    ]),

                                    Text(coupons.description.toString(),style: MyTextTheme().smallGCN,),
                                    Text("valid from "+coupons.validityFrom.toString()+" till "+coupons.validityTo.toString()),

                                    // Text("More Details",style: MyTextTheme().smallSCB)
                                  ],
                                ),
                              ),);
                          },
                          separatorBuilder: (BuildContext context,int index){
                            return const SizedBox(height: 10,);
                          }, ),
                      )
                    )
                ),

             SizedBox(height: 10,),

              ]),
            ),
          );
        },
      )
    );
  }
}

class CustomToolTip extends StatefulWidget {

  String text;

  CustomToolTip({Key? key, required this.text}) : super(key: key);

  @override
  State<CustomToolTip> createState() => _CustomToolTipState();
}

class _CustomToolTipState extends State<CustomToolTip> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Tooltip(preferBelow: false,
          message: "Copy", child: new Text(widget.text)),
      onTap: () {
        Clipboard.setData(new ClipboardData(text: widget.text));
      },
    );
  }
}