import 'package:flutter/material.dart';
import '../model/news_model.dart';

class NewsViewModel extends ChangeNotifier{
  NewsModel? _newsModel;
  NewsModel? get newsModel => _newsModel;

  void setNewsModel(NewsModel newsModel){
    _newsModel = newsModel;
    notifyListeners();
  }
}