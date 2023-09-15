
class AppointmentTimeDataModal{
  String? slotId;
  String? slotType;
  List<SlotBookedDetails>? slotDetails;

  AppointmentTimeDataModal(
      {
        this.slotId,
        this.slotType,
        this.slotDetails
      }
      );
  factory AppointmentTimeDataModal.fromJson(Map<String, dynamic> json) => AppointmentTimeDataModal(
    slotId: json['slotId'].toString(),
    slotType: json['slotType'].toString(),
    slotDetails: List<SlotBookedDetails>.from(
        (json['slotDetails']??[]).map((element) => SlotBookedDetails.fromJson(element))
    ),
  );

}


class SlotBookedDetails{
  String? slotId;
  String? slotType;
  String? slotTime;
  bool? isSelected;
  String? isBooked;
  SlotBookedDetails({
    this.slotId,
    this.slotType,
    this.slotTime,
    this.isSelected,
    this.isBooked
  });

  factory SlotBookedDetails.fromJson(Map<String, dynamic> json) => SlotBookedDetails(
    slotId: json['slotId'].toString(),
    slotType: json['slotType'].toString(),
    slotTime: json['slotTime'].toString(),
    isSelected: json['isSelected'],
    isBooked: json['isBooked']??""
  );

}