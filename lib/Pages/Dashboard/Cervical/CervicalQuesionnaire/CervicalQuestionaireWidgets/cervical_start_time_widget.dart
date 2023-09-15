import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:flutter/material.dart';

class CervicalStartTimeWidget extends StatelessWidget {
  const CervicalStartTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_ , index) => const SizedBox(height: 15,),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Start Time:",style: MyTextTheme().largeBCB.copyWith(color: Colors.grey),),
                Text("Thu, Nov 10, 4:32 pm",style: MyTextTheme().largeBCB,),
                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Expanded(child: MyButton(title: 'Just Now',color: Colors.grey,)),
                    SizedBox(width: 10,),
                    Expanded(child: MyButton(title: '1h ago',)),
                    SizedBox(width: 10,),
                    Expanded(child: MyButton(title: 'Self',)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
