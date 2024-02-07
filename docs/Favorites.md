즐겨찾기 기능을 추가합니다.

1. 선택 된 대상의 즐겨찾기 정보를 단순히 단말에 저장 할 수 있도록 [shared_preferences](https://pub.dev/packages/shared_preferences) package 를 설치합니다.
2. `DetailScreen` widget 의 즐겨찾기 여부를 갖는 `isLiked` property 와 단말 정보를 갖는 `prefs` property 를 정의합니다.
3. `DetailScreen` widget 의 `initPrefs` method 를 정의합니다. 이는 `SharedPreferences` 를 사용하여 `likedToons` key 기준으로 초기화하기 또는 선택 된 대상의 즐겨찾기 여부를 확인하기 를 합니다. 그리고 `initState` method 안에서 호출합니다.
4. `DetailScreen` widget 의 `onFavoriteTap` method 를 정의합니다. 이는 `prefs` 의 `likedToons` key 를 기준으로 선택 된 대상의 `widget.id` 를 지우거나 추가한 후 `prefs` 의 `likedToons` key 에 적용합니다. 그리고 `setState` 를 사용하여 `DetailScreen` widget 의 `isLiked` property 값을 반전하여 적용합니다.
5. `DetailScreen` widget 의 `build` method 안에 [`AppBar`](https://api.flutter.dev/flutter/material/AppBar-class.html) widget 에 `actions` property 를 추가하고 하위에 [IconButton](https://api.flutter.dev/flutter/material/IconButton-class.html) 를 추가합니다. 추가 된 [IconButton](https://api.flutter.dev/flutter/material/IconButton-class.html)의 `icon` property 는 `DetailScreen` widget 의 `isLiked` instance variable 에 따른 [Icons](https://api.flutter.dev/flutter/material/Icons-class.html) 을 정의될 수 있도록 제어하고 `onPressed` method 에는 `onFavoriteTap` 정의합니다.

`lib/screens/detail_screen.dart`:

```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/episode_widget.dart';

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
  bool isLiked = false;
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      setState(() {
        isLiked = likedToons.contains(widget.id);
      });
    } else {
      // NOTE: At the application's first start.
      prefs.setStringList('likedToons', []);
    }
  }

  onFavoriteTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
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
        actions: [
          IconButton(
            onPressed: onFavoriteTap,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline_outlined,
            ),
          )
        ],
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
                        headers: kIsWeb
                            ? null
                            : const {
                                'Referer': 'https://comic.naver.com',
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
                          Episode(
                            webtoonId: widget.id,
                            episode: episode,
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
