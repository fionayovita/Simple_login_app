import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/ui/home_screen.dart';
import 'package:flutter_login_app/ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo-social.png',
                width: 300,
                // height: 00,
              ),
            ),
            Text('Task', style: Theme.of(context).textTheme.headline4)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    String routeName() {
      String name;
      FirebaseAuth.instance.currentUser == null
          ? name = LoginScreen.routeName
          : name = HomeScreen.routeName;
      return name;
    }

    Timer(
        Duration(seconds: 5),
        () => Navigator.pushNamedAndRemoveUntil(
              context,
              routeName(),
              (route) => false,
            ));
  }
}
