

import 'package:flutter/cupertino.dart';

class WeChatPage extends StatefulWidget {
  const WeChatPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return WeChatPageState();
  }
}

class WeChatPageState extends State<WeChatPage> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    super.build(context);
    return const Center(
      child: Text("we chat page"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}