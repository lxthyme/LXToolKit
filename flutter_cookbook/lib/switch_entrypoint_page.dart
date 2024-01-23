import 'package:app/app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/main.dart';
import 'package:flutter_unit/app/bloc_wrapper.dart';
import 'package:flutter_unit/app/flutter_unit.dart';
import 'package:gsy_app/app.dart';
import 'package:gsy_app/env/config_wrapper.dart';
import 'package:gsy_app/env/dev.dart';
import 'package:gsy_app/env/env_config.dart';
import 'package:gsy_app/router.dart';

class SwitchEntryPointPage extends StatelessWidget {
  const SwitchEntryPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('switch entrypoin'),
      ),
      body: ListView(
        children: [
          ListTile(
              title: const Text('flutter_cookbook'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const GalleryApp();
                  }),
                );
              }),
          ListTile(
              title: const Text('gsy_app'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfigWrapper(
                        config: EnvConfig.fromJson(config),
                        child: FlutterReduxApp(
                          initialRoute: RouterName.login,
                        )),
                  ),
                );
              }),
          ListTile(
              title: const Text('flutter_unit'),
              onTap: () {
                WidgetsFlutterBinding.ensureInitialized();
                //滚动性能优化 1.22.0
                GestureBinding.instance.resamplingEnabled = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocWrapper(child: FlutterUnit3()),
                  ),
                );
                WindowsAdapter.setSize();
              }),
        ],
      ),
    );
  }
}
