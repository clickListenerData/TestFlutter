

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

import '../http/ApiManager.dart';
import '../model/home_article_bean.dart';
import '../model/home_banner_bean.dart';
import 'home_list_page.dart';
import 'webview_page.dart';

const MethodChannel _channel = MethodChannel("xz/wan_android/test");
const EventChannel _eventChannel = EventChannel("xz/wan_android/test");

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  List<HomeBannerBean> banners = [];
  List<HomeArticle> articles = [];

  int curPage = 0;

  SwiperController swiperControl = SwiperController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getHomeData();

    swiperControl.autoplay = true;
    scrollController.addListener(() {
      var maxScroll = scrollController.position.maxScrollExtent;
      var pixels = scrollController.position.pixels;
      if (maxScroll == pixels) {
        curPage++;
        getHomeArticles(true);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(itemBuilder: (context,index){
      if (index ==0) {
        return createBannerItem();
      } else {
        return HomeListItem(articles[index - 1]);
      }
    },itemCount: articles.length + 1,controller: scrollController,);
  }

  void getHomeData() async {
    curPage = 0;
    final data = await ApiManager.instance.getHomeBanner();
    if (data.isSuccess()) {
      setState(() {
        banners.clear();
        data.data?.forEach((element) {
          banners.add(element);
        });
      });
    }
    print("banner size::${banners.length} ,, ${data.errorMsg}");
    getHomeArticles(false);
  }

  void getHomeArticles(bool isLoad) async {
    final bean = await ApiManager.instance.getHomeArticle(curPage);
    if (bean.isSuccess()) {
      setState(() {
        if (!isLoad) articles.clear();
        bean.data?.datas?.forEach((element) {
          articles.add(element);
        });
      });
      print(bean.data?.datas?.length);
    } else {
      print(bean.errorMsg);
    }
  }

  Widget createBannerItem() {
    return Container(
      margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: banners.isNotEmpty ? Swiper(
        layout: SwiperLayout.DEFAULT,
        onTap: (index) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(banners[index].title, banners[index].url) ));
        },
        autoplayDelay: 3000,
        controller: swiperControl,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: 200,
        pagination: pagination(),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            banners[index].imagePath,
            fit: BoxFit.fill,
          );
        },
        itemCount: banners.length,
        // viewportFraction: 0.8,
        // scale: 0.9,
      )
      : const SizedBox(
        width: 0,
        height: 0,
      )
    );
  }

  SwiperPagination pagination() => SwiperPagination(
    margin: const EdgeInsets.all(0),
    builder:SwiperCustomPagination(builder: (context,config) {
      return Container(
        color: Colors.black45,
        height: 40,
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(banners[config.activeIndex].title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14.0,color: Colors.white),),),
            Align(
              alignment: Alignment.centerRight,
              child: const DotSwiperPaginationBuilder(
                  color: Colors.white70,
                  activeColor: Colors.blue,
                  size: 6.0,
                  activeSize: 6.0
              ).build(context, config),
            )

          ],
        ),
      );
    })
  );

  @override
  bool get wantKeepAlive => true;

  void invokeMethod() {
    _channel.invokeMethod("test",{"key":0}).then((value) => {
      if(value is bool) {

      } else if (value is int) {

      } else {

      }
    });

    var streamSub = _eventChannel.receiveBroadcastStream().listen((event) {

    });

    streamSub.cancel();
  }


}