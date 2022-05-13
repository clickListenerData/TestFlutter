

import 'home_article_bean.dart';

class NaviListBean {
  List<HomeArticle> articles = [];
  int cid = 0;
  String name = '';

  NaviListBean(this.cid,this.name);

  NaviListBean.fromJson(Map<String,dynamic> json) {
    cid = json['cid'];
    name = json['name'];
    final data = json['articles'];
    if (data is List) {
      articles = [];
      for (var element in data) {
        articles.add(HomeArticle.fromJson(element));
      }
    }
  }
}