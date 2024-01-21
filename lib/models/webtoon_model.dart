class WebtoonModel {
  final String id, thumb, title;

  // NOTE Default constructor.
  WebtoonModel({
    required this.id,
    required this.thumb,
    required this.title,
  });

  // NOTE Named constructor.
  WebtoonModel.formJson(Map<String, dynamic> json)
      : id = json['id'],
        thumb = json['thumb'],
        title = json['title'];
}
