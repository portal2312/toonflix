`lib/main.dart`:

```dart import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyLargeTitle(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatelessWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Large Title',
      style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge!.color,
        fontSize: 30,
      ),
    );
  }
}
```

- [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
  - [`theme`](https://api.flutter.dev/flutter/material/MaterialApp/theme.html): 이 앱의 재질 위젯에 대한 색상 글꼴 및 모양과 같은 기본 시각적 속성입니다.
- [`ThemeData`](https://api.flutter.dev/flutter/material/ThemeData-class.html): [MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html)에 대한 전체 시각적 테마 또는 앱 내의 위젯 하위 트리 구성을 정의합니다.
  [MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html) [theme](https://api.flutter.dev/flutter/material/MaterialApp/theme.html) 속성을 사용하여 전체 앱의 모양을 구성할 수 있습니다. 앱 내의 위젯 하위 트리는 하위 트리 상단에 테마 위젯을 포함하여 앱 테마를 재정의할 수 있습니다.
- [`TextTheme`](https://api.flutter.dev/flutter/material/TextTheme-class.html): Material 디자인 글자 테마입니다.
- `Theme.of(context).textTheme.titleLarge!.color`: `BuildContext` 유형의 `context`(=상위 객체) 매개 변수를 [`Theme.of`](https://api.flutter.dev/flutter/material/Theme/of.html) method 에 이용하여 테마를 적용합니다. 여기서 null safety 에 의해 반드시 `?` 또는 `!` 를 사용해야 합니다.
