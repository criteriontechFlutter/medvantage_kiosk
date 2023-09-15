

class IsolationHistoryDataModal{

 int?    id;
 String? hospitalName;
 String? packageName;
 double? packagePrice;
 String?  comoribid;
 String? stymptoms;
 String? testDate;
 String? testTypes;
 String? allergires;
 String? o2;
 String? onSetDate;
 String? homeIsolationStatus;
 String? userMobileNo;
 String? name;
 String? vitalDetails;
 String? requestedDate;

 IsolationHistoryDataModal({
   this.id,
   this.hospitalName,
   this.packageName,
   this.packagePrice,
   this.comoribid,
   this.stymptoms,
   this.testDate,
   this.testTypes,
   this.allergires,
   this.o2,
   this.onSetDate,
   this.homeIsolationStatus,
   this.userMobileNo,
   this.name,
   this.vitalDetails,
   this.requestedDate,
});

 factory IsolationHistoryDataModal.fromJson(Map<String, dynamic> json) => IsolationHistoryDataModal(

 id : json['id'],
 hospitalName : json['hospitalName'],
 packageName : json['packageName'],
 packagePrice : json['packagePrice']?? '',
 comoribid : json['comoribid']?? '',
 stymptoms : json['stymptoms']?? '',
 testDate : json['testDate'],
 testTypes : json['testTypes'],
 allergires : json['allergires'],
 o2 : json['o2'],
 onSetDate : json['onSetDate']?? '',
 homeIsolationStatus : json['homeIsolationStatus'],
 userMobileNo : json['userMobileNo']?? '',
 name : json['name'],
 vitalDetails : json['vitalDetails'],
 requestedDate : json['requestedDate'],

 );

}