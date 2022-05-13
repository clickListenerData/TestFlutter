

class HomeArticleBean {
  int curPage = 0;
  int offset = 0;
  bool over = false;
  int pageCount = 0;
  int size = 0;
  int total = 0;
  List<HomeArticle>? datas;

  HomeArticleBean(this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total);

  HomeArticleBean.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      List<HomeArticle> datas = [];
      json['datas'].forEach((v) {
        datas.add(HomeArticle.fromJson(v));
      });
      this.datas = datas;
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

}

class HomeArticle {
  String apkLink = '';
  String author = '';
  int chapterId = 0;
  String chapterName = '';
  bool collect = false;
  int courseId = 0;
  String desc = '';
  String envelopePic = '';
  bool fresh = false;
  int id = 0;
  String link = '';
  String niceDate = '';
  String origin = '';
  String projectLink = '';
  int publishTime = 0;
  int superChapterId = 0;
  String superChapterName = '';
  String title = '';
  int type = 0;
  int userId = 0;
  int visible = 0;
  int zan = 0;
  int originId = 0;
  int audit = 0;

  HomeArticle(this.apkLink,
    this.author,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.envelopePic,
    this.fresh,
    this.id,
    this.link,
    this.niceDate,
    this.origin,
    this.projectLink,
    this.publishTime,
    this.superChapterId,
    this.superChapterName,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan);

  HomeArticle.fromJson(Map<String, dynamic> json) {
    apkLink = json['apkLink'];
    author = json['author'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    collect = json['collect'];
    courseId = json['courseId'];
    desc = json['desc'];
    envelopePic = json['envelopePic'];
    fresh = json['fresh'];
    id = json['id'];
    link = json['link'];
    niceDate = json['niceDate'];
    origin = json['origin'];
    projectLink = json['projectLink'];
    publishTime = json['publishTime'];
    superChapterId = json['superChapterId'];
    superChapterName = json['superChapterName'];
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
    originId = json['originId'] ?? 0;
    audit = json['audit'];
  }
}