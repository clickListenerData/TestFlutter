/**
 * "children":[],
 * "courseId":13,
 * "id":60,
 * "name":"Android Studio相关",
 * "order":1000,
 * "parentChapterId":150,
 * "userControlSetTop":false,
 * "visible":1
 */
class AnswerList {

  int courseId = 0;
  int id = 0;
  String name = "";
  int order = 0;
  int parentChapterId = 0;
  bool userControlSetTop = false;
  int visible = 0;
  List<AnswerList>? children;

  AnswerList(this.courseId,this.id,this.name,this.order,this.parentChapterId,this.userControlSetTop,this.visible);

  AnswerList.fromJson(Map<String,dynamic> json) {
      courseId = json['courseId'];
      id = json['id'];
      name = json['name'];
      order = json['order'];
      parentChapterId = json['parentChapterId'];
      userControlSetTop = json['userControlSetTop'];
      visible = json['visible'];
      final data = json['children'];
      if (data is List && data.isNotEmpty) {
        final lists = <AnswerList>[];
        for (var element in data) {
          lists.add(AnswerList.fromJson(element));
        }
        children = lists;
      }
  }
}