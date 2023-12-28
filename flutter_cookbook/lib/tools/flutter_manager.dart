import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum EntryPoint {
  defaultt,
  topMain,
  bottomMain;

  String getName() {
    switch (this) {
      case EntryPoint.defaultt:
        return "default";
      case EntryPoint.topMain:
        return "topMain";
      case EntryPoint.bottomMain:
        return "bottomMain";
    }
  }
}

enum LXFlutterChannel {
  defaultt,
  multiCounter;

  String getChannelName() => "${LXFlutterManager.prefixFlutter}${getName()}";

  String getName() {
    switch (this) {
      case defaultt:
        return "com.lx.flutter_cookbook";
      case LXFlutterChannel.multiCounter:
        return "multiple-counter";
    }
  }
}

enum LXFlutterMultiCounterMethod {
  setCount;

  String getName() {
    var prefix = LXFlutterManager.prefixFlutter;
    var name = "";
    switch (this) {
      case LXFlutterMultiCounterMethod.setCount:
        name = "setCount";
    }
    return "$prefix$name";
  }
}

class LXSwiftMethod {
  final String methodName;
  final dynamic arguments;

  const LXSwiftMethod({
    required String name,
    this.arguments,
  }) : methodName = "${LXFlutterManager.prefixSwift}$name";

  static LXSwiftMethod dismiss() => const LXSwiftMethod(name: "dismiss");
  static LXSwiftMethod gotoStore({
    required String storeCode,
    required String storeType,
  }) =>
      LXSwiftMethod(name: "test", arguments: {
        "storeCode": storeCode,
        "storeType": storeType,
      });
}

class LXFlutterMethod {
  final String methodName;
  final dynamic arguments;

  const LXFlutterMethod({
    required String name,
    this.arguments,
  }) : methodName = "${LXFlutterManager.prefixFlutter}$name";

  static LXFlutterMethod dismiss() => const LXFlutterMethod(name: "dismiss");
  static LXFlutterMethod gotoStore({
    required String storeCode,
    required String storeType,
  }) =>
      LXFlutterMethod(name: "test", arguments: {
        "storeCode": storeCode,
        "storeType": storeType,
      });
}

extension MethodChannelEx on MethodChannel {
  Future<T?> xlInvokeMethod<T>(LXSwiftMethod method) async {
    T? result;
    try {
      debugPrint("-->${method.methodName}: ${method.arguments}");
      result = await invokeMethod(method.methodName, method.arguments);
      // platform.invokeListMethod(method.methodName);
    } on PlatformException catch (e) {
      debugPrint("-->PlatformException: ${e.message}");
    } catch (e) {
      debugPrint("-->Exception: $e");
    }
    return Future(() => result);
  }
}

class LXFlutterManager {
  static const String prefixFlutter = "flutter_";
  static const String prefixSwift = "swift_";
  static const String identifier = "com.lx.flutter_cookbook";
  static final channelDefault = MethodChannel(LXFlutterChannel.defaultt.getChannelName());

  void registerDefaultChannel() {
    var channel = LXFlutterManager.channelDefault;
    debugPrint("-->channelName: ${channel.name}");
    channel.setMethodCallHandler((call) async {
      debugPrint("-->call[${call.method}]: ${call.arguments}");
      // if (call.method == LXFlutterMultiCounterMethod.setCount.getName()) {
      // } else {
      throw Exception("not implemented ${call.method}");
      // }
    });
  }
}
