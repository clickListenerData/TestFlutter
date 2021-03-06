
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/sp_const_key.dart';
import '../../http/ApiManager.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {

  late TextEditingController userController;
  late TextEditingController pwdController;
  late TextEditingController confirmController;
  GlobalKey formKey = GlobalKey<FormState>();

  bool isRegister = false;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    pwdController = TextEditingController();
    confirmController = TextEditingController();
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      onSaved: saveUser,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      controller: confirmController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),hintText: "请确认密码",labelText: "确认密码",
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.circular(10))),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.all(Radius.circular(10))),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      validator: (v) {
                        return v?.isNotEmpty == true && v!.trim().length > 5 ? (v == pwdController.text) ? null : "密码不一致" : "密码不能少于6位";
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(top: 14)),
                    Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: const Text("注册"),
                          color: Colors.cyanAccent,
                          textColor: Colors.white,
                          onPressed: register)
                      ,)
                  ],
                )
            ),
          ),
          showIsLogin()
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget showIsLogin() {
    if (!isRegister) return Container();
    return Container(
      color: Colors.black38,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  void register() async {
    final state = formKey.currentState as FormState;
    if (state.validate()) {
      setState(() {
        isRegister = true;
      });
      final bean = await ApiManager.instance.register(userController.text, pwdController.text, confirmController.text);
      if (bean.isSuccess()) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          isRegister = false;
        });
        Fluttertoast.showToast(msg: bean.errorMsg,fontSize: 16,gravity: ToastGravity.CENTER);
      }
    }
  }

  void saveUser(String? user) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(SpConst.USER_NAME, user ?? '');
  }
}