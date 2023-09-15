class AllCategoryDataModal{
  int?categoryId;
  String?categoryName;
  String?imagePath;
  int?noOfProducts;


  AllCategoryDataModal({
    this.categoryId,
    this.categoryName,
    this.imagePath,
    this.noOfProducts
  });
  factory AllCategoryDataModal.fromJson(Map<String,dynamic> json)=>
      AllCategoryDataModal(
          categoryId:json['categoryId'],
          categoryName: json['categoryName'],
          imagePath: json['imagePath'],
          noOfProducts: json['noOfProducts']
      );
}