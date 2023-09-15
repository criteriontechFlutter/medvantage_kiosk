import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderSummary/OrderSummaryModal.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../AppManager/widgets/my_app_bar.dart';
import '../cartList/cartListModal.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late Razorpay razorpay;
  TextEditingController myController=TextEditingController();
  OrderSummaryModal modal = OrderSummaryModal();
  CartListModal cartListModal = CartListModal();
 // CartListController controller = Get.put(CartListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay=Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }
//*******
  void openCheckout() async{
    var options={
      "key":"rzp_test_ZuepJZ0pus1Nuf",
      "amount":num.parse(cartListModal.controller.getPriceDetails.totalAmount.toString())*100,
    'name':modal.controller.getAddress[0].name.toString(),
    'description':"Payment for the random",
    'prefill':{'contact':modal.controller.getAddress[0].mobileNo.toString(),
    'email':'test@razorpay.com'
    },
    "external":{
        "wallets":["paytm"]
    },};
      try{
        razorpay.open(options);
    }
    catch(e){
        print((e.toString()));
    }

    }

//anshu.
  void handlerPaymentSuccess(){
    print("Payment success");
    alertToast(context,"Payment success");
    //App().navigate(context,PharmacyDashboard());

  }

  void handlerErrorFailure(){
    print("Payment error");
    alertToast(context,"Payment error");

  }

  void handlerExternalWallet(){
    print("External Wallet");
    alertToast(context,"External Wallet");

  }
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          MyWidget().pharmacyAppBar(context,title: "Checkout Payment",),
          Container(decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(20, 20),
                bottomRight: Radius.elliptical(20, 20),
              ),
              color: AppColor.pharmacyPrimaryColor
          ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15,5,15,0),
                child: Column(children: [
                  Divider(color: AppColor.white,thickness: 1,),
                  Text("Total Pay",style: MyTextTheme().mediumWCN,),
                  Text('\u{20B9}  '+cartListModal.controller.getPriceDetails.totalAmount.toString()+
                      "  Only",style: MyTextTheme().mediumWCB,),
                  const SizedBox(height: 20,)
                ],),
              )
          ),


          MyButton2(title: "Paynow", width: 80,
          onPress: (){
           openCheckout();
          // PharmacyDashboard();
          },
          )
        ],
      ),
    );
  }
  }

// import 'package:flutter/material.dart';
//
// class PaymentAmount extends StatefulWidget {
//   const PaymentAmount({Key? key}) : super(key: key);
//
//   @override
//   _PaymentAmountState createState() => _PaymentAmountState();
// }
//
// class _PaymentAmountState extends State<PaymentAmount> {
//   late Razorpay razorpay;
//   TextEditingController myController=new TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     razorpay=new Razorpay();
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     razorpay.clear();
//   }
//
//   void openCheckout() async{
//     var options={
//       "key":"rzp_test_ZuepJZ0pus1Nuf",
//       "amount":myController.text,
//       'name':'Sample App',
//       'description':"Payment for the random",
//       'prefill':{'contact':'7845784589',
//         'email':'test@razorpay.com'
//       },
//       "external":{
//         "wallets":["paytm"]
//       },};
//     try{
//       razorpay.open(options);
//     } catch(e){
//       print((e.toString()));
//     }
//
//   }
// }
//
//
// void handlerPaymentSuccess(){
//   print("Payment success");
//
// }
//
// void handlerErrorFailure(){
//   print("Payment erro");
//
// }
//
// void handlerExternalWallet(){
//   print("External Wallet");
//
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:Text("Payment example")
//       ),
//       body: Column(
//         children: [
//
//         ],
//       ),
//     );
//   }
// }
