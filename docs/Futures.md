`DetailScreen` Widget 안에 (`Future<WebtoonDetailModel>` 유형의) `webtoon` 과 (`Future<List<WebtoonEpisodeModel>>` 유형의) `episodes` instance variables 를 정의합니다.
이 때, `DetailScreen` Widget 의 `id` instance variable 를 argument 로 하기 위해서 VSCode Code Action _Convert ot StatefulWidget_ 을 선택하여 [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) 으로 변경 후 `initState` 를 override 하고 그 안에서 서비스 API 를 호출하도록 작성합니다. `lib/screens/detail_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final String thumb;
  final String title;

  const DetailScreen({
    super.key,
    required this.id,
    required this.thumb,
    required this.title,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(10, 10),
                      ),
                    ],
                  ),
                  width: 250,
                  child: Image.network(
                    widget.thumb,
                    // HACK: #2 NetworkImageLoadException (HTTP request failed, statusCode: 403, https://URL) solution is adding "User-Agent" headers.
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

- 이전에 `StatelessWidget` 일 때 `id`, `thumb`, `title` instance variables 는 `StatefulWidget` 으로 변경되면서 `widget.id`, `widget.thumb`, `widget.title` 로 변경됩니다.
