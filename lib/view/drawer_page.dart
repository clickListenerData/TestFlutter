

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/sp_const_key.dart';
import '../http/ApiManager.dart';
import '../model/login_bean.dart';
import 'person/login_register_page.dart';

class _MenuInfo {
  final String title;
  final IconData icon;

  _MenuInfo(this.title, this.icon);
}

final List<_MenuInfo> menus = [
  _MenuInfo('个人积分', Icons.account_balance_wallet),
  _MenuInfo('TODO', Icons.today_outlined),
  _MenuInfo('我的收藏', Icons.collections),
  _MenuInfo('我的分享', Icons.folder_shared_rounded),
  _MenuInfo('设置', Icons.settings),
  _MenuInfo('退出登录', Icons.logout),
];

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersonPageState();
  }
}

class PersonPageState extends State<PersonPage> {

  String userName = " WAN ANDROID ";
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    initUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,Colors.cyanAccent,Colors.green
                ],begin: Alignment.topLeft,end: Alignment.bottomRight,
              ),
          ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 80,top: 60),
        child: GestureDetector(
          onTap: routeLogin,
          child: Column(
            children: [
              Image.asset("images/ic_launcher_round.png"),
              const Padding(padding: EdgeInsets.only(top: 14)),
              Text(userName,style: const TextStyle(fontSize: 14,color: Colors.black),),
            ],
          ),
        ),
      ), preferredSize: Size(MediaQuery.of(context).size.width, 200)),
      body: ListView.builder(itemBuilder: (context,index) {
        if (index == 0) {
          return const SizedBox(height: 40,);
        }
        return InkWell(
          onTap: () {
            listItemClick(index - 1);
          },
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top:14)),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Icon(menus[index - 1].icon,size: 20,color: Colors.grey,),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Text(menus[index - 1].title,style: const TextStyle(color: Colors.black87,fontSize: 20),)
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 14)),
              Container(color: Colors.grey,height: 1,margin: const EdgeInsets.only(left: 20),)
            ],
          ),
        );
      },itemCount: menus.length + 1,),
    );
  }

  void routeLogin() async {
    final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
    if (result is LoginBean) {
      setState(() {
        isLogin = true;
        userName = result.nickname;
      });
    }
  }

  void listItemClick(int index) {
    if (!isLogin && index != menus.length - 2) {
      Fluttertoast.showToast(msg: "请先登录",fontSize: 16,gravity: ToastGravity.CENTER);
      return;
    }
    if (index == menus.length - 1) {
      showLogoutConfirm();
      return;
    }
    if(index == 2) Navigator.pushNamed(context, "/person/article");
    if(index == 3) Navigator.pushNamed(context, "/person/share");
    if (index == 0) Navigator.pushNamed(context, "/person/coin");

  }

  void showLogoutConfirm() async {
    await showDialog(context: context,builder: (context) => AlertDialog(
      title: const Text("退出登录"),
      content: const Text("确认退出登录吗？"),
      actions: [
        RaisedButton(onPressed: () {
          Navigator.of(context).pop();
        },child: const Text("取消",style: TextStyle(color: Colors.grey),),),
        RaisedButton(onPressed: () {
          ApiManager.instance.logout().then((value) {
            Navigator.of(context).pop();
            if (value.isSuccess()) {
              setState(() {
                isLogin = false;
                userName = " WAN ANDROID ";
              });
            } else {
              Fluttertoast.showToast(msg: value.errorMsg,fontSize: 16,gravity: ToastGravity.CENTER);
            }
          });
        },child: const Text("确认",style: TextStyle(color: Colors.blue),),)
      ],
    ));
  }

  void initUserName() async {
    final sp = await SharedPreferences.getInstance();
    final name = sp.getString(SpConst.NICK_NAME);
    final login = sp.getBool(SpConst.IS_LOGIN);
    if (name?.isNotEmpty == true) {
      setState(() {
        userName = name ?? '';
        isLogin = login ?? false;
      });
    }
  }


}