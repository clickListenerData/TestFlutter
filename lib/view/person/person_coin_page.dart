

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../http/ApiManager.dart';
import '../../model/coin_list_bean.dart';
import '../../model/my_share_list.dart';
import '../../model/response_bean.dart';
import 'coin_rank_page.dart';

class PersonCoinPage extends StatefulWidget {
  const PersonCoinPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersonCoinState();
  }
}

class PersonCoinState extends State<PersonCoinPage> {

  int curPage = 1;
  bool isShow = false;

  CoinInfoBean? info;
  List<CoinItemBean> datas = [];

  @override
  void initState() {
    super.initState();
    getCoinData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人积分"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CoinRankPage()));
            },
            child: const Icon(Icons.leaderboard),
          )
        ],
      ),
      body: showBody(),
    );
  }

  Widget showBody() {
    if (isShow) {
      return Column(
        children: [
          coinDetail(),
          Container(
            margin: const EdgeInsets.only(top: 14,left: 14),
            alignment: Alignment.topLeft,
            child: const Text("积分获取列表",style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20),),),
          Expanded(child: ListView.builder(itemBuilder: (context,index) => getCoinItem(datas[index]),itemCount: datas.length,))
        ],
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }
  }

  void getCoinData() async {
    final personCoin = await ApiManager.instance.getPersonCoin();
    BaseResponse<CoinListBean<CoinItemBean>> coinList = await ApiManager.instance.getCoinList(curPage);
    setState(() {
      isShow = true;
      datas.clear();
      info = personCoin.data;
      coinList.data?.datas.forEach((element) {
        datas.add(element);
      });
    });
  }

  Widget coinDetail() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue,Colors.lightBlueAccent,Colors.cyanAccent
          ],begin: Alignment.topLeft,end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getColumnTxt("${info?.coinCount}","积分",48,25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getColumnTxt("${info?.level}","等级",36,16),
              getColumnTxt("${info?.rank}","排名",36,16)
            ],
          ),
        ],
      ),
    );
  }

  Widget getColumnTxt(String main,String cross,double mainSize,double crossSize) {
    return Column(
      children: [
        Text(main,style: TextStyle(color: Colors.white,fontSize: mainSize),),
        Text(cross,style: TextStyle(color: Colors.white60,fontSize: crossSize),),
      ],
    );
  }

  Widget getCoinItem(CoinItemBean item) {
    return Card(
      margin: const EdgeInsets.only(left: 14,right: 14,top: 6,bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(top: 10,left: 14),child: Text(item.reason,style: const TextStyle(color: Colors.black,fontSize: 14),),),
          Padding(padding: const EdgeInsets.only(top: 4,left: 14,bottom: 5),child: Text(item.desc,style: const TextStyle(color: Colors.blueGrey,fontSize: 10),),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.only(left: 14),child: Text(DateTime.fromMicrosecondsSinceEpoch(item.date * 1000).toString(),style: const TextStyle(color: Colors.blue,fontSize: 12),),),
              Padding(padding: const EdgeInsets.only(right: 14,bottom: 10),child: Text("获取积分：${item.coinCount}",style: const TextStyle(color: Colors.lightBlueAccent,fontSize: 12)),),
            ],
          )
        ],
      ),
    );
  }

}