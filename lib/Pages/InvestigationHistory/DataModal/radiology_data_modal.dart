

class RadiologyDataModal{
  String? pacsURL;

  RadiologyDataModal({
    this.pacsURL
    });
  factory RadiologyDataModal.fromJson(Map<String, dynamic> json) =>
      RadiologyDataModal(
  pacsURL: json['pacsURL']);


}