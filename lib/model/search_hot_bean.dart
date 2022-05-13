

class SearchHotBean {
  int id = 0;
  String link = "";
  String name = "";
  int order = 0;
  int visible = 0;

  SearchHotBean(this.id,this.link,this.name,this.order,this.visible);

  SearchHotBean.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }
}