
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'app_util.dart';


class RawData{
  var speechLocal ="http://192.168.8.104:8001/api/v1/";
  var speechLive = "http://20.198.105.18:8001/api/v1/";
  //Knowmed BaseUrl
  String knowmedBaseUrl='http://182.156.200.179:332/api/v1.0/';
  api(url,var body,context,{
    bool? token,
    bool? isNewBaseUrl,
    String? newBaseUrl,
    String? newToken,
    bool showRetry=true
  })
  async {
    try{
      var fullUrl=isNewBaseUrl==true? newBaseUrl!=null?  newBaseUrl+url:supplementUrl+url:baseUrl+url;


      print('bodyyyyyyyyy:  '+body.toString());
      print('token:  '+user.getUserToken.toString());
      print('baseurl:  '+fullUrl.toString());
      print('userId:  '+user.getUserId.toString());

      var myHeader=newToken==null? {
        'x-access-token': user.getUserToken.toString(),
        'userID': user.getUserId.toString()
      }:{ 'Authorization': newToken??"",
        'x-access-token': user.getUserToken.toString(),
        'userID': user.getUserId.toString()
      };
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
            headers:myHeader
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
        var retry=await apiDialogue(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
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
        print('Time Out $e');
        var retry=await apiDialogue(context, 'Alert  !!!', 'Time Out, plz check your connection.',
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
        var retry=await apiDialogue(context, 'Alert  !!!', 'Some Error Occur, plz check your connection.',
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




  apiNLP(url,var body,context,{
    bool? token,
    bool? isNewBaseUrl,
    String? newBaseUrl,
    String? newToken,
    bool showRetry=true
  })
  async {
    try{
      var fullUrl=isNewBaseUrl==true? newBaseUrl!=null?  newBaseUrl+url:supplementUrl+url:baseUrl+url;


    print("Animesh"+url.toString());

      var myHeader=newToken==null? {
        'x-access-token': user.getUserToken.toString(),
        'userID': user.getUserId.toString()
      }:{ 'Authorization': newToken??"",
        'x-access-token': user.getUserToken.toString(),
        'userID': user.getUserId.toString()
      };
      var response = !(token??   false)?  await Dio().post(speechLive+url,
        data: body,
        options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }
        ),
      ):
      await Dio().post(speechLive+url,
        data: body,
        options: Options(
            headers:myHeader
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
        var retry=await apiDialogue(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
        );
        if(retry){
          var data= await api(speechLive+url,body,context,
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
        print('Time Out $e');
        var retry=await apiDialogue(context, 'Alert  !!!', 'Time Out, plz check your connection.',
        );
        if(retry){
          var data= await api(speechLive+url,body,context,
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
        var retry=await apiDialogue(context, 'Alert  !!!', 'Some Error Occur, plz check your connection.',
        );
        if(retry){
          var data= await api(speechLive+url,body,context,
            token: token,);
          return data;
        }
        else{
          return cancelResponse;
        }
      }
    }
  }



  knowMedApi(url, body,context,{
    bool? token,
  })
  async {
    // print('**********************');
    //   print(data);
    //  print("*********************i");
    try{
      //Map<String, String> headerC;
      // var formData = FormData.fromMap(body);
      // print('token:  '+user.getUserData.token.toString());
      // print('uuuuuuuuuuuuurrrrrllllllll:  '+baseUrl+url.toString());

      var response = !(token??   false)?  await Dio().post(knowmedBaseUrl+url,
        data: body,
        options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }
        ),
      ):


      await Dio().post(knowmedBaseUrl+url,
        data: body,
        options: Options(
            headers: {
              // 'x-access-token':  user.getUserData.token.toString(),
              // 'userID':  user.getUserData.id.toString()
            }
        ),
      );
      log(response.toString());
      var data = await jsonDecode(response.toString());
      print(jsonEncode(body));
      if(data is List){
        return data[0];
      }
      else{
        return data;
      }

    }
    on SocketException {
      print('No Internet connection');
      var retry=await apiDialogue(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
      );
      if(retry){
        var data= await knowMedApi(url,body,context,
            token: token);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
    on TimeoutException catch (e) {
      print('Time Out '+e.toString());
      var retry=await apiDialogue(context, 'Alert  !!!', 'Time Out, plz check your connection.',
      );
      if(retry){
        var data= await knowMedApi(url,body,context,
            token: token);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
    catch (e) {
      print('Error in Api: $e');
      var retry=await apiDialogue(context, 'Alert  !!!', 'Some Error Occur, plz check your connection.',
      );
      if(retry){
        var data= await knowMedApi(url,body,context,
          token: token,);
        return data;
      }
      else{
        return cancelResponse;
      }
    }
  }



  getapi(url,context,{
    bool? token,
    bool? isNewBaseUrl,
    String? newBaseUrl,
    bool showRetry=true
  })
  async {
    // print('**********************');
    //   print(data);
    //  print("*********************i");
    try{
      //Map<String, String> headerC;
      // var formData = FormData.fromMap(body);
      var fullUrl=(isNewBaseUrl?? false)? newBaseUrl.toString()+url:baseUrl+url;
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
        var retry=await apiDialogue(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
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
        var retry=await apiDialogue(context, 'Alert  !!!', 'Time Out, plz check your connection.',
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
        var retry=await apiDialogue(context, 'Alert  !!!', 'Internet connection issue, try to reconnect.',
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

}
