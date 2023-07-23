import 'package:flutter/material.dart';
import 'package:flutter_login_app/ui/home_screen.dart';
import 'package:flutter_login_app/ui/login_screen.dart';
import 'package:flutter_login_app/ui/register_screen.dart';
import 'package:flutter_login_app/ui/splash_screen.dart';

class RouterHelper {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${settings.name}',
                    style: TextStyle(color: Colors.black))),
          ),
        );
    }
  }
}
