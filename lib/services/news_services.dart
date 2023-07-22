import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';
import '../viewmodel/news_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsService {
  Future getNews(BuildContext context) async {
    String url =
        "https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=2hwUBDkPwymNgaEUbSU4o4Z7l32BYRVp";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      NewsModel newsModel = newsModelFromJson(response.body);
      Provider.of<NewsViewModel>(context, listen: false)
          .setNewsModel(newsModel);
    }
  }
}
