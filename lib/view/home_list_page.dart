import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/home_article_bean.dart';
import 'webview_page.dart';

class HomeListItem extends StatelessWidget {
  HomeArticle article;

  HomeListItem(this.article);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(article.link));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(article.title, article.link) ));
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
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
                  style: const TextStyle(color: Colors.black),
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
          ),
        ),
      ),
    );
  }
}
