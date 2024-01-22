`DetailScreen` Widget 의 `build` method 안에 `Scaffold.body` 하위 `Column.children` 의 두 번째 `Row.children` 하위 `Container` 을 [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html) Widget 으로 감쌉니다. `lib/screens/detail_screen.dart`:

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
              Hero(
                tag: id,
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
                    thumb,
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

- [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html)
  - [`tag`](https://api.flutter.dev/flutter/widgets/Hero/tag.html) Property: `DetailScreen` Widget 의 instance variables 중에서 `id` 를 정의합니다.

`Webtoon` Widget 의 `build` method 안에 `GestureDetector.child` 하위 `Column.children` 하위 `Container` 을 [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html) Widget 으로 감쌉니다. `lib/screens/_screen.dart`:

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
          Hero(
            tag: id,
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
                thumb,
                // HACK: #2 NetworkImageLoadException (HTTP request failed, statusCode: 403, https://URL) solution is adding "User-Agent" headers.
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                },
              ),
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

- [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html)
  - [`tag`](https://api.flutter.dev/flutter/widgets/Hero/tag.html) Property: `DetailScreen` Widget 의 instance variables 중에서 `id` 를 정의합니다.
