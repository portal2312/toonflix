먼저 서비스 데이터를 받아 class 객채로 만들기 위해 `WebtoonModel` class 를 생성합니다.  
이 때 `formJson` 이름으로 [Named Constructor](https://dart.dev/language/constructors#named-constructors) 를 생성합니다, `lib/models/webtoon_model.dart`:

```dart
class WebtoonModel {
  final String id, title, thumb;

  // NOTE Default constructor.
  WebtoonModel({
    required this.id,
    required this.title,
    required this.thumb,
  });

  // NOTE Named constructor.
  WebtoonModel.formJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumb = json['thumb'];
}
```

`ApiService` class 의 `getTodaysToons` method 에서 서비스 데이터 호출 결과를 `WebtoonModel` class 로 반환하도록 개선합니다, `lib/services/api_service.dart`:

```dart
import 'dart:convert';
// NOTE Avoid naming conflicts.
import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  final String baseURL = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse("$baseURL/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<WebtoonModel> webtoonInstances = [];
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.formJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
```

- 서비스 데이터는 `List<WebtoonModel>` 유형으로 정의합니다.
- `ApiService` class 의 `getTodaysToons` method 유형은 `Future<List<WebtoonModel>>` 정의합니다.

> [!NOTE]
> 비동기 결과를 동기식 처리하기 위해 [`async-await`](https://dart.dev/codelabs/async-await#working-with-futures-async-and-await) 가 사용됩니다. 그리고 결과 유형 정의 시, [`Future`](https://api.dart.dev/stable/dart-async/Future-class.html) 감싸서 사용합니다.
