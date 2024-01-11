VSCode 사용자 설정 파일에 추가하기, `settings.json`:

```json
{
  // ...
  "[dart]": {
    "editor.codeActionsOnSave": {
      "source.fixAll": "always"
    }
  },
  // ...
  "dart.openDevTools": "flutter",
  "dart.previewFlutterUiGuides": true,
  // https://docs.flutter.dev/tools/vs-code#debugging-external-libraries
  "dart.debugExternalPackageLibraries": true
}
```

저장 후 VSCode 재기동 하기.

참조하기:

- [Flutter tools VSCode](https://docs.flutter.dev/tools/vs-code)
