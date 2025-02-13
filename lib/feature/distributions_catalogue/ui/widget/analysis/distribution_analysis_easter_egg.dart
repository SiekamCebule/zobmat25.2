import 'package:flutter/material.dart';

void handleDistributionAnalysisEasterEgg(String value, BuildContext context) {
  const imagesFolder = 'assets/fonts/g/g/g/gg';
  if (value == 'heniek123') {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Durations.extralong1,
        reverseTransitionDuration: Durations.extralong1,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = CurvedAnimation(parent: animation, curve: Curves.easeInCubic)
              .drive(Tween(begin: Offset(0, -0.6), end: Offset.zero));
          final scale =
              CurvedAnimation(parent: animation, curve: Easing.standardDecelerate)
                  .drive(Tween(begin: 0.0, end: 1.0));
          return SlideTransition(
            position: slide,
            child: ScaleTransition(
              scale: scale,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Heniek'),
            ),
            body: Center(
              child: Image.asset(
                '$imagesFolder/heniek.jpg',
                width: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }));
  }
  if (value == 'figa123') {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Durations.extralong1,
        reverseTransitionDuration: Durations.extralong1,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)
              .drive(Tween(begin: Offset(0, -0.6), end: Offset.zero));
          final scale = CurvedAnimation(parent: animation, curve: Curves.ease)
              .drive(Tween(begin: 0.0, end: 1.0));
          return SlideTransition(
            position: slide,
            child: ScaleTransition(
              scale: scale,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Figa'),
            ),
            body: Center(
              child: Image.asset(
                '$imagesFolder/figa.jpg',
                width: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }));
  }
  if (value == 'misiaczek123') {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 2500),
        reverseTransitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scale = CurvedAnimation(parent: animation, curve: Curves.easeInExpo)
              .drive(Tween(begin: 0.4, end: 1.0));
          final rotation = CurvedAnimation(parent: animation, curve: Curves.easeInExpo)
              .drive(Tween(begin: 0.0, end: 30.0));
          return RotationTransition(
            turns: rotation,
            child: ScaleTransition(
              scale: scale,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Misiaczek'),
            ),
            body: Center(
              child: Image.asset(
                '$imagesFolder/misiaczek.jpeg',
                width: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }));
  }
  if (value == 'smerfus123') {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 2500),
        reverseTransitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scale = CurvedAnimation(parent: animation, curve: Curves.easeInExpo)
              .drive(Tween(begin: 0.0, end: 1.0));
          final rotation = CurvedAnimation(parent: animation, curve: Curves.easeOut)
              .drive(Tween(begin: 0.0, end: 500.0));
          return RotationTransition(
            turns: rotation,
            child: ScaleTransition(
              scale: scale,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Smerfuś'),
            ),
            body: Center(
              child: Image.asset(
                '$imagesFolder/smerfus.jpeg',
                width: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }));
  }
  if (value == 'aleksiu123') {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 2500),
        reverseTransitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scale = CurvedAnimation(parent: animation, curve: Curves.easeInExpo)
              .drive(Tween(begin: 0.0, end: 1.0));
          final rotation = CurvedAnimation(parent: animation, curve: Curves.easeOut)
              .drive(Tween(begin: 0.0, end: 500.0));
          return RotationTransition(
            turns: rotation,
            child: ScaleTransition(
              scale: scale,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Aleksiu'),
            ),
            body: Center(
              child: Image.asset(
                '$imagesFolder/aleksiu.jpeg',
                width: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }));
  }
  if (value == 'zuzka123') {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 2500),
        reverseTransitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scale = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic)
              .drive(Tween(begin: 0.0, end: 1.0));
          final fade = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic)
              .drive(Tween(begin: 0.0, end: 1.0));

          return FadeTransition(
            opacity: fade,
            child: ScaleTransition(
              scale: scale,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Zuzka'),
            ),
            body: Center(
              child: Image.asset(
                '$imagesFolder/zuzka.jpeg',
                width: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }));
  }
  if (value == 'konradek123') {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        reverseTransitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scale = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic)
              .drive(Tween(begin: 0.0, end: 1.0));
          final fade = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic)
              .drive(Tween(begin: 0.0, end: 1.0));

          return FadeTransition(
            opacity: fade,
            child: ScaleTransition(
              scale: scale,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Konradek'),
            ),
            body: Center(
              child: Image.asset(
                '$imagesFolder/konradek.jpg',
                width: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }));
  }
}
