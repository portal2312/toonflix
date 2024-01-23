class WebtoonEpisodeModel {
  final String id;
  final String date;
  final String thumb;
  final String title;
  final String rating;

  // NOTE: Default constructor.
  WebtoonEpisodeModel({
    required this.id,
    required this.date,
    required this.thumb,
    required this.title,
    required this.rating,
  });

  // NOTE: Named constructor.
  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        thumb = json['thumb'],
        title = json['title'],
        rating = json['rating'];
}
