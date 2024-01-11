`lib/main.dart`:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;

  void onClicked() {
    counter += 1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Click count',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    '$counter',
                    style: const TextStyle(fontSize: 30),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_box_rounded),
                    iconSize: 40,
                    onPressed: onClicked,
                  )
                ],
              ),
            )));
  }
}
```

- `StatelessWidget` 에서 Code Action(`Command` + `.`) 를 사용하여 `StatefulWidget` 으로 변경할 수 있다, 변경 시 `State` class 가 생성된다, 예:

```dart
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // ...
}
```

- [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html): 변경 가능한 상태가 필요하지 않은 위젯입니다.
- [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html): 변경 가능한 상태를 갖는 위젯입니다.
- [`State`](https://api.flutter.dev/flutter/widgets/State-class.html): [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)의 논리 및 내부 상태, 위젯의 데이터(=상태 값)를 저장 할 클래스 프로퍼티와 위젯의 UI 관련 코드를 갖는다.
