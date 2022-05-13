

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../http/ApiManager.dart';
import '../../model/home_article_bean.dart';
import '../webview_page.dart';

class PersonArticlePage extends StatefulWidget {
  const PersonArticlePage({Key? key}) : super(key: key);




  @override
  State<StatefulWidget> createState() {
    return PersonArticleState();
  }
}

class PersonArticleState extends State<PersonArticlePage> {

  var curPage = 0;
  List<HomeArticle> datas = [];

  @override
  void initState() {
    super.initState();
    getListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的收藏"),
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (context,index) {
        return buildItemWidget(datas[index]);
      },itemCount: datas.length,),
    );
  }

  void getListData() async {
    final bean = await ApiManager.instance.collectList(curPage);
    if (bean.isSuccess()) {
      setState(() {
        datas.clear();
        bean.data?.datas?.forEach((element) {
          datas.add(element);
        });
      });
    } else {
      Fluttertoast.showToast(msg: bean.errorMsg,fontSize: 16,gravity: ToastGravity.CENTER);
    }
  }

  void delete(HomeArticle article) async {
    final bean = await ApiManager.instance.unCollect(article.id, article.originId);
    if (bean.isSuccess()) {
      setState(() {
        datas.remove(article);
      });
    }
  }

  Widget buildItemWidget(HomeArticle article) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Slidable(child: getBodyContent(article), endActionPane: ActionPane(motion: const ScrollMotion(),children: [
        SlidableAction(
          flex: 2,
          label: "删除",
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          onPressed: (context) { delete(article); },
        )
      ],extentRatio: 0.25,),),
    );
  }

  Widget getBodyContent(HomeArticle article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(article.title, article.link) ));
      },
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
    );
  }
}