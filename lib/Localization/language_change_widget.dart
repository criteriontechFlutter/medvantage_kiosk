


import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_localization.dart';

class LanguageChangeWidget extends StatelessWidget {
  final isPopScreen;
  const LanguageChangeWidget({Key? key, this.isPopScreen=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return      Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/translate.png',height: 25,width: 30),
        const SizedBox(width: 10,),
        DropdownButton<Language>(
          style:  MyTextTheme().mediumBCB,
          borderRadius: BorderRadius.circular(10),
          value: localization.getLanguage,
          elevation: 0,
          underline: Container(),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: localization.listOfLanguages.map((Language items) {
            return DropdownMenuItem(
              value: items,
              child: Text(getLanguageInRealLanguage(items).toString()),
            );
          }).toList(),

          onChanged: (Language? newValue) {

            if(newValue!=null){
              localization.updateLanguage(
                  newValue
              );
              UserData().addLanguage(newValue.toString());
              print("logo"+newValue.toString());
              if(isPopScreen){
                Navigator.pop(context);
              }
            }

          },
        ),
      ],
    );
  }
}
