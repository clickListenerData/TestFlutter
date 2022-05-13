import 'package:flutter/cupertino.dart';

class RefreshList extends StatelessWidget {
  late ListView list;

  RefreshList(this.list,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (drag){
        print(drag.delta);
      },
      child: list,
    );
  }

}