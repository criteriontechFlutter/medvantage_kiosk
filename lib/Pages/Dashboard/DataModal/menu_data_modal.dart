


class MenuDataModal{
  int? id;
  String? menuName;
  String?  icon;

  MenuDataModal({
    this.id,
    this.icon,
    this.menuName,
});

  factory MenuDataModal.fromJson(Map<String,dynamic> json)=>
      MenuDataModal(
    id: json['id'],
    icon: json['icon'],
    menuName: json['menuName'],
      );
}