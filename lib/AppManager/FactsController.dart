// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:his/AppManager/my_text_theme.dart';
//
// class FactsCount extends GetxController {
//   final facts = GetStorage();
//
//
//   List get getFacts => facts.read('facts') ?? [];
//   String get getRandomFact => getFacts.isEmpty? '': getFacts[getFactsCount]['String'];
//   int get getFactsCount => facts.read('factsCount') ?? 0;
//
//
//   updateFactCount() async{
//     int val=getFactsCount;
//     val=(val==(getFacts.length-1))? 0:(val+1);
//     await facts.write('factsCount',val);
//     update();
//   }
//
//
//   updateFacts(List val) async{
//     await facts.write('facts',val);
//     update();
//   }
//
//
//
// }
//
//
//
//
// factsDialogue(){
//
//   return  Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Container(
//       decoration: BoxDecoration(
//           color: Colors.black26,
//           borderRadius: BorderRadius.all(Radius.circular(5))
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(FactsCount().getRandomFact,
//             style: MyTextTheme().mediumWCB),
//       ),
//     ),
//   );
// }
