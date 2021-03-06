import 'package:flutter/material.dart';

class CustomFadeAnimationComponent extends StatelessWidget {
  final double delay;
  final Widget child;

  CustomFadeAnimationComponent(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("opacity")
    //       .add(Duration(milliseconds: 200), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 200), Tween(begin: -30.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    return child;
    // ControlledAnimation(
    //   delay: Duration(milliseconds: (200 * delay).round()),
    //   duration: tween.duration,
    //   tween: tween,
    //   child: child,
    //   builderWithChild: (context, child, dynamic animation) => Opacity(
    //     opacity: animation["opacity"],
    //     child: Transform.translate(
    //         offset: Offset(0, animation["translateY"]), child: child),
    //   ),
    // );
  }
}
