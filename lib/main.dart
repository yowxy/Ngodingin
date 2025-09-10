import 'package:flutter/material.dart';
import 'package:hology_fe/features/auth/signin_pages.dart';
import 'package:hology_fe/features/auth/signup_pages.dart';
import 'package:hology_fe/features/chose_prefrences/chose.prefrences.dart';
import 'package:hology_fe/features/email-verification/email-verification_screen.dart';
import 'package:hology_fe/features/email-verification/resend-verification_screen.dart';
import 'package:hology_fe/features/forgot-password/forgot-password_screen.dart';
import 'package:hology_fe/features/forgot-password/reset-password_screen.dart';
import 'package:hology_fe/features/pages/splash_screen.dart';
import 'package:hology_fe/features/quiz/quiz_screen.dart';
import 'package:hology_fe/shared/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/forgot-password':(context) => ForgotPasswordPages(),
        '/reset-password' : (context) => ResetPasswordPages(),
        '/email-verification': (context) => emailVerificationPages(),
        '/resend-verivication': (context) => resendVerifPages(),
        '/chose-prefrences': (context) => choosePrefrencesPages(),
        '/quiz': (context) => QuizPages(),
       },
    );
  }
}