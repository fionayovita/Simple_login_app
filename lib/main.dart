import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/common/router.dart';
import 'package:flutter_login_app/common/styles.dart';
import 'package:flutter_login_app/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: RouterHelper.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
