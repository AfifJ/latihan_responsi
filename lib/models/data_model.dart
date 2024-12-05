class DataModel {
  String id;
  String title;
  String imageUrl;
  String summary;
  String publishedAt;
  String newsSite;
  String url;

  DataModel(
      {required this.id,
      required this.title,
      required this.url,
      required this.imageUrl,
      required this.summary,
      required this.publishedAt,
      required this.newsSite});

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
        id: map['id'].toString(),
        title: map['title'],
        url: map['url'],
        imageUrl: map['image_url'],
        summary: map['summary'],
        newsSite: map['news_site'],
        publishedAt: map['published_at']);
  }
}
