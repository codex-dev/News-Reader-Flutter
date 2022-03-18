import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_feed.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  _appBar(height, context) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              // Background
              child: const Center(
                child: Text(
                  "News Feed",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              color: Theme.of(context).primaryColor,
              height: height + 100,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
                // To take AppBar Size only
                top: 100.0,
                left: 20.0,
                right: 20.0,
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextField(
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                //TODO search action goes here
                                getNewsFeed();
                              },
                            ),
                            hintText: 'Search..',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(10.0)),
                        textInputAction: TextInputAction.search),
                  ),
                ))
          ],
        ),
      );

  int currentPage = 1;
  String query = 'apple';
  final String API_KEY = 'cec0a4b71e234f658153457823545ade';
  List<Article> articles = [];

  Future<bool> getNewsFeed() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$query&sortBy=relevancy&language=en&page=$currentPage&pageSize=20&apiKey=$API_KEY');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = newsFeedFromJson(response.body);

      articles = result.articles;
      currentPage++;
      print(response.body);

      setState(() {});

      return true;
    } else {
      return false;
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getNewsFeed();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height, context),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final article = articles[index];
            return ListTile(
              title: Padding(
                child: Text(
                  article.title,
                  maxLines: 2,
                ),
                padding: const EdgeInsets.only(bottom: 10.0),
              ),
              subtitle: Text(
                article.description,
                maxLines: 3,
                textAlign: TextAlign.justify,
              ),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(article.urlToImage),
                backgroundColor: Colors.transparent,
              ),
              onTap: () {
                //TODO item click
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: articles.length),
    );
  }
}
