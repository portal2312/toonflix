상세 페이지인 `DetailScreen` Widget 을 작성합니다:

1. [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) Widget 을 상속 받습니다.
2. 상세 정보에 필요한 `id`, `thumb`, `title` instance variables 를 작성합니다.
3. `build` method 는 `HomeScreen.build` 안에 [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html)(`backgroundColor`, `appBar` 만) 으로 작성합니다.
4. 작성 된 [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) 의 `body` 는 아래와 같이 작성합니다.

`lib/screens/detail_screen.dart`:

```dart
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          title,
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
              Container(
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
                  thumb,
                  // HACK: #2 NetworkImageLoadException (HTTP request failed, statusCode: 403, https://URL) solution is adding "User-Agent" headers.
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                  },
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

사진 선택(=`onTap`) 시, `DetailScreen` 으로 이동하는 `Webtoon` Widget 을 정의합니다:

1. [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) Widget 을 상속 받습니다.
2. `build` method 는 `HomeScreen` Widget 의 `makeList` method 안에 [`ListView.itemBuilder`](https://api.flutter.dev/flutter/material/ReorderableListView/itemBuilder.html) 내에 작성 된 `Column` 을 포함한 하위를 작성합니다.
3. 정의 된 `Webtoon` Widget 의 `build` method 안에 `Column` 은 사진 선택 이벤트(=`Tap`)를 정의하기 위해서 [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) Widget 으로 감쌉니다.
4. [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) Widget 의 [`onTap`](https://api.flutter.dev/flutter/widgets/GestureDetector/onTap.html) property 정의합니다.
5. 정의 된 [`onTap`](https://api.flutter.dev/flutter/widgets/GestureDetector/onTap.html) property 안에 [`Navigator.push`](https://api.flutter.dev/flutter/widgets/Navigator/push.html) 작성하고 `route` parameter 값은 [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html) 로 작성합니다.
6. 작성 된 [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html) Widget 의 `builder` property 의 값은 `DetailScreen` Widget 으로 작성합니다.
7. [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html) Widget 의 `fullscreenDialog` property 의 값에 따라 아래와 같이 정의됩니다:
   - `false`(default): 애니메이션은 좌우, 좌측상단 버튼은 `<`
   - `true`: 애니메이션은 아래위, 좌측상단 버튼은 `X`

`lib/widgets/webtoon_widget.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String id;
  final String thumb;
  final String title;

  const Webtoon({
    super.key,
    required this.id,
    required this.thumb,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
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
              thumb,
              // HACK: #2 NetworkImageLoadException (HTTP request failed, statusCode: 403, https://URL) solution is adding "User-Agent" headers.
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: id,
              thumb: thumb,
              title: title,
            ),
            fullscreenDialog: true,
          ),
        );
      },
    );
  }
}
```

`Webtoon` Widget 이 추출되어 `HomeScreen` Widget 의 `makeList` method 는 아래와 같이 정리됩니다, `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // NOTE: https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // NOTE: MUST Use Expanded Widget, FlutterError (Horizontal viewport was given unbounded height. Viewports expand in the cross axis to fill their container and constrain their children to match their extent in the cross axis. In this case, a horizontal viewport was given an unlimited amount of vertical space in which to expand.)
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          id: webtoon.id,
          thumb: webtoon.thumb,
          title: webtoon.title,
        );
      },
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
```
