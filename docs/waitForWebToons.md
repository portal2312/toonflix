먼저 `main.dart` 안에 서비스 데이터를 확인하기 위해 작성했던 코드를 제거합니다, `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
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

`ApiService` class 내에 class-wide 한 상수와 상태를 정의할 때(=instance variables 와 methods 구현)하기 위해 다음과 같이 `static` keyword 를 사용합니다, `lib/services/api_service.dart`:

```dart
import 'dart:convert';
// NOTE Avoid naming conflicts.
import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseURL =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse("$baseURL/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<WebtoonModel> webtoonInstances = [];
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.formJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
```

- `baseURL` 와 `today`: [Static variables](https://dart.dev/language/classes#static-variables) 로 변경합니다.
- `getTodaysToons`: [Static methods](https://dart.dev/language/classes#static-methods) 으로 변경합니다.

`HomeScreen` Widget 을 VScode Code Action 사용하여 `StatefulWidget` 으로 변경하고, 서비스 데이터를 가져올 수 있도록 합니다, `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    waitForWebtoons();
  }

  void waitForWebtoons() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons);
    print(isLoading);
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
    );
  }
}
```

- [`initState`](https://api.flutter.dev/flutter/widgets/State/initState.html): 해당 Widget 이 초기화(객체가 Widget tree 에 삽입될 때 호출) 시, `waitForWebtoons` method 를 호출하여 서비스 데이터를 가져옵니다.
- `List<WebtoonModel> webtoons = [];`: 서비스 데이터를 저장하기 위한 class instance variables 를 정의합니다.
- `bool isLoading = true;`: 불러오기 전 상태를 저장하기 위한 class instance variables 를 정의합니다. 이 때, 초기 값은 불러오기 전의 의미로 `true` 입니다.
- `waitForWebtoons()`: 비동기인 서비스 데이터를 불러오고 `isLoading` 해제합니다. 이 때, `setState` 를 사용하여 반드시 상태를 반영합니다.
