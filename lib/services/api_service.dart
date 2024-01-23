import 'dart:convert';
// NOTE Avoid naming conflicts.
import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseURL =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse("$baseURL/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      return webtoons.map((webtoon) => WebtoonModel.formJson(webtoon)).toList();
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseURL/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final detail = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(detail);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final url = Uri.parse("$baseURL/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      return episodes
          .map((episode) => WebtoonEpisodeModel.fromJson(episode))
          .toList();
    }
    throw Error();
  }
}
