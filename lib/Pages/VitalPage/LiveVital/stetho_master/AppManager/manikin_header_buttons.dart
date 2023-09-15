
import 'package:flutter/material.dart';

import 'app_color.dart';

class MyCustomHeaderButton extends StatefulWidget {
 final Function? secondButtonOnTap;
 final Function? firstButtonOnTap;
 final IconData ? secondButtonIcon;
 final Color ? secondButtonBackgroundColor;
 final bool ? showSecondButton;
  const MyCustomHeaderButton({Key? key, this.secondButtonOnTap, this.firstButtonOnTap , this.secondButtonIcon, this.secondButtonBackgroundColor, this.showSecondButton }) : super(key: key);

  @override
  State<MyCustomHeaderButton> createState() => _MyCustomHeaderButtonState();
}

class _MyCustomHeaderButtonState extends State<MyCustomHeaderButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 25,
              width: 40,
              decoration: BoxDecoration(
                color: AppColor.proPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: InkWell(
                    onTap: () {
                       widget.firstButtonOnTap!();
                    },
                    child: Icon(Icons.arrow_back_ios , color: Colors.white,)
                ),
              ),
            ),
            Visibility(
              visible: widget.showSecondButton ?? true,
              child: Container(
                height: 25,
                width: 40,
                decoration: BoxDecoration(
                  color: widget.secondButtonBackgroundColor ?? Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:0),
                  child: InkWell(
                      onTap: (){
                        widget.secondButtonOnTap!();
                      },
                      child: Icon(widget.secondButtonIcon, color: Colors.white,)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
