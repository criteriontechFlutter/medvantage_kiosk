

class TimeSlotDataModal {
  int? id;
  String? fromTime;
  String? toTime;
  int? doctorId;
  int? timeslotId;
  int? dayId;
  String? dayName;
  String? doctorName;

  TimeSlotDataModal(
      {this.id,
        this.fromTime,
        this.toTime,
        this.doctorId,
        this.timeslotId,
        this.dayId,
        this.dayName,
        this.doctorName});

  TimeSlotDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    doctorId = json['doctorId'];
    timeslotId = json['timeslotId'];
    dayId = json['dayId'];
    dayName = json['dayName'];
    doctorName = json['doctorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['doctorId'] = this.doctorId;
    data['timeslotId'] = this.timeslotId;
    data['dayId'] = this.dayId;
    data['dayName'] = this.dayName;
    data['doctorName'] = this.doctorName;
    return data;
  }
}


class DayDataModal {
  int? id;
  String? fromTime;
  String? toTime;
  int? doctorId;
  int? timeslotId;
  int? dayId;
  String? dayName;
  String? doctorName;

  DayDataModal(
      {this.id,
        this.fromTime,
        this.toTime,
        this.doctorId,
        this.timeslotId,
        this.dayId,
        this.dayName,
        this.doctorName});

  DayDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    doctorId = json['doctorId'];
    timeslotId = json['timeslotId'];
    dayId = json['dayId'];
    dayName = json['dayName'];
    doctorName = json['doctorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['doctorId'] = this.doctorId;
    data['timeslotId'] = this.timeslotId;
    data['dayId'] = this.dayId;
    data['dayName'] = this.dayName;
    data['doctorName'] = this.doctorName;
    return data;
  }
}


