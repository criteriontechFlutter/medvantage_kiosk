import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class AddInvestigationController extends GetxController{

  Rx<TextEditingController> pathologyC = TextEditingController().obs;
  Rx<TextEditingController> receiptC = TextEditingController().obs;
  Rx<TextEditingController> testDateC = TextEditingController().obs;
  Rx<TextEditingController> testNameC = TextEditingController().obs;
  Rx<TextEditingController> valueC = TextEditingController().obs;
  Rx<TextEditingController> unitC = TextEditingController().obs;
  Rx<TextEditingController> remarkC = TextEditingController().obs;
  final formKey = GlobalKey<FormState>().obs;
  RxString testID = ''.obs;
  RxString unitID = ''.obs;
List abc = [];
  List addedTestList = [].obs;
  get getAddedTestList => addedTestList;

  List searchedTest=[].obs;
  List get getSearchedTest=>searchedTest;
  set updateSearchedTest(List val){
    searchedTest=val;
    update();
  }

  void onTapTest(Map val){
    testNameC.value.text=val['name'].toString();
    testID.value=(val['id']).toString();
    getSearchedTest.clear();
    update();
  }

  List searchedUnit=[].obs;

  List get getSearchedUnit=>unitC.value.text==''?searchedUnit:searchedUnit.where((element) =>
          (
              element['name'].toString().toLowerCase()
          ).trim().contains(unitC.value.text.toLowerCase().trim())
      ).toList();

  set updateSearchedUnit(List val){
    searchedUnit=val;
    update();
  }

  void onTapUnit(Map val){
    unitC.value.text=val['name'].toString();
    unitID.value=(val['id']??'0').toString();
    searchedUnit.clear();
    update();
  }

  File? image;
  File? get getProfile => image;
  set updateProfile(File img){
    image = img;
    update();
  }

  List files =[].obs;
  get getFiles => files;
}