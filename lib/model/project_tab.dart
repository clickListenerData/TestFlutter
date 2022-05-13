

class ProjectTab {
  int courseId = 0;
  int id = 0;
  String name = '';
  int order = 0;
  int parentChapterId = 0;
  bool userControlSetTop = false;
  int visible = 0;

  ProjectTab(this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible);

  ProjectTab.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }
}