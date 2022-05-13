

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../model/home_article_bean.dart';
import '../view/home_list_page.dart';
import '../view/webview_page.dart';

class ProjectListItem extends StatelessWidget {

  HomeArticle article;
  int type;
  ProjectListItem(this.article,this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type != 0) {  // 无需展示图片
      return HomeListItem(article);
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(article.title, article.link) ));
      },
      child: Card(
        margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              FadeInImage.assetNetwork(
                width: 120,
                  height: 240,
                  placeholder: "images/ic_launcher.png", image: article.envelopePic),
              Expanded(
                flex: 1,
                  child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: descTextBody(),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget descTextBody() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.child_care,
              color: Colors.blue,
              size: 18,
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              article.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            ),
            Expanded(child: Align(
              alignment: Alignment.topRight,
              child: Text(
                article.chapterName,
                maxLines: 1,
              ),
            ))

          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black,fontSize: 15),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            article.desc,
            style: const TextStyle(color: Colors.grey,fontSize: 12),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          children: [
            const Icon(
              Icons.access_time,
              color: Colors.blue,
              size: 15,
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      article.niceDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ))),
          ],
        )
      ],
    );
  }
}