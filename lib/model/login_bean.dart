

class LoginBean {
  bool admin = false;
  int coinCount = 0;
  List<String> collectIds = [];
  String email = '';
  String icon = '';
  int id = 0;
  String nickname = '';
  String password = '';
  String publicName = '';
  String token = '';
  int type = 0;
  String username = '';

  LoginBean.fromJson(Map<String,dynamic> json) {
    admin = json['admin'];
    coinCount = json['coinCount'];
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
    final data = json['collectIds'];
    collectIds = [];
    if (data is List) {
      for (var element in data) {
        collectIds.add(element.toString());
      }
    }


  }
}