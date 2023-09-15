class CategoryDetailsDataModal{
  int?categoryId;
  String?categoryName;
  String?categoryImage;

  CategoryDetailsDataModal({
    this.categoryId,
    this.categoryName,
    this.categoryImage
});
  factory CategoryDetailsDataModal.fromJson(Map<String,dynamic>json)=>
      CategoryDetailsDataModal(
        categoryId: json['categoryId'],
        categoryName: json['categoryName'],
        categoryImage: json['categoryImage'],
      );

}