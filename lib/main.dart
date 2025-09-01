import 'package:flutter/material.dart';
import 'package:hology_fe/features/pages/auth/signin_pages.dart';
import 'package:hology_fe/features/pages/auth/signup_pages.dart';
import 'package:hology_fe/features/pages/splash_screen.dart';
import 'package:hology_fe/shared/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: whiteBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: whiteBackgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: blackColor,
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/sign-in':(context) =>  SigninPages(),
        '/sign-up':(context) =>  SignupPages(),
      },
    );
  }
}