import 'package:flutter/material.dart';
import 'package:testflutter/widget/animation_test_widght.dart';
import 'package:testflutter/widget/circle_progress.dart';

import 'view/main_page.dart';

void main() {
  // TargetPlatform? targetPlatform;
  // if (Platform.isMacOS) {
  //   targetPlatform = TargetPlatform.iOS;
  // } else if (Platform.isWindows || Platform.isLinux) {
  //   targetPlatform = TargetPlatform.android;
  // }
  // debugDefaultTargetPlatformOverride = targetPlatform;

  runApp(const TestPage());
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("test"),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: const AnimationTest(),
        ),
    );
  }

  Widget getBody() {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Container(
        width: 400,
        height: 400,
        // color: Colors.black,
        alignment: AlignmentDirectional.center,
        // padding: const EdgeInsets.all(50),
        child: const CirclePaint(),
      ),
    );
  }

  Widget getTextButton() {
    return TextButton(
      child: const Text("按钮"),
      onPressed: () {},
      style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const TextStyle(fontSize: 20);
            } else {
              return const TextStyle(fontSize: 20);
            }
          }
          ),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.lightGreenAccent;
            } else {
              return Colors.greenAccent;
            }
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            } else {
              return Colors.grey;
            }
          }),
          shadowColor: MaterialStateProperty.all(Colors.blue),
          elevation: MaterialStateProperty.all(10),
          minimumSize: MaterialStateProperty.all(const Size(200, 100)),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 10))))
        // overlayColor: MaterialStateProperty.all(Colors.blue)
      ),
    );
  }

}
