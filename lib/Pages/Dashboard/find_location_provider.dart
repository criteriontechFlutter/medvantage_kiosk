


import 'package:flutter/cupertino.dart';

import '../../SignalR/raw_data_83.dart';
import '../VitalPage/LiveVital/stetho_master/AppManager/raw_api.dart';
import 'locationDataModal.dart';

class LocationProvider extends ChangeNotifier{

  var dropdownValue='select';
  getAllDepartments()async{
    var data = await RawData83().getapi('/api/DepartmentMaster/GetAllDepartmentMaster',{});
    print(data);
   updateDepList= data['responseValue'];
    // for(int i = 0;i<=getDep.length-1;i++){
    //   nameList.add((getDep[i]['departmentName']).toString()+'+id${getDep[i]['id']}');
    //   print(nameList.toString()+'1234567890');
    // }
    print('${data}2345');
  }

  //
  // List nameList=[];
  // List   get getname=>nameList;
  // set updateNameList(val){
  //   nameList=val;
  //   notifyListeners();
  // }
  List departmentList=[];
  List   get getDep=>departmentList;
  set updateDepList(val){
    departmentList=val;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {    notifyListeners();
    });

  }
   getLocation({required String id})async{
     var data = await RawData().getapi('/api/LocationDepartmentAssign/GetAllLocationDepartmentAssignByDeptId?deptid=$id',{});
     updateLocations=data['responseValue'];
     print('${data}09090909090909099');
   }

  List locations=[];
  get getLocations=>locations;
  set updateLocations(val){
    locations=val;
    notifyListeners();
  }



}