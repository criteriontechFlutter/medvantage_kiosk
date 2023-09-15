import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AddInvestigationController extends GetxController{
  Rx<TextEditingController> pathologyC = TextEditingController().obs;
  Rx<TextEditingController> receiptC=TextEditingController().obs;
  Rx<TextEditingController> testDateC=TextEditingController().obs;
  Rx<TextEditingController> testNameC=TextEditingController().obs;
  Rx<TextEditingController> valueC=TextEditingController().obs;
  Rx<TextEditingController>unitC=TextEditingController().obs;
  Rx<TextEditingController>remarkC=TextEditingController().obs;
  final formKey=GlobalKey<FormState>().obs;
}