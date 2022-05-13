

import 'package:flutter/material.dart';

import '../widget/slide_container.dart';
import 'answer_list_page.dart';
import 'drawer_page.dart';
import 'home_page.dart';
import 'navigator_page.dart';
import 'person/person_article_page.dart';
import 'person/person_coin_page.dart';
import 'person/share_list_page.dart';
import 'project_list_page.dart';
import 'project_page.dart';
import 'search_page.dart';

class MainLessPage extends StatelessWidget {
  const MainLessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/" : (context) => const MainPage(),
        "/person/article": (context) => const PersonArticlePage(),
        "/person/share": (context) => const ShareListPage(),
        "/person/coin": (context) => const PersonCoinPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {

  var currentIndex = 0;
  late PageController pageCtr;

  final titles = ["首页","项目","体系","公众号","问答"];

  final GlobalKey<ContainerState> _slideKey = GlobalKey<ContainerState>();

  double get maxSlideDistance => MediaQuery.of(context).size.width * 0.7;

  bool centerTitle = true;

  double get maxHeight => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    pageCtr = PageController(initialPage: 0,keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
    pageCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return getBody();
  }

  void onTap(int index,bool isPage) {
    setState(() {
      currentIndex = index;
      if(!isPage) pageCtr.jumpToPage(currentIndex);
    });
  }

  Widget getBody() {
    return SlideStack(
        SlideContainer(
      getBodyContainer(),
      key: _slideKey,
      drawerSize: maxSlideDistance,
      onSlide: (value) {
        _slideKey.currentState?.setContainerHeight((maxHeight * (1 - value / 5)));
        _slideKey.currentState?.heightOffset = maxHeight * value / 10;
      },
      // transform: Matrix4.translationValues(0.0,height * position / 10, 0.0),
    ), const PersonPage());
  }

  Widget getBodyContainer() {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.person_pin,color: Colors.green),
          onTap: () {
            _slideKey.currentState?.openOrClose();
          },
        ),
        title: Text(titles[currentIndex]),
        centerTitle: centerTitle,
        backgroundColor: Colors.blue,
        shadowColor: Colors.grey,
        elevation: 10,
      ),
      body: PageView(
        controller: pageCtr,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) => onTap(index, true),
        children: [
          const HomePage(),
          ProjectPage(0),
          const AnswerListPage(),
          ProjectPage(1),
          ProjectListPage(0, 2),
        ],
      ),
      endDrawer: const NavigatorPage(),
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 100,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        onTap: (index) => onTap(index, false),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home),label: titles[0]),
          BottomNavigationBarItem(icon: const Icon(Icons.map),label: titles[1]),
          BottomNavigationBarItem(icon: const Icon(Icons.request_quote),label: titles[2]),
          BottomNavigationBarItem(icon: const Icon(Icons.contact_mail),label: titles[3]),
          BottomNavigationBarItem(icon: const Icon(Icons.question_answer),label: titles[4]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage() ));
        },
        tooltip: 'search',
        child: const Icon(Icons.search),
      ),
    );
  }

}