
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/sp_const_key.dart';
import '../../http/ApiManager.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {

  late TextEditingController userController;
  late TextEditingController pwdController;
  GlobalKey formKey = GlobalKey<FormState>();

  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    pwdController = TextEditingController();

    initUserText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 14,right: 14),
            alignment: Alignment.center,
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    TextFormField(
                      controller: userController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),hintText: "请输入用户名",labelText: "用户名",
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.circular(10))),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.all(Radius.circular(10))),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      validator: (v) {
                        return v?.isNotEmpty == true ? null : "用户名不能为空";
                      },
                      onSaved: (s){
                        saveUser(s ?? "");
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    TextFormField(
                      obscureText: true,
                      controller: pwdController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),hintText: "请输入密码",labelText: "密码",
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.circular(10))),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.all(Radius.circular(10))),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      validator: (v) {
                        return v?.isNotEmpty == true && v!.trim().length > 5 ? null : "密码不能少于6位";
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(top: 14)),
                    Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: const Text("登录"),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final state = formKey.currentState as FormState;
                            bool validate = state.validate();
                            if(validate) {
                              login(userController.text, pwdController.text);
                            }
                          }),),
                    const Padding(padding: EdgeInsets.only(top: 14)),
                    Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: const Text("注册"),
                          color: Colors.cyanAccent,
                          textColor: Colors.white,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                          })
                      ,)
                  ],
                )
            ),
          ),
          showIsLogin(),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget showIsLogin() {
    if (!isLogin) return Container();
    return Container(
      color: Colors.black38,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  void login(String userName,String password) async {
    setState(() {
      isLogin = true;
    });
    final response = await ApiManager.instance.login(userName, password);
    // print("login response ::: ${response.data} ,, ${response.headers}");
    final sp = await SharedPreferences.getInstance();
    if (response.isSuccess()) {
      sp.setString(SpConst.PUBLIC_NAME, response.data?.publicName ?? '');
      sp.setString(SpConst.NICK_NAME, response.data?.nickname ?? '');
      sp.setString(SpConst.USER_NAME, response.data?.username ?? '');
      sp.setBool(SpConst.IS_LOGIN, true);
      Navigator.of(context).pop(response.data);
    } else {
      setState(() {
        isLogin = false;
      });
      Fluttertoast.showToast(msg: response.errorMsg,fontSize: 16,gravity: ToastGravity.CENTER);
    }
  }

  void initUserText() async {
    final sp = await SharedPreferences.getInstance();
    final user = sp.getString(SpConst.USER_NAME);
    userController.text = user ?? '';
  }

  void saveUser(String user) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(SpConst.USER_NAME, user);
  }
}