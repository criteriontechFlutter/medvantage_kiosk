class CartListProductDetailsDataModal {
  String? productInfoCode;
  int? productId;
  String? brandName;
  String? productName;
  double? starRating; // DOUBLE
  double? totalRating;
  int? totalreviews;
  double? offeredPrice; // DOUBLE
  double? mrp; // DOUBLE
  double? discountedRs; // DOUBLE
  int? availableStock;
  String? shortDescription;
  String? description;
  double? fivestarPerc;
  double? fourstarPerc;
  double? threestarPerc;
  double? twostarPerc;
  double? onestarPerc;
  int? inCartStatus;
  int? isMedicine;
  int? knowmedMedicineId;
  int? wishlistStatus;

  CartListProductDetailsDataModal({
    required this.productInfoCode,
    required this.productId,
    required this.brandName,
    required this.productName,
    required this.starRating,
    required this.totalRating,
    required this.offeredPrice,
    required this.totalreviews,
    required this.mrp,
    required this.discountedRs,
    required this.availableStock,
    required this.shortDescription,
    required this.description,
    required this.fivestarPerc,
    required this.fourstarPerc,
    required this.threestarPerc,
    required this.twostarPerc,
    required this.onestarPerc,
    required this.inCartStatus,
    required this.isMedicine,
    required this.knowmedMedicineId,
    required this.wishlistStatus,
  });

  factory CartListProductDetailsDataModal.fromJson(Map json) =>
      CartListProductDetailsDataModal(
        productInfoCode: json['productInfoCode'] ?? ''.toString(),
        productId: json['productId'] ?? 0,
        brandName: json['brandName'] ?? ''.toString(),
        productName: json['productName'] ?? ''.toString(),
        starRating: json['starRating'] ?? 0.0,
        totalRating: json['totalRating']==''?0.0:double.parse((json['totalRating'] ?? 0.0).toString()),
        offeredPrice: json['offeredPrice'] ?? 0.0,
        mrp: json['mrp'] ?? 0.0,
        discountedRs: json['discountedRs'] ?? 0.0,
        availableStock: json['availableStock'] ?? 0,
        shortDescription: json['shortDescription'] ?? ''.toString(),
        description: json['description'] ?? ''.toString(),
        fivestarPerc: json['fivestarPerc']==''?0.0:double.parse((json['fivestarPerc'] ?? 0.0).toString()),
        fourstarPerc: json['fourstarPerc']==''?0.0:double.parse((json['fourstarPerc'] ?? 0.0).toString()),
        threestarPerc: json['threestarPerc']==''?0.0:double.parse((json['threestarPerc'] ?? 0.0).toString()),
        twostarPerc: json['twostarPerc'] ==''?0.0:double.parse((json['twostarPerc'] ?? 0.0).toString()),
        onestarPerc: json['onestarPerc']==''?0.0:double.parse((json['onestarPerc'] ?? 0.0).toString()),
        inCartStatus: json['inCartStatus'] ?? 0,
        isMedicine: json['isMedicine'] ?? 0,
        knowmedMedicineId: json['knowmedMedicineId'] ?? 0,
        wishlistStatus: json['wishlistStatus'] ?? 0,
        totalreviews: json['totalreviews'] ?? 0,
      );
}

class ImageDataModal {
  String? imagePath;
  ImageDataModal({required this.imagePath});
  factory ImageDataModal.fromJson(Map json) => ImageDataModal(
        imagePath: json['imagePath'] ?? ''.toString(),
      );
}

class SimilarProduct {
  int? productId;
  String? productName;
  String? shortDescription;
  double? mrp;
  double? offeredPrice;
  String? productInfoCode;
  int? inCartStatus;
  int? wishlistStatus;
  String? imageURL;
  SimilarProduct({
    required this.productId,
    required this.productName,
    required this.shortDescription,
    required this.mrp,
    required this.offeredPrice,
    required this.productInfoCode,
    required this.inCartStatus,
    required this.wishlistStatus,
    required this.imageURL,
  });
  factory SimilarProduct.fromJson(Map json) => SimilarProduct(
      productInfoCode: json['productInfoCode'] ?? ''.toString(),
      mrp: json['mrp'] ?? 0.0,
      inCartStatus: json['inCartStatus'] ?? 0,
      productName: json['productName'] ?? ''.toString(),
      wishlistStatus: json['wishlistStatus'] ?? 0,
      shortDescription: json['shortDescription'] ?? ''.toString(),
      offeredPrice: json['offeredPrice'] ?? 0.0,
      productId: json['productId'] ?? 0,
      imageURL: json['imageURL'] ?? ''.toString());
}

class SizeDetails {
  int? sizeid;
  String? size;
  int? isSelected;
  SizeDetails({
    required this.sizeid,
    required this.isSelected,
    required this.size,
  });
  factory SizeDetails.fromJson(Map json) => SizeDetails(
      size: json['size'] ?? ''.toString(),
      sizeid: json['sizeid'] ?? 0,
      isSelected: json['isSelected'] ?? 0);
}

class FlavourDetails {

}

class MaterialDetails {}

class ColorDetails {
  int? colorId;
  String? color;
  String? colorCode;
  int? isSelected;

  ColorDetails(
      {required this.isSelected,
      required this.colorCode,
      required this.color,
      required this.colorId});
  factory ColorDetails.fromJson(Map json) => ColorDetails(
    isSelected: json['isSelected'] ?? 0,
    colorId: json['colorId'] ?? 0,
    color: json['color'] ?? ''.toString(),
    colorCode:json['colorCode'] ?? ''.toString(),);

}

class ReviewDetailsDataModal {
  String? reviewBy;
  String? reviewDate;
  double? starRating;
  String? review;
  String? profilePhotoPath;

  ReviewDetailsDataModal(
      {
        required this.reviewBy,
        required this.reviewDate,
        required this.starRating,
        required this.review,
        required this.profilePhotoPath});
  factory ReviewDetailsDataModal.fromJson(Map json) => ReviewDetailsDataModal(
      profilePhotoPath: json['profilePhotoPath'] ?? ''.toString(),
      starRating:json['starRating'] ?? 0.0,
      reviewDate: json['reviewDate'] ?? ''.toString(),
      reviewBy: json['reviewBy'] ?? ''.toString(),
      review: json['review'] ?? ''.toString()
  );
}

class FlavourDataModal {
  int? flavourId;
  String? flavour;
  int? isSelected;

  FlavourDataModal({
    required this.flavourId,
    required this.flavour,
    required this.isSelected
  });

  factory FlavourDataModal.fromJson(Map json) => FlavourDataModal(
      flavour:  json['flavour'] ?? ''.toString(),
      isSelected:json['isSelected'] ?? 0,
      flavourId: json['flavourId'] ?? 0,
  );


}
class MaterialDataModal {
  int? matreialId;
  String? material;
  int? isSelected;

  MaterialDataModal({
    required this.matreialId,
    required this.material,
    required this.isSelected
  });

  factory MaterialDataModal.fromJson(Map json) => MaterialDataModal(
      material:  json['material'] ?? ''.toString(),
      matreialId:json['matreialId'] ?? 0,
      isSelected: json['isSelected'] ?? 0
  );


}
