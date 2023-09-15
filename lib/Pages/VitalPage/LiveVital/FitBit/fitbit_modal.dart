import 'dart:convert';
import 'dart:developer';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/FitBit/fitbit_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FitBitModal {
  FitBitController controller = Get.put(FitBitController());

  getToken(context) async {
    String userCode = controller.getCode.toString();
    String client = '238LH2:9ba579e4e63ed8774a3e8c3959652254';
    String code_verifier = '01234567890123456789012345678901234567890123456789';
    var convertedCode = base64.encode(utf8.encode(client));
    var body = {
      'client_id': '238LH2',
      'grant_type': 'authorization_code',
      'code': userCode,
      'redirect_uri': 'https://www.google.com/',
      'code_verifier': code_verifier
    };
    var response = await http.post(
        Uri.parse(
          'https://api.fitbit.com/oauth2/token',
        ),
        body: body,
        headers: {
          'Authorization': 'Basic $convertedCode',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    log('------------' + response.body.toString());
    controller.updateAuthData = jsonDecode(response.body);
    print(
        'https://api.fitbit.com/oauth2/token?code=${userCode}&grant_type=authorization_code&redirect_uri=https://www.google.com/');

    log('------------' + controller.getAuthData.toString());
  }

  getHeartRate(context) async {
    await getToken(context);
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String userCode = controller.getAuthData['user_id'].toString();
    // var data=await http.get(Uri.parse('https://api.fitbit.com/1/user/$userCode/hrv/date/$date.json'),
    var data = await http.get(
        Uri.parse(
          'https://api.fitbit.com/1/user/$userCode/activities/heart/date/$date/1d/1min.json'
            // 'https://api.fitbit.com/1/user/$userCode/activities/heart/date/today/1d.json'
        ),
        headers: {
          'accept': 'application/json',
          'authorization':
              'Bearer ' + controller.getAuthData['access_token'].toString(),
        });
    log('nnnnnnnnnnnnnnnnn' + jsonDecode(data.body).toString());
    if(jsonDecode(data.body)['activities-heart'].isNotEmpty){
      controller.updateHeartRateZones= jsonDecode(data.body)['activities-heart'][0]['value'];
    }


    print('https://api.fitbit.com/1/user/$userCode/hrv/date/$date.json');
    print(controller.getAuthData['access_token'].toString());
    // log('vvvvvvvvvvvvvvvvvvvvvvvvv' +controller.getHeartRateZones.toString());
    log('nnnnnnnnnnnnnnnnn' + data.statusCode.toString());
  }

}
