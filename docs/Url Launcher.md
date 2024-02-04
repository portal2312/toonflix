에피소드를 선택 시, URL 로 이동하도록 합니다.

## url_launcher

먼저, URL 로 이동하기 위해서 [url_launcher](https://pub.dev/packages/url_launcher) package 를 설치해야 합니다.

### url_launcher install

자세한 내용은 [이 곳](https://pub.dev/packages/url_launcher/install)을 참조바랍니다.

### url_launcher configuration

[Android](https://pub.dev/packages/url_launcher#android) 는 아래와 같이 추가합니다, `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
  <application
    android:label="toonflix"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher">
    <!-- ... -->
  </application>
  <!-- Provide required visibility configuration for API level 30 and above -->
  <queries>
    <!-- If your app checks for SMS support -->
    <intent>
      <action android:name="android.intent.action.VIEW" />
      <data android:scheme="https" />
    </intent>
    <!-- If your application checks for inAppBrowserView launch mode support -->
    <intent>
      <action android:name="android.support.customtabs.action.CustomTabsService" />
    </intent>
  </queries>
</manifest>
```

```xml

```

[iSO](https://pub.dev/packages/url_launcher#ios) 는 아래와 같이 추가합니다, `iso/Runner/info.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
       <!-- ... -->
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>https</string>
    </array>
</dict>
</plist>
```

macOS 는 아래와 같이 추가합니다, `macos/Runner/Info.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <!-- ... -->
        <key>LSApplicationQueriesSchemes</key>
        <array>
            <string>https</string>
        </array>
    </dict>
</plist>
```

이후 변경 된 디바이스 설정을 불러오기 위해 Debugging 을 반드시 중지 후 다시 시작합니다.

자세한 내용은 [이 곳](https://pub.dev/packages/url_launcher#configuration)을 참조바랍니다.

## Editing

`Episode` Widget 을 정의합니다:

1. `DetailScreen` 안에서 `episodes` 를 그리는 `Container` 를 `Episode` Widget 으로 추출 후, `lib/widgets/episode_widget.dart` 에 저장합니다.
2. `Episode` Widget 의 `webtoonId` instance variable 를 정의합니다.
3. `Episode` Widget 의 `onButtonTap` method 를 정의합니다. 이 method 안에 `launchUrlString` 을 작성하고 첫번 째 argument 는 실제 홈페이지에서 참조하여 `'https://m.comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}'` 으로 정의합니다. 그리고 `launchUrlString` 는 비동기이므로 `async` 와 `await` 을 작성합니다.
4. `Episode` Widget 의 `build` method 안에 `Container` 를 [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) 으로 감쌉니다.
5. [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) 의 `onTap` property 의 값을 `onButtonTap` 으로 정의합니다.

정의 된 `Episode` Widget 은 아래와 같습니다, `lib/widgets/episode_widget.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.webtoonId,
    required this.episode,
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  onButtonTap() async {
    await launchUrlString(
        'https://m.comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.shade400,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              episode.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
```

`DetailScreen` Widget 안에서 `Episode` Widget 을 사용할 때, `episode` argument 와 함께 `webtoonId` key 와 `widget.id` value 를 쌍으로 argument 를 전달합니다. 변경 된 `DetailScreen` Widget 은 아래와 같습니다, `lib/screens/detail_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final String thumb;
  final String title;

  const DetailScreen({
    super.key,
    required this.id,
    required this.thumb,
    required this.title,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
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
                        widget.thumb,
                        // BUG: Select Device to chrome - web 선택 후 debugging 시작 시, 동작하지 않음
                        // HACK: #2 NetworkImageLoadException (HTTP request failed, statusCode: 403, https://URL) solution is adding 'User-Agent' headers.
                        headers: const {
                          'Referer': 'https://comic.naver.com',
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(
                            webtoonId: widget.id,
                            episode: episode,
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Troubleshooting

### Troubleshooting for iOS

현상: `NetworkImageLoadException (HTTP request failed, statusCode: 403, https://image-comic.pstatic.net/webtoon/*.jpg)` 가 오류가 발생됩니다.

문제: [`Image.network`](https://api.flutter.dev/flutter/widgets/Image/Image.network.html) constructor 를 이용한 thumb image 를 가져올 때, HTTP 권한 오류가 발생됩니다.

해결: `lib/widgets/webtoon_widget.dart`, `lib/screens/detail_screen.dart` 각 파일 마다 [`Image.network`](https://api.flutter.dev/flutter/widgets/Image/Image.network.html) constructor 찾아 `headers` parameter 추가하고 [`'Referer'`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referer) key 와 `'https://comic.naver.com'` value 추가합니다.

```dart
Image.network(
  widget.thumb,
  headers: const {
   'Referer': 'https://comic.naver.com',
  },
)
```

> [!NOTE]
> 해당 `widget.thumb` 주소로부터 가져올 사진을 저장하고 있는 대상 서버 측의 설정 및 권한의 문제로 생각됩니다.

### Troubleshooting for Web

현상:

- 오늘의 웹툰 목록이 `object ProgressEvent` 로 출력되는 현상입니다.
- VSCode Debug Console 에서는 `Exception caught by image resource service` 또는 `[object ProgressEvent]` 로 출력됩니다.

문제: Debugging 시, Flutter Web renderer 의 기본 값인 `auto` 가 알 수 없는 문제로 잘 동작하지 않는 것으로 예상됩니다.

해결:

```html
<!-- ... -->
<body>
  <script>
    let useHtml = true;

    window.addEventListener("load", function (ev) {
      // Download main.dart.js
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        },
        onEntrypointLoaded: function (engineInitializer) {
          let config = {
            renderer: useHtml ? "html" : "canvaskit",
          };
          engineInitializer.initializeEngine(config).then(function (appRunner) {
            appRunner.runApp();
          });
        },
      });
    });
  </script>
</body>
<!-- </html> -->
```

자세한 내용은 [이 곳](https://docs.flutter.dev/platform-integration/web/renderers#runtime-configuration) 참조바랍니다.

### Troubleshooting for MacOS

현상: 오늘의 웹툰 목록을 불러오지 못하는 현상입니다.

문제:

1. Debugging 을 시작합니다.
2. `HomeScreen` Widget 의 `build` method 안에서 `webtoons` instance variable 를 참조합니다. 이 때, `ApiService` class 의 `getTodaysToons` static method 를 호출합니다.
3. 응답이 없습니다.
4. `ApiService` class 의 `getTodaysToons` static method 안에서 `final response = await http.get(url);` 중단점을 찍어 Debugging 단위실행을 통해 확인해보니, `async.dat` 에서 `OSError (OS Error: Operation not permitted, errno = 1)` 를 확인할 수 있습니다.

해결:

- `macos/Runner/DebugProfile.entitlements` 파일 안에 `com.apple.security.network.client` key 를 추가하고 `true` 값을 추가합니다:

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
      <dict>
          <key>com.apple.security.app-sandbox</key>
          <true />
          <key>com.apple.security.cs.allow-jit</key>
          <true />
          <key>com.apple.security.network.server</key>
          <true />
          <key>com.apple.security.network.client</key>
          <true />
      </dict>
  </plist>
  ```

- `macos/Runner/Release.entitlements` 파일 안에 `com.apple.security.network.client` key 를 추가하고 `true` 값을 추가합니다:

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
      <dict>
          <key>com.apple.security.app-sandbox</key>
          <true />
          <key>com.apple.security.network.client</key>
          <true />
      </dict>
  </plist>
  ```

자세한 내용은 [이 곳](https://docs.flutter.dev/platform-integration/macos/building#setting-up-entitlements)을 참조바랍니다.

## Edited files

실제 변경한 파일은 아래와 같습니다:

```bash
.
├── android
│   └── app
│       └── src
│           └── main
│               └── AndroidManifest.xml  # url_launcher configuration for Android.
├── ios
│   └── Runner
│       └── Info.plist  # url_launcher configuration for iOS.
├── lib  # 6.16. Url Launcher.
│   ├── screens
│   │   └── detail_screen.dart
│   └── widgets
│       └── episode_widget.dart
├── macos
│   └── Runner
│       └── Info.plist  # url_launcher configuration for macOS.
├── web
│   └── index.html  # Troubleshooting for web.
└── pubspec.yaml  # url_launcher install.
```
