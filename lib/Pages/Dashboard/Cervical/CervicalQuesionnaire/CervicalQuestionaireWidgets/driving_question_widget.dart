import 'package:flutter/material.dart';

import '../../../../../AppManager/app_color.dart';
import '../../../../../AppManager/my_text_theme.dart';
import '../../../../../AppManager/widgets/customInkWell.dart';

class DrivingQuestionWidget extends StatelessWidget {
  final List question;
  final Function isChecked;
  const DrivingQuestionWidget({Key? key, required this.question, required this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: question.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10,),
        itemBuilder: (context, index) {
          return CustomInkwell(
            color: question[index]["isChecked"]?AppColor.primaryColor.withOpacity(0.05):Colors.white,
            borderRadius: 10,
            onPress: (){
              isChecked(index,!question[index]["isChecked"]);
              //question[index]["isChecked"]=;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(question[index]["question"],style: MyTextTheme().mediumBCB,),
                  // Checkbox(
                  //   checkColor: Colors.white,
                  //   //fillColor: MaterialStateProperty.resolveWith(getColor),
                  //   value: question[index]["isChecked"],
                  //   shape: const CircleBorder(),
                  //   onChanged: (bool? value) {
                  //    // isChecked(index,value);
                  //   },
                  // )
                   !question[index]["isChecked"]?const Icon(Icons.circle_outlined,color: Colors.grey,):const Icon(Icons.check_circle_rounded,color:Colors.lightBlue,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
