
class SupplementDetailsDataModal{
  int?id;
  String?foodName;
  List<IntakeDetailDataModal>?intakeDetails;

  SupplementDetailsDataModal({
    this.id,
    this.foodName,
    this.intakeDetails,
});
  factory SupplementDetailsDataModal.fromJson(Map<String, dynamic> json) =>
      SupplementDetailsDataModal(
          id: json['id'],
        foodName: json['foodName'],
        intakeDetails: List<IntakeDetailDataModal>.from(
            (json['intakeDetails']??'[]').map((element) => IntakeDetailDataModal.fromJson(element))
        ),

      );

}


class IntakeDetailDataModal{
  String?intakeTime;
  int?quantity;
  String?intakeTimeForApp;
  int?foodId;
  int?isExists;
  int?isDose;
  int?unitId;
  String?foodName;
  String?unitName;


  IntakeDetailDataModal({
    this.intakeTime,
    this.quantity,
    this.intakeTimeForApp,
    this.foodId,
    this.isDose,
    this.isExists,
    this.unitId,
    this.foodName,
    this.unitName,

});
  factory IntakeDetailDataModal.fromJson(Map<String,dynamic>json)=>
      IntakeDetailDataModal(
          intakeTime: json['intakeTime'],
          quantity: json['quantity'],
          intakeTimeForApp: json['intakeTimeForApp'],
        foodId: json['foodId'],
        isDose: json['isDose'],
        isExists: json['isExists'],
        unitId: json['unitId'],
        foodName: json['foodName'],
        unitName: json['unitName'],
      );

}