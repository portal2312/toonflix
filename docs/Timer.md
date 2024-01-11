`lib/screens/home_screen.dart`:

```dart
import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  late Timer timer;

  void onTick(Timer timer) {
    setState(() {
      totalSeconds -= 1;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

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
                '$totalSeconds',
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
                onPressed: onStartPressed,
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
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
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

- `late Timer timer;`: `late` 는 나중에 반드시 초기화 시켜주기 위해 약속이다.
- `Timer.periodic(const Duration(seconds: 1), onTick);`: 반드시 `onTick`는 함수 명으로 호출해야 한다. 자동으로 [`Timer.periodic`](https://api.flutter.dev/flutter/dart-async/Timer/Timer.periodic.html) 에서 함수를 호출하기 때문이다.
- `onTick` 함수의 `Timer timer` 매개 변수는 `onStartPressed` 함수 내에 `Timer.periodic` 에서 `onTick` 함수 호출 시, 매개 변수 넘겨주기 때문에 작성해야 한다.
- [`BorderRadius.circular`](https://api.flutter.dev/flutter/painting/BorderRadius/BorderRadius.circular.html)
