`DetailScreen` Widget 의 `episodes` instance variable 의 UI 를 만듭니다.

1. `build` method 안에 `Scaffold.body` 하위 `Column` 첫 번째 하위인 `SizedBox` 제거합니다.
2. `DetailScreen` Widget 의 `webtoon` instance variable 를 사용 중인 `FutureBuilder` 의 `builder` method body 에서 `Padding` 을 제거합니다.
3. `build` method 안에 `Scaffold.body` 하위 `Column` 을 `SingleChildScrollView` 로 감쌉니다. 그리고 간격을 주기 위해 `SingleChildScrollView.padding` 을 `EdgeInsets.all` 으로 정의합니다.
4. `build` method 안에 `Scaffold.body` 에 정의 된 `SingleChildScrollView` 하위 `Padding` 하위 `Column` 에 `SizedBox` 를 추가합니다.
5. 그리고 `DetailScreen` Widget 의 `episodes` instance variable 를 사용 할 `FutureBuilder` 를 아래와 같이 작성합니다.

`lib/screens/detail_screen.dart`:

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
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
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green.shade400,
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  episode.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- `DetailScreen` Widget 의 `episodes` instance variable 는 값이 크지 않기 때문에 UI 를 `Column` 을 사용합니다. 그리고 데이터가 존재 시, **[collection for](https://dart.dev/language/collections#control-flow-operators)** 를 사용하여 일괄적으로 `Container` Widget 을 사용한 버튼이 그려질 수 있도록 합니다. 만일 데이터가 없다면 빈 화면을 표현하기 위해 `Container` 반환합니다.
