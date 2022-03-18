import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/screens/SearchScreen.dart';
import 'package:news_app/screens/NewsInfoScreen.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const NewsApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
    ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => SearchScreen(),
        '/info': (context) => NewsInfoScreen(),
      },
      initialRoute: '/',
    );
  }
}