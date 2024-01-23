class WebtoonDetailModel {
  final String about;
  final String age;
  final String genre;
  final String thumb;
  final String title;

  // NOTE: Default constructor.
  WebtoonDetailModel({
    required this.about,
    required this.age,
    required this.genre,
    required this.thumb,
    required this.title,
  });

  // NOTE: Named constructor.
  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : about = json['about'],
        age = json['age'],
        genre = json['genre'],
        thumb = json['thumb'],
        title = json['title'];
}
