

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../http/ApiManager.dart';
import '../model/home_article_bean.dart';
import '../model/response_bean.dart';
import '../widget/project_list_item.dart';

class ProjectListPage extends StatefulWidget {

  int cid;
  int type;
  ProjectListPage(this.cid,this.type, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProjectListState(cid,type);
  }
}

class ProjectListState extends State<ProjectListPage> with AutomaticKeepAliveClientMixin {

  int curPage = 0;
  int cid;
  int type;
  ProjectListState(this.cid,this.type);

  List<HomeArticle> datas = [];

  @override
  void initState() {
    super.initState();
    getProjectList(false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(itemBuilder: (context,index) {
      return ProjectListItem(datas[index],type);
    },itemCount: datas.length);
  }

  void getProjectList(bool isLoad) async {
    BaseResponse<HomeArticleBean> bean;
    if (type == 0) {
      bean = await ApiManager.instance.getProjectList(curPage, cid);
    } else if(type == 1) {
      bean = await ApiManager.instance.getWeChatArticle(curPage, cid);
    } else if(type == 2) {
      bean = await ApiManager.instance.getWeDanArticle(curPage);
    } else {
      bean = await ApiManager.instance.getAnswerDetail(curPage, cid);
    }
    if (bean.isSuccess()) {
      setState(() {
        if (!isLoad) datas.clear();
        bean.data?.datas?.forEach((element) {
          datas.add(element);
        });
        print("project list size::${datas.length},,,$cid");
      });
    }
    print("${bean.errorCode}   ${bean.errorMsg}");
  }

  @override
  bool get wantKeepAlive => true;
}