

class BlogDetailsDataModal{
  int?id;
  String?topic;
  String?title;
  String?description;
  String?totalLikes;
  String?imagePath;
  String?publishDate;

  BlogDetailsDataModal({
  this.id,
  this.topic,
  this.title,
  this.description,
  this.totalLikes,
  this.imagePath,
  this.publishDate
  });
  factory BlogDetailsDataModal.fromJson(Map<String, dynamic> json) =>
      BlogDetailsDataModal(
  id : json['id'],
  topic : json['topic'],
  title : json['title'],
  description : json['description'].toString(),
  totalLikes : json['totalLikes'].toString(),
  imagePath : json['imagePath'],
  publishDate:json['publishDate'],);
  }
