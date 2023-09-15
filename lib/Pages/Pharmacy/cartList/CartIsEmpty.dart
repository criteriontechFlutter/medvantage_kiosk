

import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/cupertino.dart';

class CartIsEmpty extends StatefulWidget {
  const CartIsEmpty({Key? key}) : super(key: key);

  @override
  State<CartIsEmpty> createState() => _CartIsEmptyState();
}

class _CartIsEmptyState extends State<CartIsEmpty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration:  BoxDecoration(
          color: AppColor.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Your cart is empty',style: MyTextTheme().largeBCB,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40.0),
              child: Center(child: Text('There is nothing in your bag.Lets add some itemsThere is nothing in your bag.Lets add some',style: MyTextTheme().mediumCCN,)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.orangeButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Text('Add',style: MyTextTheme().largeWCB,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
