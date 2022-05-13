

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../http/ApiManager.dart';
import '../model/answer_list_bean.dart';
import '../model/project_tab.dart';
import '../model/response_bean.dart';
import 'project_list_page.dart';

class ProjectPage extends StatefulWidget {

  int type;
  AnswerList? answerList;
  ProjectPage(this.type,{Key? key, this.answerList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProjectPageState(type);
  }
}

class ProjectPageState extends State<ProjectPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  List<ProjectTab> tabs = [];
  List<AnswerList> newTabs = [];
  TabController? tabController;

  int type;
  ProjectPageState(this.type);

  @override
  void initState() {
    super.initState();
    if (type == 3) {
      createAnswerListData();
    } else {
      getProjectTabData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (tabs.isEmpty && newTabs.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        TabBar(
            indicator: createIndicator(),
            indicatorColor: Colors.blue,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black45,
            controller: tabController,
            isScrollable: true,
            tabs: createTabs()),
        Expanded(
            flex: 1,
            child: TabBarView(
              controller: tabController,
                children: createList(),
            ))
      ],
    );
  }

  Decoration? createIndicator() {
    if (type == 1) return null;
    return const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    );
  }

  void getProjectTabData() async {
    BaseResponse<List<ProjectTab>> bean;
    if (type == 0) {
      bean = await ApiManager.instance.getProjectTab();
    } else {
      bean = await ApiManager.instance.getWeChatTab();
    }
    setState(() {
      tabs.clear();
      bean.data?.forEach((element) {
        tabs.add(element);
      });
      tabController ??= TabController(length: tabs.length, vsync: this);
    });
  }

  void createAnswerListData() {
    print("answer :: ${widget.answerList == null}");
    setState(() {
      newTabs.clear();
      widget.answerList?.children?.forEach((element) {
        newTabs.add(element);
      });
      print("answer size :: ${newTabs.length}");
      tabController ??= TabController(length: newTabs.length, vsync: this);
    });
  }

  List<Widget> createTabs() {
    final lists = <Widget>[];
    if (type == 3) {
      for (var element in newTabs) {
        lists.add(Tab(text: element.name,));
      }
    } else {
      for (var element in tabs) {
        lists.add(Tab(text: element.name,));
      }
    }
    return lists;
  }

  List<Widget> createList() {
    final lists = <Widget>[];
    if (type == 3) {
      for (var element in newTabs) {
        lists.add(ProjectListPage(element.id,type));
      }
    } else {
      for (var element in tabs) {
        lists.add(ProjectListPage(element.id,type));
      }
    }
    return lists;
  }

  @override
  bool get wantKeepAlive => false;
}