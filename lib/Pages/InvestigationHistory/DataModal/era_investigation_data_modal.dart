import 'dart:convert';

class EraInvestigation {
  List<InvestigationResult>? investigationResult;
  int? pid;
  String? searchKey;
  int? id;
  int? userID;
  int? subDeptID;
  String? billNo;
  String? gender;
  String? fromDate;
  String? toDate;
  int? subTestID;
  int? patientInvestigationId;
  String? testTime;
  int? opCode;
  bool? isException;
  String? exceptionMessage;
  List<Ds>? ds;
  int? who;
  int? pageIndex;
  int? pageSize;

  EraInvestigation(
      { this.investigationResult,
         this.pid,
        this.searchKey,
         this.id,
         this.userID,
         this.subDeptID,
        this.billNo,
        this.gender,
        this.fromDate,
        this.toDate,
        this.subTestID,
        this.patientInvestigationId,
        this.testTime,
        this.opCode,
        this.isException,
        this.exceptionMessage,
        this.ds,
        this.who,
        this.pageIndex,
        this.pageSize});

  factory EraInvestigation.fromJson(Map<String, dynamic> json) => EraInvestigation(
    investigationResult:List<InvestigationResult>.from((json['investigationResult']??[]).map((element)=>InvestigationResult.fromJson(element)
    )
    ),
    pid : json['pid'],
    searchKey : json['searchKey'],
    id : json['id'],
    userID : json['userID'],
    subDeptID : json['subDeptID'],
    billNo : json['billNo'],
    gender : json['gender'],
    fromDate : json['fromDate'],
    toDate : json['toDate'],
    subTestID : json['subTestID'],
    patientInvestigationId : json['patientInvestigationId'],
    testTime : json['testTime'],
    opCode : json['opCode'],
    isException : json['isException'],
    exceptionMessage : json['exceptionMessage'],
    //ds : json['ds'] != null ? Ds.fromJson(json['ds']) : null;
    ds:List<Ds>.from((json['ds']??[]).map((element)=>Ds.fromJson(element))),
    who : json['who'],
    pageIndex : json['pageIndex'],
    pageSize : json['pageSize']
  );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (investigationResult != null) {
  //     data['investigationResult'] =
  //         investigationResult!.map((v) => v.toJson()).toList();
  //   }
  //   data['pid'] = pid;
  //   data['searchKey'] = searchKey;
  //   data['id'] = id;
  //   data['userID'] = userID;
  //   data['subDeptID'] = subDeptID;
  //   data['billNo'] = billNo;
  //   data['gender'] = gender;
  //   data['fromDate'] = fromDate;
  //   data['toDate'] = toDate;
  //   data['subTestID'] = subTestID;
  //   data['patientInvestigationId'] = patientInvestigationId;
  //   data['testTime'] = testTime;
  //   data['opCode'] = opCode;
  //   data['isException'] = isException;
  //   data['exceptionMessage'] = exceptionMessage;
  //   if (ds != null) {
  //     data['ds'] = ds.toJson();
  //   }
  //   data['who'] = who;
  //   data['pageIndex'] = pageIndex;
  //   data['pageSize'] = pageSize;
  // }
}

class InvestigationResult {
  List<Result>? result;
  String? billDate;

  InvestigationResult({this.result, this.billDate});

 factory InvestigationResult.fromJson(Map<String, dynamic> json) => InvestigationResult(
    result:List<Result>.from((json['result']==''?'[]':json['result']?? []).map((element)=>Result.fromJson(element)
    )
    ),
    billDate : json['billDate']??''.toString()
 );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (result != null) {
  //     data['result'] = result.map((v) => v.toJson()).toList();
  //   }
  //   data['billDate'] = billDate;
  //   return data;
  // }
}

class Result {
  String? itemName;
  String? itemID;
  List<TestDetail>? testDetails;

  Result({this.itemName, this.itemID, this.testDetails});

 factory Result.fromJson(Map<String, dynamic> json) => Result(
    itemName : (json['itemName']??'').toString(),
   itemID : (json['itemID']??'').toString(),
    //testDetails : (json['testDetails']??'[]'),
   testDetails:List<TestDetail>.from(jsonDecode(json['testDetails']==''?'[]':json['testDetails']?? []).map((element)=>TestDetail.fromJson(element)
   )
   ),
  );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['itemName'] = itemName;
  //   data['testDetails'] = testDetails;
  //   return data;
  // }
}
class TestDetail{
  String? subTestName;
  String? result;
  String? unitname;
  String? isNormalResult;
  String? resultRemark;

  TestDetail({this.subTestName,this.result,this.unitname,this.isNormalResult,this.resultRemark});

  factory TestDetail.fromJson(Map<String,dynamic>json) => TestDetail(
    subTestName: (json['subTestName']??'').toString(),
    result: (json['result']??'').toString(),
    unitname: (json['unitname']??'').toString(),
    isNormalResult: (json['isNormalResult']??'').toString(),
    resultRemark: (json['resultRemark']??'').toString(),
  );
}



class Ds {
  List<Table>? table;
  List<Table1>? table1;

  Ds({this.table, this.table1});

  factory Ds.fromJson(Map<String, dynamic> json) => Ds(

    table:List<Table>.from(jsonDecode(json['table']==''?'[]':json['table']).map((element)=>Table.fromJson(element))),
    table1:List<Table1>.from(jsonDecode(json['table1']==''?'[]':json['table1']).map((element)=>Table1.fromJson(element))),
);

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (table != null) {
  //     data['table'] = table!.map((v) => v.toJson()).toList();
  //   }
  //   if (table1 != null) {
  //     data['table1'] = table1!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Table {
  String? resultDate;

  Table({this.resultDate});

  factory Table.fromJson(Map<String, dynamic> json) =>Table(
    resultDate : json['resultDate']
  );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['resultDate'] = resultDate;
  //   return data;
  // }
}

class Table1 {
  int? itemID;
  String? itemName;
  String? resultDate;
  String? subTestDetails;

  Table1({this.itemID, this.itemName, this.resultDate, this.subTestDetails});

  factory Table1.fromJson(Map<String, dynamic> json) => Table1(
    itemID : json['itemID'],
    itemName : json['itemName'],
    resultDate : json['resultDate'],
    subTestDetails : json['subTestDetails']
  );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['itemID'] = itemID;
  //   data['itemName'] = itemName;
  //   data['resultDate'] = resultDate;
  //   data['subTestDetails'] = subTestDetails;
  //   return data;
  // }
}
