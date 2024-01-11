다양한 [Widgets](https://docs.flutter.dev/ui/widgets) 존재한다. 그 중 일반적으로 20% 정도 사용한다.
그러므로 외우지 말고 찾아 활용하도록 한다.

Edit `lib/main.dart`:

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
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Hello Flutter"),
        ),
        body: Center(
          child: Text("Hello world!"),
        ),
      ),
    );
  }
}
```

- [StatelessWidget class](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html): 변경 가능한 상태가 필요하지 않은 Widget 입니다.
- [MaterialApp class](https://api.flutter.dev/flutter/material/MaterialApp-class.html): Material Design 을 사용하는 Application 입니다, 반드시 `build` 함수 내에서 반환하기.
- [Scaffold class](https://api.flutter.dev/flutter/material/Scaffold-class.html): 기본 Material Design 시각적 Layout 구조를 구현합니다.
- [AppBar class](https://api.flutter.dev/flutter/material/AppBar-class.html)
- [Text class](https://api.flutter.dev/flutter/widgets/Text-class.html)
- [Center class](https://api.flutter.dev/flutter/widgets/Center-class.html): 자체 내에서 하위 항목을 중앙에 배치하는 Widget 입니다.
- class 들을 작성하고 뒤에 `,` 를 통해 줄을 정리하기(권장), VSCode 에서는 읽기 전용 주석을 붙여준다.
