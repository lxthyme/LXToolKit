import 'package:flutter/services.dart';

class Bridge {
  static const platform = MethodChannel("com.lx.flutter_cookbook");

  static Future<String?> invokeMethod(String method, dynamic arguments) async {
    String? result;
    try {
      result = await platform.invokeMethod(method, arguments);
      platform.invokeListMethod(method);
    } on PlatformException catch(e) {
      print("-->PlatformException: ${e.message}");
    }
    return result;
  }

}
