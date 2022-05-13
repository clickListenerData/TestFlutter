

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/answer_list_bean.dart';
import 'project_page.dart';

class ArticleListPage extends StatefulWidget {

  AnswerList answerList;

  ArticleListPage(this.answerList, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ArticleListState();
  }
}

class ArticleListState extends State<ArticleListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.answerList.name),
        centerTitle: true,
      ),
      body: ProjectPage(3,answerList: widget.answerList),
    );
  }
}