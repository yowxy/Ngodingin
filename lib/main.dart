import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hology_fe/features/home/screens/homepage.dart';
import 'package:hology_fe/features/auth/signin_pages.dart';
import 'package:hology_fe/features/auth/signup_pages.dart';
import 'package:hology_fe/features/chose_prefrences/chose.prefrences.dart';
import 'package:hology_fe/features/email-verification/email-verification_screen.dart';
import 'package:hology_fe/features/email-verification/resend-verification_screen.dart';
import 'package:hology_fe/features/forgot-password/forgot-password_screen.dart';
import 'package:hology_fe/features/forgot-password/reset-password_screen.dart';
import 'package:hology_fe/features/pages/splash_screen.dart';
import 'package:hology_fe/features/quiz/quiz_screen.dart';
import 'package:hology_fe/providers/ProfileProvider/profile_course_provider.dart';
import 'package:hology_fe/providers/ProfileProvider/profile_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/AuthProvider/auth_provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';
import 'package:hology_fe/providers/HomeProvider/course_list_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => HomeDataProvider()),
        ChangeNotifierProvider(create: (_) => CourseListProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProfileCourseProvider()),
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
      home: const SplashPage(),
    );
  }
}