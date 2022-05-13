
import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  const AnimationTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnimationState();
  }

}

class AnimationState extends State<AnimationTest> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  final Tween<double> sizeTween = Tween(begin: 0.0,end: 300.0);
  final Tween<double> opacityTween = Tween(begin: 0.1,end: 1.0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
            ..addListener(() {
              setState(() {

              });
            })
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                controller.reverse();
              } else if (status == AnimationStatus.dismissed) {
                controller.forward();
              }
            });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: opacityTween.evaluate(animation),
        child: Container(
          width: sizeTween.evaluate(animation),
          height: sizeTween.evaluate(animation),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const FlutterLogo(),
        ),
      ),
    );
  }

}

class AnimatedWidgetTest extends AnimatedWidget {
  const AnimatedWidgetTest({required Listenable listenable}) : super(listenable: listenable);

  @override
  Widget build(BuildContext context) {
    return const Center();
  }

}