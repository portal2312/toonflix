[문서](https://docs.flutter.dev/get-started/install) 를 바탕으로 요약하여 작성되었습니다.

## Get the Flutter SDK

문서 대신 [homebrew 의 flutter](https://formulae.brew.sh/cask/flutter)를 사용하여 설치하기.

### Run flutter doctor

설정을 완료하기 위해 설치해야 하는 종속성이 있는지 확인하기(`-v`: 상세보기):

```bash
flutter doctor
```

다음 내용을 실행 시, 종속성을 만족시킬 수 있으므로 넘어가기.

## iOS setup

### Install Xcode

### Set up the iOS simulator

##### Install CocoaPods

먼저 해당 [링크](https://guides.cocoapods.org/using/getting-started.html#installation)를 읽고 설치하기.

## Android setup

### Install Android Studio

문서 처럼 설치 후, `Settings/Languages & Frameworks/Android SDK` 에서 `SDKTools` Tab 에서 `Android SDK Command-line Tools (latest)` 선택 후 설치하기

### Set up the Android emulator

### Agree to Android Licenses

```bash
flutter doctor --android-licenses
```
