class LabReviewDataModal{
  String?name;
  double?starRating;
  String?review;
  String?reviewDate;

  LabReviewDataModal({
    this.name,
    this.starRating,
    this.review,
    this.reviewDate
});
  factory LabReviewDataModal.fromJson(Map<String,dynamic>json)=>
      LabReviewDataModal(
        name: json['name'],
        starRating: double.parse(json['starRating'].toString()),
        review: json['review'],
        reviewDate: json['reviewDate']
      );

}