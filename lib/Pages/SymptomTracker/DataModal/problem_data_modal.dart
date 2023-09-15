



class ProblemDataModal {
  int problemId;
  String problemName;
  bool isVisible;
  String displayIcon;


  ProblemDataModal({
    required this.problemId,
    required this.problemName,
    required this.isVisible,
    required this.displayIcon,
  });

  factory ProblemDataModal.fromJson(Map<String, dynamic> json) =>
      ProblemDataModal(
        problemId: json['problemId']??0,
        problemName: json['problemName']??'',
        isVisible: json['isVisible']==1,
        displayIcon: json['displayIcon']??'',
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['problemId'] = problemId;
    data['problemName'] = problemName;
    data['isVisible'] = isVisible;
    data['displayIcon'] = displayIcon;
    return data;
  }


}

