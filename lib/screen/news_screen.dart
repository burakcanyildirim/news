import 'package:flutter/material.dart';
import 'package:news/screen/webview_screen.dart';
import 'package:news/services/news_services.dart';
import 'package:provider/provider.dart';
import '../viewmodel/news_viewmodel.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    getNews();
    super.initState();
  }

  Future getNews() async {
    await NewsService().getNews(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "NY Times",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<NewsViewModel>(
        builder: (context, newsViewModel, _) {
          if (newsViewModel.newsModel != null) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18.0,
                mainAxisSpacing: 18.0,
                childAspectRatio: 0.6,
              ),
              itemCount: newsViewModel.newsModel!.results.length,
              itemBuilder: (context, index) {
                final result = newsViewModel.newsModel!.results[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewsScreen(
                                  url: result.url,
                                )));
                  },
                  child: Card(
                    color: Colors.teal,
                    elevation: 2.0,
                    child: Center(
                      child: Column(
                        children: [
                          Expanded(
                              child: Image.network(
                                  result.media[0].mediaMetadata[0].url,
                                  fit: BoxFit.cover)),
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                result.title,
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
