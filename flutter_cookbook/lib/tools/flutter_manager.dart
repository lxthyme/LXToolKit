import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum EntryPoint {
  defaultt,
  topMain,
  bottomMain;

  String getName() {
    switch (this) {
      case EntryPoint.defaultt:
        return 'default';
      case EntryPoint.topMain:
        return 'topMain';
      case EntryPoint.bottomMain:
        return 'bottomMain';
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
        return 'com.lx.flutter_cookbook';
      case LXFlutterChannel.multiCounter:
        return 'multiple-counter';
    }
  }
}

enum LXFlutterMultiCounterMethod {
  setCount;

  String getName() {
    var prefix = LXFlutterManager.prefixFlutter;
    var name = '';
    switch (this) {
      case LXFlutterMultiCounterMethod.setCount:
        name = 'setCount';
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
  }) : methodName = '${LXFlutterManager.prefixSwift}$name';

  static LXSwiftMethod undefinedTest({
    required String storeCode,
    required String storeType,
  }) =>
      LXSwiftMethod(name: 'undefinedTest', arguments: {
        'animated': storeCode,
        'storeType': storeType,
      });
  static LXSwiftMethod resultFailureTest({
    required String storeCode,
    required String storeType,
    required String comSid,
  }) =>
      LXSwiftMethod(name: 'resultFailureTest', arguments: {
        'animated': storeCode,
        'storeType': storeType,
        'comSid': comSid,
      });

  /// DefaultScene.dismiss
  static LXSwiftMethod dismiss({
    bool animated = true,
  }) =>
      LXSwiftMethod(name: 'dismiss', arguments: {
        'animated': animated,
      });
  // DefaultScene.push(vcName: String)
  static LXSwiftMethod push({
    required String vcName,
    bool animated = true,
  }) =>
      LXSwiftMethod(name: 'push', arguments: {
        'vcName': vcName,
        'animated': animated,
      });
  // DefaultScene.pop
  static LXSwiftMethod pop({
    bool animated = true,
  }) =>
      const LXSwiftMethod(name: 'pop');
  // DefaultScene.popTo(vcName: String)
  static LXSwiftMethod popTo({
    required String vcName,
    bool animated = true,
  }) =>
      LXSwiftMethod(name: 'popTo', arguments: {
        'vcName': vcName,
        'animated': animated,
      });
  // DefaultScene.popToRoot
  static LXSwiftMethod popToRoot({
    bool animated = true,
  }) =>
      LXSwiftMethod(name: 'popToRoot', arguments: {
        'animated': animated,
      });
  // DefaultScene.setNavHidden(isHidden: Bool)
  static LXSwiftMethod setNavHidden({
    required bool isHidden,
    bool animated = true,
  }) =>
      LXSwiftMethod(name: 'setNavHidden', arguments: {
        'isHidden': isHidden,
        'animated': animated,
      });
  // DefaultScene.toast(message: String, title: String?, imageNamed: UIImage?, duration: TimeInterval = 2, position: ToastPosition = .bottom, completion: ((Bool) -> Void)?)
  static LXSwiftMethod toast({
    required String message,
    String? title,
    String? imageNamed,
    double? duration,
    String? position,
    void Function(bool)? completion,
  }) =>
      LXSwiftMethod(name: 'toast', arguments: {
        'message': message,
        'title': title,
        'imageNamed': imageNamed,
        'duration': duration,
        'position': position,
        'completion': completion,
      });
}

class LXFlutterMethod {
  final String methodName;
  final dynamic arguments;

  const LXFlutterMethod({
    required String name,
    this.arguments,
  }) : methodName = "${LXFlutterManager.prefixFlutter}$name";

  static LXFlutterMethod dismiss() => const LXFlutterMethod(name: 'dismiss');
  static LXFlutterMethod gotoStore({
    required String storeCode,
    required String storeType,
  }) =>
      LXFlutterMethod(name: 'test', arguments: {
        'storeCode': storeCode,
        'storeType': storeType,
      });
}

extension MethodChannelEx on MethodChannel {
  Future<T?> xlInvokeMethod<T>(LXSwiftMethod? method) async {
    if (method == null) {
      return Future(() => null);
    }
    T? result;
    String? message;
    try {
      debugPrint('-->${method.methodName}: ${method.arguments}');
      result = await invokeMethod(method.methodName, method.arguments);
      var success = result as bool;
      if (!success) {
        message = '${method.methodName}方法调用失败! 参数为: ${method.arguments}';
      }
    } on PlatformException catch (e) {
      debugPrint('-->PlatformException: ${e.message}');
      message = 'PlatformException: ${e.message}';
    } catch (e) {
      debugPrint('-->Exception: $e');
      message = 'Exception: $e';
    }
    debugPrint('-->[result]: $result');
    LXSwiftMethod toastScene = LXSwiftMethod.toast(message: '');
    if (message != null && method.methodName != toastScene.methodName) {
      toastScene = LXSwiftMethod.toast(
        message: message,
        title: 'method-${method.methodName}',
        imageNamed: '',
        duration: 1.5,
        position: 'center',
        // completion: (didTap) => debugPrint('${method.methodName}[didTap:$didTap] complection.'),
      );
      unawaited(LXFlutterManager.channelDefault.xlInvokeMethod(toastScene));
    }
    return Future(() => result);
  }
}

class LXFlutterManager {
  static const String prefixFlutter = 'flutter_';
  static const String prefixSwift = 'swift_';
  static const String identifier = 'com.lx.flutter_cookbook';
  static final channelDefault = MethodChannel(LXFlutterChannel.defaultt.getChannelName());

  void registerDefaultChannel() {
    var channel = LXFlutterManager.channelDefault;
    debugPrint('-->channelName: ${channel.name}');
    channel.setMethodCallHandler((call) async {
      debugPrint('-->call[${call.method}]: ${call.arguments}');
      // if (call.method == LXFlutterMultiCounterMethod.setCount.getName()) {
      // } else {
      throw Exception('not implemented ${call.method}');
      // }
    });
  }
}
