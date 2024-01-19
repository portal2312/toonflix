많은 서비스 데이터를 한번에 동적으로 출력하기 위해서 [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) 사용합니다. 그 중 출력 중에 즉시 만들어 내는 (예: scroll 시) [ListView.builder](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html) 또는 [`ListView.separated`](https://api.flutter.dev/flutter/widgets/ListView/ListView.separated.html) 를 사용하면 더 효율적입니다, `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // NOTE https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                print(index);
                return Text(snapshot.data![index].title);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
            );
          }
          return const Text('Loading...');
        },
      ),
    );
  }
}

```

- [`ListView.separated`](https://api.flutter.dev/flutter/widgets/ListView/ListView.separated.html)
  - [`itemBuilder`](https://api.flutter.dev/flutter/widgets/NullableIndexedWidgetBuilder.html): 사용자가 보게 될 곳은 Widget 이 생성되며, 사용자가 보지 않는 곳은 `null` 이 되어 메모리가 초기화됩니다.
  - [`separatorBuilder`](https://api.flutter.dev/flutter/widgets/IndexedWidgetBuilder.html): `itemBuilder` 의 간격마다 Widget 을 생성합니다.
