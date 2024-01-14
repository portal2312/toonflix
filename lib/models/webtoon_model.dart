class WebtoonModel {
  final String id, title, thumb;

  // NOTE Default constructor.
  WebtoonModel({
    required this.id,
    required this.title,
    required this.thumb,
  });

  // NOTE Named constructor.
  WebtoonModel.formJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumb = json['thumb'];
}
