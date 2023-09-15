class BodyOrganDataModal {
  String? img;
  String? title;
  String? id;
  String? language;

  BodyOrganDataModal(
      {  this.img, this.title, this.id, this.language});

  BodyOrganDataModal.fromJson(Map<String, dynamic> json) {

    img = json['img'];
    title = json['title'];
    id = json['id'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['img'] = this.img;
    data['title'] = this.title;
    data['id'] = this.id;
    data['language'] = this.language;
    return data;
  }
}
