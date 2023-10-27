
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ecg_view.dart';
import 'history.dart';

class AllDevicesView extends StatefulWidget {
  const AllDevicesView({Key? key}) : super(key: key);

  @override
  State<AllDevicesView> createState() => _AllDevicesViewState();
}

class _AllDevicesViewState extends State<AllDevicesView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Lead II ECG"),
          ),

          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // ECG electrodes image
               Padding(
                 padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                 child: Container(
                   height: 200,
                   child: Image.asset('assets/electrodes.jpg', fit: BoxFit.fill,),
                 ),
               ),

                // About electrodes connecting detail
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Connect the electrodes as shown in the figure above",
                  style: TextStyle(fontSize: 16),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Start test button
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Container(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Get.to(ECGView());
                          },
                          icon: Icon(Icons.play_arrow, size: 26, color: Colors.white),
                          label: Text("Start Test",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            fixedSize: Size(150, 50),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    // History button
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Container(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Get.to(ReportHistory());
                          },
                          icon: Icon(Icons.history, size: 26, color: Colors.white),
                          label: Text("History",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            fixedSize: Size(150, 50),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}