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

enum ChannelName {
  defaultt,
  multiCounter;

  String getName() {
    switch (this) {
      case ChannelName.defaultt:
        return "com.lx.flutter_cookbook";
      case ChannelName.multiCounter:
        return "multiple-counter";
    }
  }
}

// class LXFlutterChannel {
//   final EntryPoint entryPoint;
//   final ChannelName channelName;

//   const LXFlutterChannel({
//     required this.entryPoint,
//     required this.channelName,
//   });
// }

enum LXFlutterChannel {
  multiCounter;

  String getChannelName() => "${LXFlutterManager.prefixFlutter}${toString()}";

  MethodChannel getChannel() => MethodChannel(getChannelName());

  @override
  String toString() {
    switch (this) {
      case LXFlutterChannel.multiCounter:
        return "multiple-counter";
      default:
        return "";
    }
  }
}

enum MultiCounterFlutter {
  setCount;

  String getName() {
    // "${LXFlutterManager.prefix}${toString()}";
    var prefix = LXFlutterManager.prefixFlutter;
    var name = "";
    switch (this) {
      case MultiCounterFlutter.setCount:
        name = "setCount";
    }
    return "$prefix$name";
  }
}

class LXFlutterMethod {
  final String methodName;
  final dynamic arguments;

  const LXFlutterMethod({
    required String name,
    this.arguments,
  }) : methodName = "${LXFlutterManager.prefixSwift}$name";

  // LXFlutterMethod(this.methodName, this.arguments)
  //     : this.methodName = methodName,
  //       this.arguments = arguments;

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
  Future<T?> xlInvokeMethod<T>(LXFlutterMethod method) {
    return invokeMethod(method.methodName, method.arguments);
  }
}

class LXFlutterManager {
  static const String prefixFlutter = "flutter_";
  static const String prefixSwift = "swift_";
  static const String identifier = "com.lx.flutter_cookbook";
  static const platform = MethodChannel(LXFlutterManager.identifier);

  static Future<String?> xlInvokeMethod(LXFlutterMethod method) async {
    String? result;
    try {
      debugPrint("-->${method.methodName}: ${method.arguments}");
      result = await platform.invokeMethod(method.methodName, method.arguments);
      // platform.invokeListMethod(method.methodName);
    } on PlatformException catch (e) {
      debugPrint("-->PlatformException: ${e.message}");
    } catch (e) {
      debugPrint("-->Exception: $e");
    }
    return result;
  }
}
