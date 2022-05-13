

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../http/ApiManager.dart';
import '../../model/home_article_bean.dart';
import '../webview_page.dart';

class ShareListPage extends StatefulWidget {
  const ShareListPage({Key? key}) : super(key: key);




  @override
  State<StatefulWidget> createState() {
    return ShareListState();
  }
}

class ShareListState extends State<ShareListPage> {

  var curPage = 1;
  List<HomeArticle> datas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的分享"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(itemBuilder: (context,index) {
            return buildItemWidget(datas[index]);
          },itemCount: datas.length,),
          showLoading(),
        ],
      ),
    );
  }

  Widget showLoading() {
    if (!isLoading) return Container();
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  void getListData() async {
    final bean = await ApiManager.instance.shareList(curPage);
    if (bean.isSuccess()) {
      setState(() {
        isLoading = false;
        datas.clear();
        bean.data?.shareArticles?.datas?.forEach((element) {
          datas.add(element);
        });
      });
    } else {
      Fluttertoast.showToast(msg: bean.errorMsg,fontSize: 16,gravity: ToastGravity.CENTER);
    }
  }

  void delete(HomeArticle article) async {
    setState(() {
      isLoading = true;
    });
    final bean = await ApiManager.instance.deleteShare(article.id);
    if (bean.isSuccess()) {
      setState(() {
        isLoading = false;
        datas.remove(article);
      });
    }
  }

  Widget buildItemWidget(HomeArticle article) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Slidable(child: getBodyContent(article), endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          flex: 2,
          label: "删除",
          backgroundColor: Colors.red,
          icon: Icons.delete,
          foregroundColor: Colors.white,
          onPressed: (context) {
            delete(article);
          },
        )
      ],extentRatio: 0.25,)),
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
              Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(child: Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black,fontSize: 16),
                    ))
                  ],
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
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    article.niceDate,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                 const Padding(padding: EdgeInsets.only(left: 10)),
                 getAudit(article.audit),
                  const Expanded(child: Text("")),
                ],
              )
            ],
          ),
      ),
    );
  }
  
  Widget getAudit(int audit) {
    String auditTxt = "已审核";
    if (audit == 0) {
      auditTxt = "未审核";
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.grey,width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(auditTxt,style: const TextStyle(color: Colors.white,fontSize: 10),),
    );
  }
}