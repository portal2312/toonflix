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
  bool showTitle = true;

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

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
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLargeTitle() : const Text('nothing'),
              IconButton(
                onPressed: toggleTitle,
                icon: const Icon(Icons.remove_red_eye),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  int count = ;

  @override
  void initState() {
    super.initState();
    // API 갱신 또는 이벤트 리스너로부터 구독을 취소
    print('initState');
  }

  @override
  void dispose() {
    super.dispose();
    // API 갱신 또는 이벤트 리스너로부터 구독을 취소
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
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

`initState` method:

- `build` 이전에 호출된다.
- 변수를 초기화한다. 대부분 상태 변수를 초기화 하지만, 부모 요소에 의존하는 데이터를 초기화 해야하는 경우 또는 API 를 구독할 때 사용한다.

`build` method: UI Widget 을 만들 때 사용한다.

`dispose` method: 위젯 트리에서 제거되기 전에 무언가를 취소하기 위한 경우, 예로 이벤트 리스너 같은 것들을 구독 취소한다.
