import 'package:flutter/material.dart';

class SlideRight extends PageRouteBuilder {
  final page;
  SlideRight({this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionsBuilder: (context, animation, animationTwo, child) {
            const begin = Offset(-1, 0);
            const end = Offset.zero;
            final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
            // final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));
            final tween = Tween(begin: begin, end: end);
            // final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}

class SlideUp extends PageRouteBuilder {
  final page;
  SlideUp({this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionsBuilder: (context, animation, animationTwo, child) {
            const begin = Offset(0, 1);
            const end = Offset.zero;
            final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
            final tween = Tween(begin: begin, end: end);
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}

class Scale extends PageRouteBuilder {
  final page;
  Scale({this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionsBuilder: (context, animation, animationTwo, child) {
            const begin = 0.0;
            const end = 1.0;
            final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
            final tween = Tween(begin: begin, end: end);
            return ScaleTransition(
              scale: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}

class Rotate extends PageRouteBuilder {
  final page;
  Rotate({this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionsBuilder: (context, animation, animationTwo, child) {
            const begin = 0.0;
            const end = 1.0;
            final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
            final tween = Tween(begin: begin, end: end);
            return RotationTransition(
              turns: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}

class Size extends PageRouteBuilder {
  final page;
  Size({this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionsBuilder: (context, animation, animationTwo, child) {
            final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
            return Align(
              child: SizeTransition(
                sizeFactor: curvedAnimation,
                child: child,
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}

class Fade extends PageRouteBuilder {
  final page;
  Fade({this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionsBuilder: (context, animation, animationTwo, child) {
            final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}

class ScaleWithRotate extends PageRouteBuilder {
  final page;
  ScaleWithRotate({this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionsBuilder: (context, animation, animationTwo, child) {
            const begin = 0.0;
            const end = 1.0;
            final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
            final tween = Tween(begin: begin, end: end);
            return ScaleTransition(
              scale: tween.animate(curvedAnimation),
              child: RotationTransition(
                turns: tween.animate(curvedAnimation),
                child: child,
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}
