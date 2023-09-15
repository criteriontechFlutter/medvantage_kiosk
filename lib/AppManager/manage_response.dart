


import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:flutter/material.dart';

import 'api_response.dart';
import 'my_text_theme.dart';



class ManageResponse extends StatelessWidget {


  final ApiResponse response;
  final Widget child;
  final Function? onPressRetry;
  final String? retry;


  const ManageResponse({Key? key, required this.response,
    required this.child,
    this.onPressRetry, this.retry,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return getWidgetAccordingToResponse();
  }


  Widget getWidgetAccordingToResponse() {
    switch (response.status) {
      case Status.loading:
        return  Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                Text(response.message.toString(),
                  style: MyTextTheme().mediumBCB,),
              ],
            ),
          ),
        );
      case Status.completed:
        return child;
      case Status.error:
        return _retryWidget() ;

      case Status.empty:
        return _retryWidget() ;
      case Status.initial:
      default:
        return  Container();
    }
  }



  _retryWidget(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            response.status==Status.empty?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(response.message.toString(),style: MyTextTheme().mediumGCB,),
                )
              ],
            )
            :Text(response.message.toString(),
              textAlign: TextAlign.center,
              style: MyTextTheme().mediumGCB,),
            onPressRetry==null? Container():Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton2(
                width: 65,
                  height: 20,
                  onPress: (){
                  }, title: retry??"RETRY"),
            )
          ],
        ),
      ),
    );
  }

}
