import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderDetails/order_details_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

reviewAndRating(context){
  OrderDetailsModal modal=OrderDetailsModal();
  modal.controller.clearData();
  AlertDialogue().show(context,showCancelButton: true,newWidget: [
    Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.clear,
                  )),
            ],
          ),
          Image.asset("assets/rating2.png",height: 150,),
          Text("Rate your experience with us!"),

          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              modal.controller.ratingData.value= rating.toInt();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyTextField2(hintText: "Write a review",
              controller: modal.controller.ratingController.value,
              validator: (val){
                if(val!.isEmpty){
                  return "Please write review";
                }
              },
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyButton2(title: "Continue",onPress: (){
              //modal.controller.updateProductInfoCode = ProductDetailsDataModal().productInfoCode!;
              //ordered.orderDetailsId!;
              OrderDetailsModal().productRating(context);
            },),
          )
        ])]);
}