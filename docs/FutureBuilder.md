이전 `HomeScreen` 은 [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) 은 전통적인 방법으로 일련의 코드를 작성해야 했습니다. 이는 코드적인 면에서 다양한 관리가 필요합니다. 그러나 [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) 와 [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) 하면 아주 간단하게 작성할 수 있습니다.

이전 `HomeScreen` Widget 의 특징입니다:

- [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) Widget
  - Instance variables
    - `webtoons`: 호출 된 API 데이터 정보
    - `isLoading`: API 호출이 끝났는 지에 대한 상태 정보
  - Methods
    - `initState`
      - 초기화 시, API 를 호출하고 `webtoons` 에 저장하기
      - `isLoading` 값 변경하기
    - `body`: 작성이 필요하나 앞으로 변경될 코드이므로 생략하겠습니다.

변경 된 `HomeScreen` Widget 의 코드와 특징은 아래와 같습니다, `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // NOTE https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
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
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text("Complete.");
          }
          return const Text("Loading...");
        },
      ),
    );
  }
}

```

- [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) Widget
  - Instance variables
    - `webtoons`: `final Future<List<WebtoonModel>>` 유형으로 API 데이터 정보를 갖습니다. 이 때, [`Future`](https://api.flutter.dev/flutter/dart-async/Future-class.html) 에 의해 `HomeScreen` 은 미리 compile 될 수 없으므로 `const HomeScreen` 에서 `HomeScreen` 으로 참조 된 코드를 변경해야 합니다.
  - Methods
    - `build`: `Scaffold.body` 에 [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) 를 위와 같이 작성합니다.
