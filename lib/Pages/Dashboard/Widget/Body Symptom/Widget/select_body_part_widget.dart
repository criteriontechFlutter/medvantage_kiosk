




import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../AppManager/my_text_theme.dart';
import '../symptomCheckerModal.dart';

class SelectBodyPartWidget extends StatefulWidget {


  final BodyPart selectedBodyPart;
  int activeStep;
  final Function(BodyPart val,String id) onTapBodyPart;

  SelectBodyPartWidget({Key? key,
    this.selectedBodyPart=BodyPart.notSelected,
    required this.onTapBodyPart,
    required this.activeStep
  }) : super(key: key);

  @override
  State<SelectBodyPartWidget> createState() => _SelectBodyPartWidgetState();
}

class _SelectBodyPartWidgetState extends State<SelectBodyPartWidget> {
  SymptomCheckerModal modal=SymptomCheckerModal();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:  Stack(
        alignment: Alignment.topCenter,
        children: [
          // Positioned(
          //   top: 90,
          //   bottom: 122,
          //   child: Container(
          //     padding: const EdgeInsets.fromLTRB(120,0,120,0),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         border: Border.all(color: Colors.grey.shade400)
          //     ),
          //   ),
          // ),


          _SelectBodyPartImage(
            selectedBodyPart: widget.selectedBodyPart,
          ),
          Positioned(
            // bottom: 100,
            top: 0,

            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              child: Column(
                children: [
                  Text('Select',style: MyTextTheme().largeBCB.copyWith(color: Colors.indigo.shade900),),
                  Text('Body Part',style: MyTextTheme().largeBCN.copyWith(color: Colors.indigo.shade900),),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 70,
              child: Column(
                children: [
                  Text('Select the part of body in which',style: MyTextTheme().smallBCN.copyWith(color: Colors.indigo.shade900),),
                  Text('you have problem',style: MyTextTheme().smallBCN.copyWith(color: Colors.indigo.shade900),),
                ],
              )),



          Positioned(top: 0,bottom:0,left:0,right:0, child:
          Padding(
            padding: const EdgeInsets.fromLTRB(125,65,125,180),
            child: Column(children: [
              Expanded(
                  flex: 2,
                  child: Row(
                children: [
                  Expanded(
                    flex:5,
                      child: Container()),
                  Expanded(child: InkWell(
                    onTap: (){
                      widget.onTapBodyPart(BodyPart.head,'1');
                    },
                    child: Container(decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.transparent,width: 2)
                    ),
                    ),
                  )),
                  Expanded(
                    flex: 5,
                      child: Container()),
                ],
              )),
              Expanded(flex: 5,
                  child: Row(
                children: [
                  Expanded(
                    flex:11,
                      child: Container()),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        widget.onTapBodyPart(BodyPart.leftHand,'4');
                      },
                      child: Container(decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.transparent,width: 2)
                      ),),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: (){
                              widget.onTapBodyPart(BodyPart.chest,'2');
                            },
                            child: Container(decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.transparent,width: 2)
                            ),),
                          ),
                        ),Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: (){
                              widget.onTapBodyPart(BodyPart.stomach,'3');
                            },
                            child: Container(decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.transparent,width: 2)
                            ),),
                          ),
                        ),Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        widget.onTapBodyPart(BodyPart.rightHand,'4');
                      },
                      child: Container(decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.transparent,width: 2)
                      ),),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                      child: Container())
                ],
              )),
              Expanded(flex: 6,child: Row(
                children: [
                  Expanded(
                    flex:7,
                    child: Container(),
                  ),Expanded(
                    child: InkWell(
                      onTap: (){
                        widget.onTapBodyPart(BodyPart.leftLeg,'5');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.transparent,width: 2)
                      ),
                      ),
                    ),
                  ),Expanded(
                    child: InkWell(
                      onTap: (){
                        widget.onTapBodyPart(BodyPart.rightLeg,'5');
                      },
                      child: Container(decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.transparent,width: 2)
                      ),),
                    ),
                  ),Expanded(
                    flex: 7,
                    child: Container(),
                  ),

                ],
              )),
            ],),
          )),


          const SizedBox(height:40,
              //child:StepperWidget(activeStep: widget.activeStep,)
          ),
        ],
      ),

    );
  }
}




enum BodyPart{
  notSelected,
  head,
  leftHand,
  rightHand,
  stomach,
  chest,
  leftLeg,
  rightLeg
}




class _SelectBodyPartImage extends StatelessWidget {
  final BodyPart selectedBodyPart;

  const _SelectBodyPartImage({Key? key, required this.selectedBodyPart}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    String currentBodyPartImage(){

      switch (selectedBodyPart){
        case BodyPart.head: return "anim_head.png";
        case BodyPart.leftHand: return "anim_left-hand.png";
        case BodyPart.chest: return "anim_chest.png";
        case BodyPart.stomach: return "anim_stomach.png";
        case BodyPart.rightHand: return "anim_right-hand.png";
        case BodyPart.leftLeg: return "anim_left_leg.png";
        case BodyPart.rightLeg: return "anim_right_leg.png";
        default: return "anim_image.png";
      }
    }

    return Padding(
      padding: const EdgeInsets.only(
          top: 65
      ),
      child: Image.asset('assets/'+currentBodyPartImage().toString(),scale: 3,),
    );
  }
}

