

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Localization/app_localization.dart';
import 'alert_dialogue.dart';
import 'app_color.dart';
import 'my_text_theme.dart';

// Live URL

    //Knowmed BaseUrl
String knowmedBaseUrl='http://182.156.200.179:332/api/v1.0/';

String baseUrl='http://52.172.134.222:205/api/v1.0/';
String hisBaseUrl='http://182.156.200.179:201/api/';

// Local URL
// String baseUrl='http://182.156.200.178:8085/api/v1.0/';
// String hisBaseUrl='http://182.156.200.178:229/api/';


// d0q0VW53iEN7l1X_uBFIDH:APA91bH9gonnJ2U9h6obqtxOJTvlqQRvw6Ms2bNVKHAnjgrSqG_rWScbAhTYCn20z2LC8ex6q2uhNDODHKGFAslbVkpQzbD2fRdY8szvGdgS1IR9UEgmph-CGDq5ryiVA8ZIQ3XGqdhj


String eraBaseUrl='http://182.156.200.179:201/API/';
String supplementUrl='http://52.172.134.222:204/';


String secretMapKey='AIzaSyB0AW2vBqSKJPqegh75EhUUxPljXPhaxqU';


String errorText='Field must not be empty';

String startBookingTime = '';
bool onBackApiCall = false;

UserData user=UserData();

var cancelResponse={'status': 0, 'message': 'Try Again...'};

class App
{

  api(url,body,context,{
  token,
    isNewUrl,
    newBaseUrl,
    raw,
  })
  async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context, listen: false);
    try{
      print(baseUrl+url);
      print(body.toString());
   if(token=true){
     print(user.getUserToken.toString());
   }
   else{
     print('Token False');
   }
   var fullUrl=isNewUrl==true? newBaseUrl+url:baseUrl+url;
   print(fullUrl);
      String username = 'H!\$\$erV!Ce';
      String password = '0785C700-B96C-44DA-A3A7-AD76C58A9FBC';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print('-------------------------$basicAuth');
      var response = (token?? false)?    await http.post(
          Uri.parse(fullUrl),
          headers: {'authorization': basicAuth},
          // headers: {
      // HttpHeaders.authorizationHeader:
      // 'accessToken': 'A4E3CD96ACBD455DB199F512AD1CA27C',
      //       'userID': user.getUserId.toString()
      //     },
          body: body
      ):await http.post(
          Uri.parse(fullUrl),
          body: body,
          headers: {'authorization': basicAuth}
        // headers: <String, String>{
        //   'x-access-token': user.getUserToken.toString(),
        //   'userID': user.getUserId.toString()
        // },
      );
      var  data = await json.decode(response.body);

      print(data);

      if(data is String){
        if(data==localization.getLocaleData.alertToast?.youAreLoggedOut || data==localization.getLocaleData.alertToast?.unauthorisedUser){
          Navigator.popUntil(context, ModalRoute.withName('/DashboardView'));
          await user.removeUserData();
          alertToast(context, data.toString());
        }
        else{
          var newData={
            'status': 0,
            'message': data,
          };
          print(newData.toString());
          return newData;
        }

       // return newData;
      }
      else{
        data['responseCode']=response.statusCode;
        print(data.toString());
        if(data['status']==0 && (data['message']== localization.getLocaleData.alertToast?.invalidToken || data['message']==localization.getLocaleData.alertToast?.unauthorisedUser) ){
            Navigator.popUntil(context, ModalRoute.withName('/DashboardView'));

            await user.removeUserData();
            //replaceNavigate(context, LoginPageView());
            alertToast(context, data['message']);
        }
        else{
          print('dddddddddddd');
          return data;
        }

      }

    }
    on SocketException {
      print('No Internet connection');
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.internetConnectionIssue,
      );
      if(retry){
        var data= await api(url,body,context,
            token: token);
        return data;
      }
      else{
        return cancelResponse;
      }

    }
    on TimeoutException catch (e) {
      print('Time Out '+e.toString());
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.timeOutConnection,
      );
      if(retry){
        var data= await api(url,body,context,
            token: token,);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
    catch (e) {
      print('Error in Api: $e');
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.errorOccur,
      );
      if(retry){
        var data= await api(url,body,context,
            token: token);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
  }


  // navigate(context,route) async{
  //
  //   var data = await Routes.navigate(route);
  //
  //   // var data=await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)
  //   // {
  //   //   return route;
  //   // }));
  //   //     .then((val) async {
  //   //   //print("************"+val.toString());
  //   //   if(onBackApiCall){
  //   //     print("thennnnnnnn");
  //   //      Position locationData = await MapModal().getCurrentLocation(context);
  //   //      await DashboardModal().getLocation(context);
  //   //      await DashboardModal().getDashboardData(context, locationData);
  //   //     onBackApiCall = false;
  //   //   }
  //   //
  //   // });
  //   return data;
  // }

  navigate(context,route,) async{
    var data=await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)
    {
      return route;
    }));
    //     .then((val) async {
    //   //print("************"+val.toString());
    //   if(onBackApiCall){
    //     print("thennnnnnnn");
    //      Position locationData = await MapModal().getCurrentLocation(context);
    //      await DashboardModal().getLocation(context);
    //      await DashboardModal().getDashboardData(context, locationData);
    //     onBackApiCall = false;
    //   }
    //
    // });
    return data;
  }

  replaceNavigate(context,route,{
    String? routeName
  }) async{
    var data=await Navigator.pushReplacement(context, MaterialPageRoute(
        settings: routeName!=null? RouteSettings(name: routeName): null,
        builder: (BuildContext context)
    {
      return route;
    }));
    return data;
  }

  navigateTransparent(context,route) async{
    var data=await Navigator.push(context, PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return route;
        },
      transitionsBuilder: (context, a1, a2, widget) {
        return widget;
      },
      transitionDuration: const Duration(milliseconds: 200),
        )
    );
    return data;
  }




}





class MultiPart {

  multipart(String filePath,String imagePathName) async{
    print(filePath);
    return  await MultipartFile.fromFile(filePath);
  }


  api(url,body,context,{
    imagePath,imagePathName,
  })
  async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    // dio.options.contentType= Headers.formUrlEncodedContentType;
    try{
      print(baseUrl+url);
      print(body);
      print(user.getUserToken);
      var headers = {
        'accessToken': user.getUserToken
      };
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl+url));
      request.fields.addAll(body);
      request.files.add(await http.MultipartFile.fromPath(imagePathName,imagePath));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      print(response.toString());
      var data={
        'status':  response.statusCode==200? 1: 0,
        'data': await response.stream.bytesToString(),
      };
      print(data);
      return  data;


    }
    on SocketException {
      print('No Internet connection');
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.internetConnectionIssue,
      );
      if(retry){
        var data= await api(url,body,context,
          imagePath: imagePath,
        );
        return data;
      }
      else{
        return cancelResponse;
      }
      // return res;
    }
    on TimeoutException catch (e) {
      print('Time Out '+e.toString());
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.timeOutConnection,
      );
      if(retry){
        var data= await api(url,body,context,
          imagePath: imagePath,);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
    catch (e) {
      print('Error in Api: $e');
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.errorOccur,
      );
      if(retry){
        var data= await api(url,body,context,
          imagePath: imagePath,);
        return data;
      }
      else{
        return cancelResponse;
      }
    }

  }

  multiyFileApi(url,body,context,{
    imagePath, docList,
  })
  async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    // dio.options.contentType= Headers.formUrlEncodedContentType;
    try{
      print(baseUrl+url);
      print(body);
      print(user.getUserToken);
      var headers = {
        'accessToken': user.getUserToken
      };
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl+url));
      request.fields.addAll(body);
      print('dddddddddddddddddddd');
      for(int i=0;i<docList.length;i++){
        request.files.add(await http.MultipartFile.fromPath('files',docList[i]['filePath']));
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      print(response.toString());

      var data={
        'status':  response.statusCode==200? 1: 0,
        'data': await response.stream.bytesToString(),
      };
      print(data);
      return  data;
    }
    on SocketException {
      print('No Internet connection');
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.internetConnectionIssue,
      );
      if(retry){
        var data= await api(url,body,context,
          imagePath: imagePath,
        );
        return data;
      }
      else{
        return cancelResponse;
      }
      // return res;
    }
    on TimeoutException catch (e) {
      print('Time Out '+e.toString());
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.timeOutConnection,
      );
      if(retry){
        var data= await api(url,body,context,
          imagePath: imagePath,);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
    catch (e) {
      print('Error in Api: $e');
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.errorOccur,
      );
      if(retry){
        var data= await api(url,body,context,
          imagePath: imagePath,);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
  }

}


class DioData {

  // Dio dio= new  Dio(BaseOptions());


  api(url,body,context,{
    token,
    groupId,
    fileName
  })
  async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    //   dio.options.contentType= Headers.formUrlEncodedContentType;
    try{
      print(baseUrl+url);
      String myToken;
      String userId;
      myToken=  user.getUserToken;
      userId=  user.getUserId;
      print(token.toString());
      print(myToken.toString());
      print(userId.toString());
      var formData = FormData.fromMap(body);
      var response = await Dio().post(baseUrl+url,
        data: formData,
        options: Options(
            headers: {
              'accessToken': myToken,
              'userID': userId.toString()
            }),
        onSendProgress: (int sent, int total) {
          if(fileName!='')
          {
            // uploadProC.updateProgress(
            //     groupId: groupId,
            //     fileName: fileName,
            //     total: total,
            //     val: sent
            // );
          }
          // print('$sent $total');
        },
      );
     // uploadProC.removeProgress(fileName);
      var data = await jsonDecode(response.toString());
      if(data is List){
        return data;
      }
      else{
        return data;
      }
    }
    on SocketException {
      print('No Internet connection');
      var retry=await apiDialogue(context, localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.internetConnectionIssue,
      );
      if(retry){
        var data= await api(url,body,context,
            token: token,
            groupId: groupId,
            fileName: fileName);
        return data;
      }
      else{
        return cancelResponse;
      }
      // return res;
    }
    on TimeoutException catch (e) {
      print('Time Out '+e.toString());
      var retry=await apiDialogue(context, localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.timeOutConnection,
      );
      if(retry){
        var data= await api(url,body,context,
            token: token,
            groupId: groupId,
            fileName: fileName);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
    catch (e) {
      print('Error in Api: $e');
      var retry=await apiDialogue(context, localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.errorOccur,
      );
      if(retry){
        var data= await api(url,body,context,
            token: token,
            groupId: groupId,
            fileName: fileName);
        return data;
      }
      else{
        return cancelResponse;
      }
    }

  }




}


apiDialogue(context,alert,msg,{
  bool? showCanCelButton
}){
  var canPressOk=true;
  var retry=false;
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return StatefulBuilder(
            builder: (context,setState)
            {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: WillPopScope(
                    onWillPop: (){
                      return Future.value(false);
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                              child: Lottie.asset('assets/noInterNet.json'),),
                            Text(msg.toString(),
                              textAlign: TextAlign.center,
                              style: MyTextTheme().mediumWCB),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                Visibility(
                                  visible: showCanCelButton?? true,
                                  child: Expanded(
                                      flex: 2,
                                      child: MyButton(
                                        color: AppColor.greyLight,
                                          onPress: (){
                                            if(canPressOk)
                                            {
                                              canPressOk=false;
                                              Navigator.pop(context);
                                              retry=false;
                                            }
                                          },
                                          title: 'Cancel')),
                                ),
                        Visibility(
                            visible: showCanCelButton?? true,
                                  child: const Expanded(child: SizedBox()),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: MyButton(
                                        onPress: (){
                                          if(canPressOk)
                                          {
                                            canPressOk=false;
                                            Navigator.pop(context);
                                            retry=true;
                                          }
                                        },
                                        title: 'Retry')),
                                const Expanded(child: SizedBox()),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      }).then((val){
    canPressOk=false;
    return retry;
  });
}


















// class DioData {
//
//   Dio dio= new  Dio(BaseOptions(
//     baseUrl: baseUrl,
//     connectTimeout: 5000,
//     receiveTimeout: 3000,));
//
//
//   api(url,body,context) async{
//     dio.options.contentType= Headers.formUrlEncodedContentType;
//     // var formData = FormData.fromMap({
//     //   'userName': 'wendux',
//     //   'age': 25,
//     //   'file': await MultipartFile.fromFile('./text.txt',filename: 'upload.txt')
//     // });
//     try {
//       print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'+url.toString());
//       print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'+body.toString());
//       var response = await dio.post(url,
//           data: body,
//           options: Options(
//               headers: {
//                 HttpHeaders.contentTypeHeader: "application/json",
//               }
//               ),
//               );
//       print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'+response.toString());
//     } catch (e) {
//       print(e);
//     }
//
//   }
// }


class HttpApp
{
  String username = 'H!\$\$erV!Ce';
  String password = '0785C700-B96C-44DA-A3A7-AD76C58A9FBC';

  api(url,body,context,{
    token,
    raw,
    is64,
  })
  async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    try{
      var basicAuth = (is64?? false)?  'Basic ' + 'H!\$\$erV!Ce:0785C700-B96C-44DA-A3A7-AD76C58A9FBC'
          :'Basic ' + base64Encode(utf8.encode('$username:$password'));

      print(eraBaseUrl+url);
      print(basicAuth.toString());
      print(body.toString());
      if(token=true){
        print(user.getUserToken.toString());
      }
      else{
        print('Token False');
      }



      var response = await http.post(
          Uri.parse(eraBaseUrl+url),
          body: body,
          headers: <String, String>{'authorization': basicAuth}
        // <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
      );

      var  data = await json.decode(response.body);
      //print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'+data.toString());

      //print(data);



      if(data is String){
        if(data== localization.getLocaleData.alertToast?.youAreLoggedOut || data==localization.getLocaleData.alertToast?.unauthorisedUser){
          Navigator.popUntil(context, ModalRoute.withName('/DashboardView'));
          await user.removeUserData();
          alertToast(context, data.toString());

        }
        else{
          var newData={
            'status': 0,
            'message': data,
          };
          print(newData.toString());
          return newData;
        }

        // return newData;
      }
      else{
        data['responseCode']=response.statusCode;
        print(data.toString());
        if(data['status']==0 && (data['message']== localization.getLocaleData.alertToast?.invalidToken || data['message']==localization.getLocaleData.alertToast?.unauthorisedUser) ){
          Navigator.popUntil(context, ModalRoute.withName('/DashboardView'));
          await user.removeUserData();
          alertToast(context, data['message']);
        }
        else{
          //print('dddddddddddd');
          return data;
        }

      }

    }
    on SocketException {
      print('No Internet connection');
      var retry=await apiDialogue(context, localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.internetConnectionIssue,
      );
      if(retry){
        var data= await api(url,body,context,
            token: token);
        return data;
      }
      else{
        return cancelResponse;
      }

    }
    on TimeoutException catch (e) {
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.timeOutConnection,
      );
      if(retry){
        var data= await api(url,body,context,
          token: token,);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
    catch (e) {
      print('Error in Api: $e');
      var retry=await apiDialogue(context,localization.getLocaleData.alertToast?.alert, localization.getLocaleData.alertToast?.errorOccur ,
      );
      if(retry){
        var data= await api(url,body,context,
            token: token);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
  }
}