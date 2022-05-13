

import 'dart:math';

import 'package:flutter/material.dart';

import '../http/ApiManager.dart';
import '../model/home_article_bean.dart';
import '../model/search_hot_bean.dart';
import 'home_list_page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {

  String currentKey = "";
  int curPage = 0;
  late TextEditingController controller;

  List<SearchHotBean> hotKeys = [];

  List<HomeArticle> results = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    getSearchHotKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getBarBody(),
      ),
      body: getContentBody(),
    );
  }

  Widget getBarBody() {
    return Container(
      width: 250,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(left: 5)),
          const Icon(Icons.search,color: Colors.grey,size: 18,),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(contentPadding: EdgeInsets.only(top: 0,bottom: 6),hintText: '请输入关键字',border: InputBorder.none),
              onSubmitted: (s) => searchText(0, s),
            ),
          )),
          IconButton(icon: const Icon(Icons.cancel), onPressed: () {
            controller.clear();
          },iconSize: 18,color: Colors.grey,),
        ],
      ),
    );
  }

  Widget getContentBody() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 14,left: 14),
          alignment: Alignment.centerLeft,
          child: const Text("热搜",style: TextStyle(color: Colors.red,fontSize: 16),),
        ),
        const Padding(padding: EdgeInsets.only(top: 14)),
        Wrap(
          children: getHotWrap(),
        ),
        const Padding(padding: EdgeInsets.only(top: 14)),
        Container(
          height: 1,
          color: Colors.grey,
        ),
        Expanded(
            child: ListView.builder(itemBuilder: (context,index) {
          return HomeListItem(results[index]);
        },itemCount: results.length,))
      ],
    );
  }

  List<Widget> getHotWrap() {
    List<Widget> lists = <Widget>[];
    for (var element in hotKeys) {
      lists.add(createSubTab(element));
    }
    return lists;
  }

  final textColors = [Colors.black,Colors.green,Colors.blue,Colors.greenAccent,
    Colors.red,Colors.limeAccent,Colors.orange];
  final bgColors = [Colors.grey,Colors.limeAccent,Colors.deepOrange,Colors.orange];

  final rng = Random();

  Color randomColor(bool isText) {
    final maxSize = isText ? textColors.length : bgColors.length;
    final index = rng.nextInt(maxSize);
    return isText ? textColors[index] : bgColors[index];
  }

  Widget createSubTab(SearchHotBean data) {
    return GestureDetector(
      onTap: () {
        controller.text = data.name;
        searchText(0,data.name);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 4,right: 4,top: 4),
        padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: Text(data.name,style: TextStyle(
            fontSize: 10,color: randomColor(true)),),
      ),
    );
  }

  void getSearchHotKey() async {
    final bean = await ApiManager.instance.getSearchHot();
    setState(() {
      hotKeys.clear();
      bean.data?.forEach((element) {
        hotKeys.add(element);
      });
    });
    print("${bean.errorCode} ,, ${bean.data?.length}");
  }

  void searchText(int page,String key) async {
      currentKey = key;
      curPage = page;
      final bean = await ApiManager.instance.search(page, key);
      setState(() {
        results.clear();
        bean.data?.datas?.forEach((element) {
          results.add(element);
        });
      });
  }
}