import 'dart:async';
import 'dart:math';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<double> abc = [
    10.0,
    12.0,
    15.0,
    14.0,
    10.0,
    90.0,
    50.0,
    100.0,
    10.0,
    12.0,
    15.0,
    14.0,
    10.0,
    90.0,
    50.0,
    100.0,
    100.0,
    10.0,
    12.0,
    15.0,
    14.0,
    10.0,
    90.0,
    50.0,
    100.0
  ];

  List<double> abcn = [
    10.0,
    12.0,
    15.0,
    14.0,
    10.0,
    90.0,
    50.0,
    100.0,
    10.0,
    12.0,
    15.0,
    14.0,
    10.0,
    90.0,
    50.0,
    100.0
  ];

  Random random = new Random();

  addData(index, val) {
    setState(() {
      abc[index] = double.parse(val.toString());
    });
  }

  int index = 0;

  int count = 0;

  onPressedfbtn() {

    double t=0;
    double n=0;
    double v=0;

    for(int i=0;i<abc.length;i++){
      if(t<abc[i] && n<abc[i]){
        setState(() {
          t=abc[i];
        });
      }
      else if(n>abc[i] && v<abc[i]){
        setState(() {
          n=abc[i];
        });
      }
      else if(v>abc[i]){
        setState(() {
          v=abc[i];
        });
      }
    }








    if (index < 25) {
      setState(() {
        index += 1;
      });
    } else {
      setState(() {
        index = 0;
      });
    }

    setState(() {
      int randomNumber = random.nextInt(100);
      count = randomNumber;
    });

    addData(index, count);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // verticalDirection: VerticalDirection.down,
          children: [
            Text(abc.join(', ').toString()),

            AppBar(shadowColor: Colors.white,toolbarTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                bottomOpacity: 10,systemOverlayStyle: SystemUiOverlayStyle.dark,),

             

            // SizedBox(
            //   height: 150,
            //   child: Sparkline(
            //     data: [],
            //     lineWidth: 2,
            //     gridLineAmount: 10,
            //     enableGridLines: true,
            //     gridLineColor: Colors.black,
            //     pointIndex: index,
            //     pointColor: Colors.blue,
            //     pointSize: 4,
            //     pointsMode: PointsMode.atIndex,
            //     useCubicSmoothing: true,
            //     fillMode: FillMode.none,
            //     // averageLine: true,
            //   ),
            // ),
            // AboutDialog(applicationIcon: Icon(Icons.add)),
            // Autocomplete(optionsBuilder: optionsBuilder),
            // BackButton(),
            // BottomAppBar(child: Icon(Icons.add),),
            // ColoredBox(color: Colors.blue,child: Text('n')),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Timer.periodic(const Duration(seconds: 1), (Timer t) {
            onPressedfbtn();
            // });
          });
        },
      ),
    ));
  }
}
