# ReadMe

## DSYM

```sh
dwarfdump -u /Users/lxthyme/Library/Developer/Xcode/DerivedData/DJTest-ekxswhvxomdrxxbpthvkqvexrvyt/Build/Products/Debug-iphoneos/DJTest.app.dSYM
```

## flutter

```sh
flutter build ios-framework --cocoapods --no-debug --no-profile --output=../3rd/flutter_cookbook
flutter build ios-framework --cocoapods --output=../3rd/flutter_cookbook
```

#### flutter debug

**replace flutter originial config:**
```sh
ln -s /Users/lxthyme/Desktop/Lucky/Swift/LXToolKit/.flutter.dev/.vscode /Users/lxthyme/Desktop/Lucky/.env/flutter/packages/flutter_tools
ln -s /Users/lxthyme/Desktop/Lucky/Swift/LXToolKit/.flutter.dev/Podfile.copy.tmpl /Users/lxthyme/Desktop/Lucky/.env/flutter/packages/flutter_tools/templates/module/ios/host_app_ephemeral_cocoapods
```

**fixed develop_team always be null:**
`flutter/packages/flutter_tools/lib/src/ios/code_signing.dart`

```flutter
final RegExp _certificateOrganizationalUnitExtractionPattern = RegExp(r'OU = ([a-zA-Z0-9]+)');
```

**DEBUG cmd:**
`flutter/packages/flutter_tools/lib/src/xcode_project.dart`

```flutter
import 'package:flutter_tools/src/base/terminal.dart';
globals.logger.printStatus('-->iosBundleIdentifier: $iosBundleIdentifier', color: TerminalColor.red);
globals.logger.printStatus('-->iosDevelopmentTeam: $iosDevelopmentTeam', color: TerminalColor.red);

# security find-identity -p codesigning -v
# security find-certificate -c ULF86DQVJL -p
# _[{{hasIosDevelopmentTeam}}]_{{iosDevelopmentTeam}}
```

## FirebaseCrashlytics

```sh
/Users/lxthyme/Desktop/Lucky/Swift/LXToolKit/DJTest/Pods/FirebaseCrashlytics/upload-symbols -gsp /Users/lxthyme/Desktop/Lucky/Swift/LXToolKit/DJTest/DJTest/GoogleService-Info.plist -p ios /Users/lxthyme/Library/Developer/Xcode/DerivedData/DJTest-ekxswhvxomdrxxbpthvkqvexrvyt/Build/Products/Debug-iphoneos/DJTest.app.dSYM
```


## 3rd
```sh
ln -s /Users/lxthyme/Desktop/Lucky/Swift/LXToolKit/3rd/BaiLianMobileAppEx/BaiLianMobileAppEx.podspec /Users/lxthyme/Desktop/Lucky/Work/BL/DaoJia

```
