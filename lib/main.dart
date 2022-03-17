import 'package:flutter/material.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {},
                ),
                hintText: 'Search..',
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.search),
        ),
      )),
    );
  }
}
