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
