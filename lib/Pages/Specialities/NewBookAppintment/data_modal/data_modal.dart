
class TimeSlotDataModal {
  int? id;
  int? userId;
  String? fromTime;
  String? toTime;

  TimeSlotDataModal({this.id, this.userId, this.fromTime, this.toTime});

  TimeSlotDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    return data;
  }
}


class DayDataModal {
  int? id;
  String? dayName;
  int? userId;
  int? status;
  String? createdDate;
  int? clientID;

  DayDataModal(
      {this.id,
        this.dayName,
        this.userId,
        this.status,
        this.createdDate,
        this.clientID});

  DayDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayName = json['dayName'];
    userId = json['userId'];
    status = json['status'];
    createdDate = json['createdDate'];
    clientID = json['clientID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dayName'] = this.dayName;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['createdDate'] = this.createdDate;
    data['clientID'] = this.clientID;
    return data;
  }
}

