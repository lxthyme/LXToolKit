// import 'dart:js';

import 'package:flutter_cookbook/gallery/cupertino/list/cupertino_activity_indicator_demo.dart';
import 'package:flutter_cookbook/list.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cookbook/daily/widgets-intro/Counter.dart';
import 'package:flutter_cookbook/daily/widgets-intro/MyButton.dart';
import 'package:flutter_cookbook/daily/widgets-intro/hw2.dart';
import 'package:flutter_cookbook/daily/widgets-intro/hw3.dart';

final Map<String, WidgetBuilder> routes = {
  // '/': ctx =>
  // '/daily/widgets-intro/helloworld':
  '/daily/widgets-intro/hw2': (ctx) => const MyScaffold(),
  '/daily/widgets-intro/hw3': (ctx) => const TutorialHome(),
  '/daily/widgets-intro/mybutton': (ctx) => const MyButton(),
  '/daily/widgets-intro/counter': (ctx) => const Counter(),
  // '/daily/widgets-intro/':,
};

// static Map<String, Widget> routerList = {
//   '/daily/widgets-intro/hw2': MyScaffold
// }

final lx_router = GoRouter(routes: [
  // GoRoute(path: '/'),
  GoRoute(path: '/', builder: (context, state) => const MainList()),
  GoRoute(path: '/daily/widgets-intro/hw2', builder: (context, state) => const MyScaffold()),
  GoRoute(path: '/daily/widgets-intro/hw3', builder: (context, state) => const TutorialHome()),
  GoRoute(path: '/daily/widgets-intro/mybutton', builder: (context, state) => const MyButton()),
  GoRoute(path: '/daily/widgets-intro/counter', builder: (context, state) => const Counter()),
  GoRoute(path: '/gallery/cupertino/list/cupertino_activity_indicator_demo', builder: (context, state) => const CupertinoProgressIndicatorDemo()),
]);
