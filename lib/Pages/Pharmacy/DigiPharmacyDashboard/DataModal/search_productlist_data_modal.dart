class SearchProductListDataModal{
  int?productId;
  String?productName;
  String?shortDescription;
  String?imageURL;

  SearchProductListDataModal({
    this.productId,
    this.productName,
    this.shortDescription,
    this.imageURL
  });
  factory SearchProductListDataModal.fromJson(Map<String,dynamic>json)=>
      SearchProductListDataModal(
          productId: json['productId'],
          productName: json['productName'],
          shortDescription: json['shortDescription'],
          imageURL: json['imageURL']
      );

}