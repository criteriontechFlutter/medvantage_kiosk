class PopularTestDataModal{
  String?name;
  double?price;
  int?id;
  String?description;
  double?mrp;
  String?type;
  double?discount;
  String?incartStatus;



  PopularTestDataModal({

    this.name,
    this.price,
    this.id,
    this.description,
    this.mrp,
    this.type,
    this.discount,
    this.incartStatus
});

  factory PopularTestDataModal.fromJson(Map<String,dynamic>json)=>
      PopularTestDataModal(
        name: json['name'],
        price:double.parse( json['price'].toString()),
        id: json['id'],
        description: json['description'],
        mrp: double.parse(json['mrp'].toString()),
        type: json['type'],
        discount: double.parse(json['discount'].toString()),
        incartStatus: json['incartStatus']
      );
}