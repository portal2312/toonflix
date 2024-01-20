이전에 작성 된 `ListView` 를 _VSCode Code Action Extract Method_ 를 사용하여 `makeList` method 로 정의합니다. 그리고 `Scaffold.body` 의 `FutureBuilder.builder` 와 `makeList` method 를 아래와 같이 작성합니다, `lib/screens/home_screen.dart`:

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
            return Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                // NOTE MUST Use Expanded Widget: FlutterError (Horizontal viewport was given unbounded height. Viewports expand in the cross axis to fill their container and constrain their children to match their extent in the cross axis. In this case, a horizontal viewport was given an unlimited amount of vertical space in which to expand.)
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(10, 10),
                  ),
                ],
              ),
              width: 250,
              child: Image.network(
                webtoon.thumb,
                // HACK #1 Add headers: NetworkImageLoadException (HTTP request failed, statusCode: 403, https://URL)
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
```

- `FutureBuilder.builder` 내 if 문의 `Column`
  - `SizedBox`: Widget 간의 간격을 정의합니다.
  - [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html): 정의하지 않는 경우, 상위 `Column` 을 기준으로 하위 Widget 의 높이가 정의되지 않아 예외가 발생됩니다(자세한 내용은 코드 내 주석 참조).
    - [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html)
      - properties
        - `padding`: `webtoon.thumb` 에 위아래, 좌우 그림자를 가려지 않기 위해서 [`EdgeInsets.symmetric`](https://api.flutter.dev/flutter/painting/EdgeInsets/EdgeInsets.symmetric.html) 를 사용하여 정의합니다.
        - `scrollDirection`: 옆으로 넘기기 위해서 [`Axis.horizontal`](https://api.flutter.dev/flutter/painting/Axis.html#horizontal) 를 사용하여 정의합니다.
      - `Column`
        - `Container`: `webtoon.thumb` 불러오고 꾸미기 위해 정의합니다.
          - properties:
            - `clipBehavior`: 자식의 부모 영역 침범을 제어하기 위해 [Clip.hardEdge](https://api.flutter.dev/flutter/dart-ui/Clip.html#hardEdge) 를 사용하여 정의합니다. 정의 시, `decoration` 에 정의 된 모서리([`BoxDecoration.borderRadius`](https://api.flutter.dev/flutter/painting/BoxDecoration/borderRadius.html))를 표현할 수 있습니다.
            - `decoration`: 모서리([`BoxDecoration.borderRadius`](https://api.flutter.dev/flutter/painting/BoxDecoration/borderRadius.html))와 그림자([`BoxDecoration.boxShadow`](https://api.flutter.dev/flutter/painting/BoxDecoration/boxShadow.html)) 정의합니다.
            - `width`: 가로를 정의합니다.
            - `child`: [`Image.network`](https://api.flutter.dev/flutter/widgets/Image/Image.network.html) 를 사용하여 `webtoon.thumb` 을 불러옵니다.
- [`CircularProgressIndicator`](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html): Application 이 사용 중임을 나타내기 위해 회전하는 Material Design 순환 진행률 표시기 입니다.

> [!WARNING]
> 예제에서 `webtoon.thumb` 그림을 [`Image.network`](https://api.flutter.dev/flutter/widgets/Image/Image.network.html) Widget 으로 불러오는 경우, _NetworkImageLoadException (HTTP request failed, statusCode: 403, https://URL)_ 같은 예외가 발생됩니다.
> 이는 네이버 웹툰에서 브라우저가 아닌 호출은 HTTP 403 오류를 발생하도록 설정되 있기 때문입니다.
> 해결하기 위한 방법은 `headers` property 를 위와 같이 작성했습니다(`webtoon.thumb` 주소를 브라우저에서 호출 후, headers 안에 User-Agent 를 참조).
