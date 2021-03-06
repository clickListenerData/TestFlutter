

import 'home_article_bean.dart';

class ShareListBean {

  CoinInfoBean? coinInfo;
  HomeArticleBean? shareArticles;

  ShareListBean.fromJson(Map<String,dynamic> json) {
    coinInfo = CoinInfoBean.fromJson(json['coinInfo']);
    shareArticles = HomeArticleBean.fromJson(json['shareArticles']);
  }

}

class CoinInfoBean {
  int coinCount = 0;
  int level = 0;
  String nickname = '';
  String rank = '';
  int userId = 0;
  String username = '';

  CoinInfoBean.fromJson(Map<String,dynamic> json) {
    coinCount = json["coinCount"];
    level = json["level"];
    nickname = json["nickname"];
    rank = json["rank"];
    userId = json["userId"];
    username = json["username"];
  }
}