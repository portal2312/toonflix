Widget 이 layout 영역을 벗어나면, Flutter debug tools 에서 알려준다.

`lib/main.dart` 내에 중복 된 코드를 `Button` widget 으로 추출하기, `lib/widgets/button.dart`:

```dart
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color bgColor;
  final String text;
  final Color textColor;

  const Button({
    super.key,
    required this.bgColor,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
```

- `Button` widget 의 `build` 속성의 반환은 `lib/main.dart` 에서 내용 가져오기.
- 가져온 내용을 재사용 시, 변경 될 부분(`bgColor`, `text`, `textColor`)을 class 의 속성으로 만들기.
- constructors (쉽게) 작성하기:
  1. `final Color textColor;` 까지 작성하기.
  2. VSCode 의 Code Actions(`Command` + `.`) 실행하기.
  3. `Create constructor for final fields` 선택하기.
- `Button` widget 의 매개변수를 받는 하위 widget 은 `const` 를 (불변이므로) 사용 할 수 없다.

중복 된 코드를 `Button` widget 으로 변경하기, `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Hey, Selena",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "Welcome back",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
              ),
              Text(
                "Total Balance",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "\$5 194 482",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    text: "Transfer",
                    bgColor: Color(0xFFF1B33B),
                    textColor: Colors.black,
                  ),
                  Button(
                    text: "Request",
                    bgColor: Color(0xFF1F2123),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [MainAxisAlignment.spaceBetween](https://api.flutter.dev/flutter/rendering/MainAxisAlignment.html): 여유 공간을 균등하게 배치합니다.
