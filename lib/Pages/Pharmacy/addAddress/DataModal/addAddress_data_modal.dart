import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
class AddressFields {
  String ?lableName;
  String? hintText;
  Icon? icon;
  TextEditingController? controller;


  AddressFields(
      {
        this.lableName,
         this.hintText,
         this.icon,
         this.controller
      });

  factory AddressFields.fromJson(Map json) => AddressFields(
    lableName: json['lableName']??'',
    hintText: json['hintText']??'',
    icon: json[Icon]??const Icon(Icons.person),
    controller: json["controller"]??""
  );

  Map<String, dynamic> toJson() => {
    'lableName': lableName,
    'hintText': hintText,
    'Icon': icon,
    'controller':controller,
  };
  final formKey = GlobalKey<FormState>().obs;
 static List<AddressFields> allFields=[

    AddressFields(
      lableName: "Full Name",
      hintText: "Your full name",
      icon: const Icon(Icons.person),
      controller:TextEditingController()
    ),
    AddressFields(
      lableName: "Mobile No.",
      hintText: "Enter Mobile No.",
      icon: const Icon(Icons.phone_android),
        controller:TextEditingController()

    ),

    AddressFields(
      lableName: "House No.",
      hintText: "Your House No.",
      icon: const Icon(Icons.location_on),
        controller:TextEditingController()

    ),

   AddressFields(
       lableName: "Area",
       hintText: "Your Area",
       icon:const Icon(Icons.email_outlined),
       controller:TextEditingController()

   ),
   AddressFields(
       lableName: "Pin Code",
       hintText: "Enter Pin Code",
       icon: const Icon(Icons.event_note_sharp),
       controller:TextEditingController()

   ),
   AddressFields(
      lableName: "State",
      hintText: "Your State",
      icon: const Icon(Icons.home),
      controller: TextEditingController()
    ),


    AddressFields(
      lableName: "City",
      hintText: "Your City",
      icon: const Icon(Icons.api),
        controller:TextEditingController()
      //profileImage: "https://picsum.photos/200/300?random=1"
    ),
   AddressFields(
       lableName: "Locality",
       hintText: "Enter Locality",
       icon: const Icon(Icons.event_note_sharp),
       controller:TextEditingController()

   ),
   AddressFields(
       lableName: "Home/Office",
       hintText: "Enter Address Type",
       icon: const Icon(Icons.local_post_office),
       controller:TextEditingController()

   ),




 ];





}