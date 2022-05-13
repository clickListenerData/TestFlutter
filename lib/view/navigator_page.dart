

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../http/ApiManager.dart';
import '../model/Navigator_list_bean.dart';
import '../model/home_article_bean.dart';
import 'webview_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return NavigatorPageState();
  }
}

class NavigatorPageState extends State<NavigatorPage> {

  List<NaviListBean> datas = [];

  @override
  void initState() {
    super.initState();
    getNaviList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("导航"),
          centerTitle: true,
        ),
        body: ListView.builder(itemBuilder: (context,index) {
          return createTab(datas[index]);
        },itemCount: datas.length,),
      ),
    );
  }


  void getNaviList() async {
    final bean = await ApiManager.instance.getNaviList();
    setState(() {
      datas.clear();
      bean.data?.forEach((element) {
        datas.add(element);
      });
    });
  }

  Widget createTab(NaviListBean data) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: Text(
              data.name,
              style: const TextStyle(fontSize: 16,color: Colors.black),),
          ),
        ),
        Wrap(
          children: createSubList(data.articles),
        )
        /*Wrap(
          children: createSubList(data.children),
        )*/
      ],
    );
  }

  List<Widget> createSubList(List<HomeArticle> list) {
    final widgets = <Widget>[];
    if (list.isEmpty) return widgets;
    for (var element in list) {
      widgets.add(createSubTab(element));
    }
    return widgets;
  }

  Widget createSubTab(HomeArticle data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(data.title, data.link) ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Text(data.title,style: TextStyle(
            fontSize: 12,color: randomColor()),),
      ),
    );
  }

  final colors = [Colors.deepOrangeAccent,Colors.white,Colors.deepPurpleAccent,Colors.black,
    Colors.greenAccent,Colors.cyan,Colors.red,Colors.limeAccent,
  Colors.blue];
  final rng = Random();

  Color randomColor() {
    final index = rng.nextInt(colors.length);
    return colors[index];
  }
}