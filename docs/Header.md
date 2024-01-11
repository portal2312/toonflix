`lib/main.dart`:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF181818),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
```

- [`Color`](https://api.flutter.dev/flutter/dart-ui/Color-class.html)
- [`Padding`](https://api.flutter.dev/flutter/widgets/Padding-class.html)
- [`EdgeInsets.symmetric`](https://api.flutter.dev/flutter/painting/EdgeInsets/EdgeInsets.symmetric.html): 대칭적인 수직 및 수평 오프셋을 사용하여 삽입물을 만듭니다.
- [`SizedBox`](https://api.flutter.dev/flutter/widgets/SizedBox-class.html)
- [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html)
  - [`mainAxisAlignment`](https://api.flutter.dev/flutter/widgets/Flex/mainAxisAlignment.html): 주축(`Row`: 가로, `Column`: 세로)을 따라 하위 요소를 배치하는 방법입니다.
- [MainAxisAlignment.end](https://api.flutter.dev/flutter/rendering/MainAxisAlignment.html)
- [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)
  - [`crossAxisAlignment`](https://api.flutter.dev/flutter/widgets/Flex/crossAxisAlignment.html): 교차(`Row`: 세로, `Column`: 가로) 축을 따라 하위 요소를 배치하는 방법입니다.
  - [CrossAxisAlignment.end](https://api.flutter.dev/flutter/rendering/CrossAxisAlignment.html)
- [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html)
- [`Colors`](https://api.flutter.dev/flutter/material/Colors-class.html)
- [`Colors.white.withOpacity`](https://api.flutter.dev/flutter/dart-ui/Color/withOpacity.html)
- [`FontWeight`](https://api.flutter.dev/flutter/dart-ui/FontWeight-class.html)
