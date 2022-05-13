

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../http/ApiManager.dart';
import '../../model/my_share_list.dart';

class CoinRankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CoinRankState();
  }
}

class CoinRankState extends State<CoinRankPage> {

  int curPage = 1;
  List<CoinInfoBean> datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("积分排行榜"),
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (context,index) => getRankItem(datas[index]),itemCount: datas.length,),
    );
  }

  void getRankData() async {
    final bean = await ApiManager.instance.getRankList(curPage);
    setState(() {
      datas.clear();
      bean.data?.datas.forEach((element) {
        datas.add(element);
      });
    });
  }

  Widget getRankItem(CoinInfoBean bean) {
    return Card(
      margin: const EdgeInsets.only(left: 14,right: 14,top: 8,bottom: 6),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(bean.username,style: const TextStyle(color: Colors.lightBlue,fontSize: 16),),
          ),
          Text("${bean.coinCount}",style: const TextStyle(color: Colors.red,fontSize: 30),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("level:${bean.level}",style: const TextStyle(color: Colors.black,fontSize: 14),),
              Text(bean.rank,style: const TextStyle(color: Colors.orangeAccent,fontSize: 30),)
            ],
          ),
        ],
      ),
    );
  }
}