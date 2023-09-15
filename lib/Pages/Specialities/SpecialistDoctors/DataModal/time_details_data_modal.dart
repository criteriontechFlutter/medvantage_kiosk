


class TimeDetailsDataModal{
  String? dayName;
  int? dayId;
  int? duration;
  List<TimeDetailFromToDataModal>? timeDetails;
  String? timeFrom;
  String? timeTo;

  TimeDetailsDataModal({
    this.dayName,
    this.dayId,
    this.duration,
    this.timeDetails,
    this.timeFrom,
    this.timeTo,
});
  factory TimeDetailsDataModal.fromJson(Map<String, dynamic> json) =>
      TimeDetailsDataModal(
        dayName: json['dayName'],
        dayId: json['dayId'],
        duration: json['duration'],
        timeDetails:  List<TimeDetailFromToDataModal>.from(
            (json['timeDetails']?? [])
                .map((element) => TimeDetailFromToDataModal.fromJson(element))),
        timeFrom: json['timeFrom'],
        timeTo: json['timeTo'],

      );

}

class TimeDetailFromToDataModal{
  String? timeFrom;
  String? timeTo;
  TimeDetailFromToDataModal({
    this.timeTo,
    this.timeFrom,
});
  factory TimeDetailFromToDataModal.fromJson(Map<String, dynamic> json) =>
      TimeDetailFromToDataModal(
        timeTo :json['timeTo'],
        timeFrom :json['timeFrom'],
      );
}