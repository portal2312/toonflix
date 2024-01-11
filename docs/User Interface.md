이전 내용은 제거 후, 처음부터 Pomodoro App 을 만들어 보기.

`lib/main.dart`:

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
    return MaterialApp(
      theme: ThemeData(
        cardColor: const Color(0xFFF4EDDB),
        colorScheme: const ColorScheme(
          background: Color(0xFFE7626C),
          brightness: Brightness.light,
          primary: Color(0xFFFFFFFF),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFFFFFFF),
          error: Color(0xFFFFFFFF),
          onError: Color(0xFFFFFFFF),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFFFFFFF),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
      ),
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
```

`HomeScreen` Widget 생성하기, `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                '01:00',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                color: Theme.of(context).cardColor,
                icon: const Icon(
                  Icons.play_circle_outline,
                ),
                iconSize: 98,
                onPressed: () {},
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

- [`Flexible`](https://api.flutter.dev/flutter/widgets/Flexible-class.html):  [Row](https://api.flutter.dev/flutter/widgets/Row-class.html), [Column](https://api.flutter.dev/flutter/widgets/Column-class.html), 또는 [Flex](https://api.flutter.dev/flutter/widgets/Flex-class.html)의 하위 요소가 신축성 있는 방식으로 제어하는 ​​위젯입니다.
- [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html): 하위 자식의 사용 가능한 공간을 채울 수 있도록 [Row](https://api.flutter.dev/flutter/widgets/Row-class.html), [Column](https://api.flutter.dev/flutter/widgets/Column-class.html), 또는 [Flex](https://api.flutter.dev/flutter/widgets/Flex-class.html)의 하위 자식을 확장하는 위젯입니다.
