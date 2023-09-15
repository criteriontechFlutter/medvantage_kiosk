class PopularProductListDataModal{
  int?productId;
  String?productName;
  String?shortDescription;
  String?imageURL;


  PopularProductListDataModal({
    this.productId,
    this.productName,
    this.shortDescription,
    this.imageURL
  });
  factory PopularProductListDataModal.fromJson(Map<String,dynamic>json)=>
      PopularProductListDataModal(
          productId: json['productId'],
          productName: json['productName'],
          shortDescription: json['shortDescription'],
          imageURL: json['imageURL']
      );
}

class SliderImageDataModal{

  List?sliderImage;

  SliderImageDataModal({
    this.sliderImage

  });
  factory SliderImageDataModal.fromJson(Map<String,dynamic> json)=>
      SliderImageDataModal(
          sliderImage: json['sliderImage']??[]
      );

}
