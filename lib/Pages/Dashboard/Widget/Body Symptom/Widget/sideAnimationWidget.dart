import 'package:digi_doctor/Pages/Dashboard/Widget/Body%20Symptom/Widget/select_body_part_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../symptomCheckerController.dart';
import '../symptomCheckerModal.dart';

class SideAnimationPart extends StatefulWidget {
  final BodyPart selectedBodyPart;
  final List bodyPartList;
  final bool reversePosition;
  final Function(BodyPart val,String id) onTapBodyPart;

  const SideAnimationPart({Key? key,
    required this.selectedBodyPart,
    required this.onTapBodyPart,
    required this.bodyPartList,
    this.reversePosition=false,
  }) : super(key: key);

  @override
  State<SideAnimationPart> createState() => _SideAnimationPartState();
}

class _SideAnimationPartState extends State<SideAnimationPart> {

  SymptomCheckerModal modal=SymptomCheckerModal();
  @override
  void dispose() {
    super.dispose();

  }
  String bodyPartId = "";
  @override
  Widget build(BuildContext context) {
    return
      widget.bodyPartList.isEmpty? Container():
      AnimatedPositioned(
        top: 0,
        bottom: 0,
        left: widget.reversePosition? 0:widget.selectedBodyPart!=BodyPart.notSelected?-240:-Get.width * 1.5,//500
        right: !widget.reversePosition? 0:widget.selectedBodyPart!=BodyPart.notSelected?-240:-Get.width * 1.5,

        duration:const Duration(milliseconds: 500),
        child: Center(
            child:
            GetBuilder(
              init: SymptomCheckerController(),
              builder: (_) {
                return SizedBox(
                  width: 80,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.bodyPartList.length,
                      itemBuilder: (BuildContext context, int index){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            (widget.bodyPartList[index]['organImagePath']!=null&&widget.bodyPartList[index]['organImagePath']!='')? InkWell(
                              onTap: ()async{
                                bodyPartId = widget.bodyPartList[index]['id'].toString();
                                modal.controller.updateSelectSymptomId = widget.bodyPartList[index]['id'].toString();
                                print("######"+modal.controller.getSelectSymptomId.toString());
                              },
                              child:bodyPartId ==   widget.bodyPartList[index]['id'].toString()?
                              Image.asset("assets/symptoms_image/${ widget.bodyPartList[index]['organImagePath'].toString()}Red.png",scale: 3,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return const SizedBox();
                                },):
                              Image.asset("assets/symptoms_image/${ widget.bodyPartList[index]['organImagePath'].toString()}.png",scale: 3,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return const SizedBox();
                                },),
                            ):const SizedBox(),
                            const SizedBox(height: 5,),

                          ],
                        );
                      }),
                );
              },
            )
        ),
      );
  }


}
