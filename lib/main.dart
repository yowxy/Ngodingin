import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hology_fe/features/home/screens/home.dart';
import 'package:hology_fe/features/home/screens/homepage.dart';
import 'package:hology_fe/features/auth/signin_pages.dart';
import 'package:hology_fe/features/auth/signup_pages.dart';
import 'package:hology_fe/features/chose_prefrences/chose.prefrences.dart';
import 'package:hology_fe/features/email-verification/email-verification_screen.dart';
import 'package:hology_fe/features/email-verification/resend-verification_screen.dart';
import 'package:hology_fe/features/forgot-password/forgot-password_screen.dart';
import 'package:hology_fe/features/forgot-password/reset-password_screen.dart';
import 'package:hology_fe/features/pages/splash_screen.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/AuthProvider/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        // provider lain...
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pendidikan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/', 
      routes: {
        '/': (context) => const SplashPage(),
        '/sign-in': (context) => SigninPages(),
        '/sign-up': (context) => SignupPages(),
        '/forgot-password': (context) => ForgotPasswordPages(),
        '/reset-password': (context) => ResetPasswordPages(),
        '/email-verification': (context) => emailVerificationPages(),
        '/resend-verification': (context) => resendVerifPages(),
        '/choose-preferences': (context) => choosePrefrencesPages(),
        '/home': (context) => const Homepage(),
      },
    );
  }
}