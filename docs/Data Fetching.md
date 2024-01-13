서비스의 데이터를 가져오기 위한 API class 를 작성합니다, `lib/services/api_service.dart`:

```dart
import 'package:http/http.dart' as http; // NOTE Avoid naming conflicts.

class ApiService {
  final String baseURL = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  void getTodaysToons() async {
    final url = Uri.parse("$baseURL/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
```

- [`Uri`](https://api.dart.dev/stable/3.2.3/dart-core/Uri-class.html): URL과 같은 구문 분석된 URI 입니다.
- [`http`](https://pub.dev/packages/http): HTTP 요청을 위한 구성 가능한 다중 플랫폼 미래 기반 API 입니다.

> [!NOTE]
> `http` package [설치](https://pub.dev/packages/http/install) 중 `pubspec.yaml` 파일 안에서 작성하는 설치는 파일을 작성 후 저장 시, VSCode 에서 자동으로 설치됩니다.

> [!TIP]
> `http` package 안의 함수 명 사용 시, 이름 충돌 회피 또는 가독성을 위해 `as` 를 작성하여 다음과 같이 작성합니다: `import 'package:http/http.dart' as http;`

`ApiService` class 의 `getTodaysToons` 함수 실행하여 서비스 데이터 확인합니다, `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/services/api_service.dart';

void main() {
  ApiService().getTodaysToons();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
```

저장 후 Debug 시, VScode Debug Console 에서 확인할 수 있습니다.
