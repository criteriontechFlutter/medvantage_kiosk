//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:digi_doctor_max/AppManager/alert_dialogue.dart';
// import 'package:digi_doctor_max/Emus/user_type_enum.dart';
// import 'package:digi_doctor_max/Pages/startup_screen.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'app_util.dart';
// import 'package:get/get.dart';
//
//
// class RawData{
//
//   String  baseUrl =   'http://52.172.134.222:207/api/v1.0/';
//
//
//   String  baseUrl2 =   'http://182.156.200.179:332/api/v1.0/';
//
//
//
//
//   api(url,var body,context,{
//     bool? token,
//   })
//   async {
//
//
//     try{
//       print(baseUrl+url);
//       print(body);
//       print(token);
//       print(user.getUserToken);
//       var response;
//       // print(token);
//       if(user.getUserType==UserType.ambulance){
//
//         /// this structure is for calling ambulance's api
//
//         response = (token??   false)?  await Dio().post(baseUrl+url,
//           data: body,
//           options: Options(
//               headers: {
//                 HttpHeaders.contentTypeHeader: "application/json",
//               }
//           ),
//         ):
//         await Dio().post(baseUrl+url,
//           data: body,
//           options: Options(
//               headers: {
//                 'accessToken': user.getUserToken.toString(),
//                 'userID': user.getUserLoginId.toString()
//               }
//           ),
//         );
//       }
//       else if((user.getUserType==UserType.doctor) || (user.getUserType==UserType.clinic)){
//
//         ///this structure is for calling doctor's api
//
//         response = (token??   false)?  await Dio().post(baseUrl+url,
//           data: body,
//           options: Options(
//               headers: {
//                 'x-access-token': user.getUserToken.toString(),
//                 HttpHeaders.contentTypeHeader: "application/json",
//               }
//           ),
//         ):
//         await Dio().post(baseUrl+url,
//           data: body,
//           options: Options(
//               headers: {
//                 // 'userID': user.getUserLoginId.toString()
//               }
//           ),
//         );
//       }
//       else{
//
//       /// This will patient's part
//
//       }
//       var data = await jsonDecode(response.toString());
//       print(data['responseMessage']);
//       print('jjjjjjjjj');
//       if((data['responseCode']==0)&&(data['responseMessage'].toString().trim()=='Failed to authenticate token !!'.trim())){
//         await user.removeUserData();
//
//         Future.delayed(Duration.zero, (){
//           Get.offAll(const StartUpView());
//         });
//
//         // while(Navigator.canPop(context)){
//         //   Navigator.pop(context);
//         // }
//         alertToast(context, 'unauthorised user');
//       }
//       else{
//         if(data is List){
//           return data[0];
//         }
//         else{
//           return data;
//         }
//       }
//     }
//     on SocketException {
//       print('No Internet connection');
//       var retry=await apiDialogue(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
//       );
//       if(retry){
//         var data= await api(url,body,context,
//             token: token);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }
//     }
//     on TimeoutException catch (e) {
//       print('Time Out '+e.toString());
//       var retry=await apiDialogue(context, 'Alert  !!!', 'Time Out, plz check your connection.',
//       );
//       if(retry){
//         var data= await api(url,body,context,
//             token: token);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }
//     }
//     catch (e) {
//       print('Error in Api: $e');
//       var retry=await apiDialogue(context, 'Alert  !!!', 'Some Error Occur, plz check your connection.',
//       );
//       if(retry){
//         var data= await api(url,body,context,
//             token: token,);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }
//     }
//   }
//
//
//   knowmedApi(url,var body,context)
//   async{
//
//     var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZmlyc3ROYW1lIjoic2FkZGFtIiwibGFzdE5hbWUiOm51bGwsImVtYWlsSWQiOm51bGwsIm1vYmlsZU5vIjoiODk2MDI1MzEzMyIsImNvdW50cnkiOiJJTkRJQSIsInppcENvZGUiOiIyMjYwMjAiLCJvY2N1cGF0aW9uSWQiOjEsImFnZSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJoZWlnaHRJbkZlZXQiOm51bGwsImhlaWdodEluSW5jaCI6bnVsbCwid2VpZ2h0IjpudWxsLCJwYWNrYWdlTmFtZSI6IkZyZWUiLCJpYXQiOjE1NjMwMTM4MDUsImV4cCI6MTU5NDU0OTgwNX0.l220lljQyTXmDPD-gyU53H4vV-I1GDPociKcp2qrWe8';
//
//     try{
//
//       print(baseUrl2+url);
//       print(body);
//       var response;
//       print(token);
//
//       response = await Dio().post(baseUrl2+url,
//         data: body,
//         options: Options(
//             headers: {
//               'x-access-token': token,
//               HttpHeaders.contentTypeHeader: "application/json",
//             }
//         ),
//       );
//       var data = await jsonDecode(response.toString());
//       print(data);
//       if(data is List){
//         return data[0];
//       }
//       else{
//         return data;
//       }
//     }
//
//     on SocketException {
//       print('No Internet connection');
//       var retry=await apiDialogue(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
//       );
//       if(retry){
//         var data= await knowmedApi(url,body,context,);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }
//     }
//     on TimeoutException catch (e) {
//       print('Time Out '+e.toString());
//       var retry=await apiDialogue(context, 'Alert  !!!', 'Time Out, plz check your connection.',
//       );
//       if(retry){
//         var data= await knowmedApi(url,body,context,);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }
//     }
//     catch (e) {
//       print('Error in Api: $e');
//       var retry=await apiDialogue(context, 'Alert  !!!', 'Some Error Occur, plz check your connection.',
//       );
//       if(retry){
//         var data= await api(url,body,context,);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }
//     }
//
//   }
//
// }
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/app_util.dart';
import 'package:dio/dio.dart';





class RawData83{




  api(url,var body,context,{
    bool? token,
    bool? isNewBaseUrl,
    bool showRetry=true
  })
  async {
    // print('**********************');
    //   print(data);
    //  print("*********************i");
    try{
      //Map<String, String> headerC;
      // var formData = FormData.fromMap(body);
      var fullUrl=isNewBaseUrl==true? url:baseUrl83+url;
      print('bodyyyyyyyyy:  '+body.toString());
      print('token:  '+user.getUserToken.toString());
      print('baseurl:  '+fullUrl.toString());
      // print('userId:  '+user.getUserId.toString());

      var response = !(token??   false)?  await Dio().post(fullUrl,
        data: body,
        options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }
        ),
      ):
      await Dio().post(fullUrl,
        data: body,
        options: Options(
            headers: {
              'x-access-token': user.getUserToken.toString(),
              //'token':  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IlN0dWRlbnQyMDIyIiwibmFtZWlkIjoiNCIsInJvbGUiOiI3IiwicHJpbWFyeXNpZCI6IjkiLCJuYmYiOjE2NTUxOTI4MzIsImV4cCI6MTY1NTE5NjQzMiwiaWF0IjoxNjU1MTkyODMyfQ.g4U-naBHpQnRKyagGfj_PTCNn1aJPR0Qst2Bjbw2jns",
              // 'userID': user.getUserId.toString()
            }
        ),
      );

      var data = await jsonDecode(response.toString());
      print(data);
      if(data is List){
        return data[0];
      }
      else{
        return data;
      }



    }
    on SocketException {
      print('No Internet connection');
      if(showRetry){
        var retry=await apiDialogue2(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
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
    on TimeoutException catch (e) {
      if(showRetry){
        print('Time Out '+e.toString());
        var retry=await apiDialogue2(context, 'Alert  !!!', 'Time Out, plz check your connection.',
        );
        if(retry){
          var data= await api(url,body,context,
              token: token);
          return data;
        }
        else{
          return cancelResponse;
        }}
    }
    catch (e) {
      if(showRetry){
        print('Error in Api: $e');
        var retry=await apiDialogue2(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
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
    }
  }



  getapi(url,context,{
    bool? token,
    bool? isNewBaseUrl,
    bool showRetry=true
  })
  async {
    // print('**********************');
    //   print(data);
    //  print("*********************i");
    try{
      //Map<String, String> headerC;
      // var formData = FormData.fromMap(body);
      var fullUrl=isNewBaseUrl==true? url:baseUrl83+url;
      //  print('bodyyyyyyyyy:  '+body.toString());
      print('token:  '+user.getUserToken.toString());
      print('baseurl:  '+fullUrl.toString());
      // print('userId:  '+user.getUserId.toString());

      var response = !(token??   false)?  await Dio().get(fullUrl,
        options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }
        ),
      ):
      await Dio().get(fullUrl,
        options: Options(
            headers: {
              // 'x-access-token': user.getUserToken.toString(),
              //'token':  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IlN0dWRlbnQyMDIyIiwibmFtZWlkIjoiNCIsInJvbGUiOiI3IiwicHJpbWFyeXNpZCI6IjkiLCJuYmYiOjE2NTUxOTI4MzIsImV4cCI6MTY1NTE5NjQzMiwiaWF0IjoxNjU1MTkyODMyfQ.g4U-naBHpQnRKyagGfj_PTCNn1aJPR0Qst2Bjbw2jns",
              // 'userID': user.getUserId.toString()
            }
        ),
      );

      var data = await jsonDecode(response.toString());
      print(data);
      if(data is List){
        return data[0];
      }
      else{
        return data;
      }



    }
    on SocketException {
      print('No Internet connection');
      if(showRetry){
        var retry=await apiDialogue2(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
        );
        if(retry){
          var data= await getapi(url,context,
              token: token);
          return data;
        }
        else{
          return cancelResponse;
        }
      }

    }
    on TimeoutException catch (e) {
      if(showRetry){
        print('Time Out '+e.toString());
        var retry=await apiDialogue2(context, 'Alert  !!!', 'Time Out, plz check your connection.',
        );
        if(retry){
          var data= await getapi(url,context,
              token: token);
          return data;
        }
        else{
          return cancelResponse;
        }}
    }
    catch (e) {
      if(showRetry){
        print('Error in Api: $e');
        var retry=await apiDialogue2(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
        );
        if(retry){
          var data= await getapi(url,context,
            token: token,);
          return data;
        }
        else{
          return cancelResponse;
        }
      }
    }
  }




// forgotPasswordApi(url,var body,context,{
//   bool? token,
//   bool? isNewBaseUrl,
//   bool showRetry=true
// })
// async {
//   try{
//     var fullUrl=isNewBaseUrl==true? url: forgotPassword+url;
//
//     print('bodyyyyyyyyy:  '+body.toString());
//     print('token:  '+user.getUserToken.toString());
//     print('baseurl:  '+fullUrl.toString());
//
//     var response = !(token??   false)?  await Dio().put(fullUrl,
//       data: body,
//       options: Options(
//           headers: {
//             HttpHeaders.contentTypeHeader: "application/json",
//           }
//       ),
//     ):
//     await Dio().post(fullUrl,
//       data: body,
//       options: Options(
//           headers: {
//             //'x-access-token': user.getUserToken.toString(),
//             'token':  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IlN0dWRlbnQyMDIyIiwibmFtZWlkIjoiNCIsInJvbGUiOiI3IiwicHJpbWFyeXNpZCI6IjkiLCJuYmYiOjE2NTUxOTI4MzIsImV4cCI6MTY1NTE5NjQzMiwiaWF0IjoxNjU1MTkyODMyfQ.g4U-naBHpQnRKyagGfj_PTCNn1aJPR0Qst2Bjbw2jns",
//             // 'userID': user.getUserId.toString()
//           }
//       ),
//     );
//     var data = await jsonDecode(response.toString());
//     print(data);
//     if(data is List){
//       return data[0];
//     }
//     else{
//       return data;
//     }
//
//   }
//   on SocketException {
//     print('No Internet connection');
//     if(showRetry){
//       var retry=await apiDialogue2(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
//       );
//       if(retry){
//         var data= await api2(url,body,context,
//             token: token);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }
//     }
//
//   }
//   on TimeoutException catch (e) {
//     if(showRetry){
//       print('Time Out '+e.toString());
//       var retry=await apiDialogue2(context, 'Alert  !!!', 'Time Out, plz check your connection.',
//       );
//       if(retry){
//         var data= await api2(url,body,context,
//             token: token);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }}
//   }
//   catch (e) {
//     if(showRetry){
//       print('Error in Api: $e');
//       var retry=await apiDialogue2(context, 'Alert  !!!', 'Some Error Occur, plz check your connection.',
//       );
//       if(retry){
//         var data= await api2(url,body,context,
//           token: token,);
//         return data;
//       }
//       else{
//         return cancelResponse;
//       }
//     }
//
//   }
// }


}
