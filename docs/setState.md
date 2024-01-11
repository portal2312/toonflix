`onClicked` 함수 내에 [`setState`](https://api.flutter.dev/flutter/widgets/State/setState.html) 를 추가하기, `lib/main.dart`:

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
    setState(() {
      counter += 1;
    });
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

- [`setState`](https://api.flutter.dev/flutter/widgets/State/setState.html): 이 개체의 내부 상태가 변경되었음을 프레임워크에 알립니다. [State](https://api.flutter.dev/flutter/widgets/State-class.html) 객체의 내부 상태를 변경할 때마다 [setState](https://api.flutter.dev/flutter/widgets/State/setState.html)에 전달하는 함수를 변경합니다.
