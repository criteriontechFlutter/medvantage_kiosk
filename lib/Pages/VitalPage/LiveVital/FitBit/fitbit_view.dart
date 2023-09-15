



import 'package:flutter/material.dart';
import 'package:helix_timex/helix_timex.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../Localization/app_localization.dart';
import 'fitbit_modal.dart';

class FitBitView extends StatefulWidget {
   final String code;
  const FitBitView({Key? key, required this.code}) : super(key: key);

  @override
  State<FitBitView> createState() => _FitBitViewState();
}

class _FitBitViewState extends State<FitBitView> {
  FitBitModal modal=FitBitModal();

  get(){
    modal.controller.updateCode=widget.code.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
    setState(() {

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    var size=MediaQuery.of(context).size.height;

    return Container(
      child: SafeArea(
        child: Scaffold(

            appBar: MyWidget().myAppBar(context,
                title: localization.getLocaleData.bloodPressure.toString(),
                action: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow:  [
                            BoxShadow(
                              color: (20==TimexConnectionState.connected)? Colors.green: Colors.red,
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                              offset: const Offset(
                                0.0,
                                3.0,
                              ),
                            ),
                          ]),
                      child: InkWell(
                        onTap: (){
                          FitBitModal().getHeartRate(context);
                        },
                        child: const SizedBox(
                          height: 60,
                          child: Image(
                            image: AssetImage('assets/helix_black.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          body:  Padding(
            padding:  EdgeInsets.all(size/20),
            child: Stack(
              children: [
                Container(

                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      border: Border.all(color: AppColor.black,
                          width: 3),
                      boxShadow:  [
                        BoxShadow(
                          color: (10==TimexConnectionState.connected)? Colors.blue: Colors.white,
                          blurRadius: 6.0,
                          spreadRadius: 0.0,
                          offset: const Offset(
                            0.0,
                            6.0,
                          ),
                        ),
                      ]
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,0,),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border.all(color: AppColor.black,
                                  width: 3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [

                                  // spo2==""?
                                  // Expanded(
                                  //   child: Center(
                                  //     child: Text('Connect Device For Data',
                                  //       textAlign: TextAlign.center,
                                  //       style: MyTextTheme().mediumWCB,),
                                  //   ),
                                  // )
                                  //     :
                                  Expanded(
                                    child: Column(
                                      children: [

                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(localization.getLocaleData.spO2.toString(),
                                                  style: MyTextTheme().mediumWCB.copyWith(
                                                  ),),

                                                // modal.controller.readingData.value=='sp'? measuring()
                                               'sp'=='sp'? measuring()
                                                    :Text(20.toString()+' %',
                                                  style: MyTextTheme().mediumWCB.copyWith(
                                                      fontSize: 50
                                                  ),),
                                                  // :Text(modal.controller.spo2.value.toString()+' %',
                                                  // style: MyTextTheme().mediumWCB.copyWith(
                                                  //     fontSize: 50
                                                  // ),),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,

                                              children: [

                                                Text(localization.getLocaleData.heartRate.toString(),
                                                  style: MyTextTheme().mediumWCB.copyWith(
                                                  ),),

                                                Wrap(
                                                  alignment: WrapAlignment.center,
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children: [

                                                    Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: SizedBox(
                                                          height: 20,
                                                          child: Lottie.asset('assets/heart.json')),
                                                    ),
                                                    // modal.controller.readingData.value=='hr'?measuring()
                                                    //     :Text(modal.controller.heartRate.value.toString()+' bpm',
                                                    //   style: MyTextTheme().mediumWCB.copyWith(
                                                    //       fontSize: 30
                                                    //   ),),
                                                   'hr'=='hr'?measuring()
                                                        :Text( localization.getLocaleData.bpm.toString(),
                                                      style: MyTextTheme().mediumWCB.copyWith(
                                                          fontSize: 30
                                                      ),),

                                                    Container(
                                                      width: 25,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),



                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0,0,0,10),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(localization.getLocaleData.sBP.toString(),
                                                        style: MyTextTheme().mediumWCB.copyWith(
                                                        ),),
                                                      // modal.controller.readingData.value=='bp'?Expanded(child: measuring())
                                                      //     :Text( modal.controller.sis.value.toString()+' MM',
                                                      //   style: MyTextTheme().mediumWCB.copyWith(
                                                      //       fontSize: 15
                                                      //   ),),
                                                     'bp'=='bp'?Expanded(child: measuring())
                                                          :Text( localization.getLocaleData.mm.toString(),
                                                        style: MyTextTheme().mediumWCB.copyWith(
                                                            fontSize: 15
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(localization.getLocaleData.dBP.toString(),
                                                        style: MyTextTheme().mediumWCB.copyWith(
                                                        ),),
                                                      // modal.controller.readingData.value=='bp'?Expanded(child: measuring())
                                                      //     :Text(modal.controller.dis.value.toString()+' HG',
                                                      //   style: MyTextTheme().mediumWCB.copyWith(
                                                      //       fontSize: 15
                                                      //   ),),
                                                      'bp'=='bp'?Expanded(child: measuring())
                                                          :Text(localization.getLocaleData.hg.toString().toString()+localization.getLocaleData.hg.toString(),
                                                        style: MyTextTheme().mediumWCB.copyWith(
                                                            fontSize: 15
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),




                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow:  const [
                                    BoxShadow(
                                      // color: (modal.controller.conState.value==TimexConnectionState.connected)? Colors.blue: Colors.black,
                                      color: (20==TimexConnectionState.connected)? Colors.blue: Colors.black,
                                      blurRadius: 6.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(
                                        0.0,
                                        3.0,
                                      ),
                                    ),
                                  ]),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(Icons.bluetooth,
                                      color: Colors.white,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,20),
                        child: Column(
                          children: [
                            Text(localization.getLocaleData.criterionTech.toString(),
                              style: MyTextTheme().mediumWCB,),
                            const SizedBox(height: 5,),
                            Text(localization.getLocaleData.fitBit.toString(),
                              style: MyTextTheme().mediumWCB,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Visibility(
                  // visible: modal.controller.conState.value==TimexConnectionState.connected,
                  visible:'1'=='1',
                  child:    Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: modal.controller.readingData.value!=''? measuring() :Visibility(
                          child: '1'!=''? measuring() :Visibility(
                            // visible: modal.controller.selectedTimePeriod.value!='Repeat',
                            visible: '1'!='Repeat',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(localization.getLocaleData.next.toString(),
                                  style: MyTextTheme().mediumWCB,),
                                // Text(DateFormat('hh:mm a').format(modal.controller.nextMeasure.value).toString(),
                                //   style: MyTextTheme().mediumWCB,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Wrap(
                      //   crossAxisAlignment: WrapCrossAlignment.center,
                      //   alignment: WrapAlignment.center,
                      //   children: [
                      //
                      //     // SizedBox(
                      //     //   width: 100,
                      //     //   child: MyCustomSD(
                      //     //     // labelStyle: MyTextTheme().mediumWCN,
                      //     //     // decoration: BoxDecoration(
                      //     //     //     borderRadius: BorderRadius.circular(5),
                      //     //     //     color: Colors.black,
                      //     //     //     border: Border.all(color: Colors.black)
                      //     //     // ),
                      //     //
                      //     //       initialValue: [
                      //     //         {
                      //     //           'parameter': 'title',
                      //     //           'value': modal.controller.selectedTimePeriod.value,
                      //     //         }
                      //     //       ],
                      //     //       hideSearch: true,
                      //     //       height: 200,
                      //     //       label: 'Duration',
                      //     //       listToSearch: modal.controller.timePeriodList, valFrom: 'title', onChanged: (val){
                      //     //     if(val!=null){
                      //     //       modal.controller.updateSelectedTimePeriod(val['title']);
                      //     //     }
                      //     //   }),
                      //     // ),
                      //   ],
                      // ),

                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
  Widget measuring(){
    return SizedBox(
        height: 50,
        child: Lottie.asset('assets/pulse_white.json'));
  }
}
