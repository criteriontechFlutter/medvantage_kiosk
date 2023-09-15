class TopSymptomsDataModal{
  int? id;
  String? problemName;
  String? imagePath;
  bool isSelected;

  TopSymptomsDataModal({
    required this.id,
    required this.imagePath,
    required this.problemName,
    required this.isSelected,
});

  factory TopSymptomsDataModal.fromJson(Map<String, dynamic> json) =>
      TopSymptomsDataModal(
        id: json['problemId'],
        problemName: json['problemName'],
        imagePath: json['displayIcon'],
        isSelected: json['isSelected'],
      );

}