class LabTestSearchDataModal{
  String?id;
  int?labId;
  String?name;
  int?cartStatus;

  LabTestSearchDataModal({
    this.id,
    this.labId,
    this.name,
    this.cartStatus
});


  factory LabTestSearchDataModal.fromJson(Map<String,dynamic>json)=>
      LabTestSearchDataModal(
        id: json['id'],
        labId: json['labId'],
        name: json['name'],
        cartStatus: json['cartStatus']
      );

}