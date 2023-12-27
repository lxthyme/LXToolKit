import 'package:dual_screen/dual_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cookbook/daily/daily_demos.dart';
import 'package:flutter_cookbook/daily/widgets-intro/Counter.dart';
import 'package:flutter_cookbook/daily/widgets-intro/hw3.dart';
import 'package:flutter_cookbook/daily/widgets-intro/multiCounter.dart';
import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/data/gallery_options.dart';
import 'package:flutter_cookbook/gallery/firebase_options.dart';
// import 'package:flutter_cookbook/gallery/galleryRoot.dart';
import 'package:flutter_cookbook/gallery/layout/adaptive.dart';
import 'package:flutter_cookbook/gallery/pages/backdrop.dart';
import 'package:flutter_cookbook/gallery/pages/splash.dart';
import 'package:flutter_cookbook/gallery/routes.dart';
import 'package:flutter_cookbook/gallery/themes/gallery_theme_data.dart';
// import 'package:flutter_cookbook/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

void main() async {
  // runApp(const MyApp());
  GoogleFonts.config.allowRuntimeFetching = false;
  await GetStorage.init();

  if (defaultTargetPlatform != TargetPlatform.linux &&
      defaultTargetPlatform != TargetPlatform.windows &&
      defaultTargetPlatform != TargetPlatform.macOS) {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // FlutterError.onError = (details) {
    //   FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    // };
    // PlatformDispatcher.instance.onError = (exception, stackTrace) {
    //   FirebaseCrashlytics.instance.recordError(exception, stackTrace, fatal: true);
    //   return true;
    // };
  }
  runApp(const GalleryApp());
  // runApp(const MyScaffold());
  // runApp(const MultiCounter(color: Colors.blue));
}
@pragma('vm:entry-point')
void topMain() => runApp(const MultiCounter(color: Colors.blue));
@pragma('vm:entry-point')
void bottomMain() => runApp(const MultiCounter(color: Colors.green));

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.initialRoute,
    this.isTestMode = false,
  });

  final String? initialRoute;
  final bool isTestMode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: Text(
    //     'Hello, world!',
    //     textDirection: TextDirection.ltr,
    //   ),
    // );
    // return MaterialApp.router(
    //   routerConfig: lx_router,
    // );
    final hasHinge = MediaQuery.of(context).hinge?.bounds != null;
    return MaterialApp(
        restorationScopeId: 'rootGallery',
        title: 'Flutter Gallery',
        debugShowCheckedModeBanner: true,
        // themeMode: ,
        // theme: ,
        // darkTheme: ,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          LocaleNamesLocalizationsDelegate(),
        ],
        initialRoute: initialRoute,
        supportedLocales: AppLocalizations.supportedLocales,
        // locale: ,
        // localeListResolutionCallback:(locales, supportedLocales) => {
        //   return basicLocaleListResolution(locales, supportedLocales);
        // },
        onGenerateRoute: (settings) => RouteConfiguration.onGenerateRoute(settings, hasHinge),
        // );
        // return MaterialApp(
        //   title: 'Flutter Demo',
        //   theme: ThemeData(
        //     // This is the theme of your application.
        //     //
        //     // TRY THIS: Try running your application with "flutter run". You'll see
        //     // the application has a blue toolbar. Then, without quitting the app,
        //     // try changing the seedColor in the colorScheme below to Colors.green
        //     // and then invoke "hot reload" (save your changes or press the "hot
        //     // reload" button in a Flutter-supported IDE, or press "r" if you used
        //     // the command line to start the app).
        //     //
        //     // Notice that the counter didn't reset back to zero; the application
        //     // state is not lost during the reload. To reset the state, use hot
        //     // restart instead.
        //     //
        //     // This works for code too, not just values: Most code changes can be
        //     // tested with just a hot reload.
        //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //     useMaterial3: true,
        //   ),
        //   routes: routes,
        //   // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        //   // home: const SafeArea(child: MyScaffold()),
        home: const TutorialHome()
        // home: const GalleryRootPage()
        //   // home: const MyButton(),
        // home: const Counter(),
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({
    super.key,
    this.initialRoute,
    this.isTestMode = false,
  });

  final String? initialRoute;
  final bool isTestMode;

  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: GalleryOptions(
        themeMode: ThemeMode.system,
        textScaleFactor: systemTextScaleFactorOption,
        customTextDirection: CustomTextDirection.localeBased,
        locale: null,
        timeDilation: timeDilation,
        platform: defaultTargetPlatform,
        isTestMode: isTestMode,
      ),
      child: Builder(
        builder: (context) {
          final options = GalleryOptions.of(context);
          final hasHinge = MediaQuery.of(context).hinge?.bounds != null;
          debugPrint('-->initialRoute: $initialRoute');
          return MaterialApp(
            restorationScopeId: 'rootGallery',
            title: 'Flutter Gallery',
            debugShowCheckedModeBanner: true,
            themeMode: options.themeMode,
            theme: GalleryThemeData.lightThemeData.copyWith(
              platform: options.platform,
            ),
            darkTheme: GalleryThemeData.darkThemeData.copyWith(
              platform: options.platform,
            ),
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              LocaleNamesLocalizationsDelegate(),
            ],
            initialRoute: initialRoute,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: options.locale,
            localeListResolutionCallback: (locales, supportedLocales) {
              deviceLocale = locales?.first;
              return basicLocaleListResolution(locales, supportedLocales);
            },
            onGenerateRoute: (settings) => RouteConfiguration.onGenerateRoute(settings, hasHinge),
            onUnknownRoute: (settings) {
              debugPrint('-->onUnknownRoute: ${settings.name}\t${settings.arguments}\n${settings.toString()}');
            },
          );
        },
      ),
    );
  }
}

class GalleryRootPage extends StatelessWidget {
  const GalleryRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplyTextOptions(
      child: SplashPage(
        child: Backdrop(
          isDesktop: isDisplayDesktop(context),
        ),
      ),
    );
  }
}
