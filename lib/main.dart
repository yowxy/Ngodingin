import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hology_fe/features/mission/screens/mission.dart';
import 'package:hology_fe/features/splash/splash_screen.dart';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:hology_fe/providers/ProfileProvider/profile_course_provider.dart';
import 'package:hology_fe/providers/ProfileProvider/profile_provider.dart';
import 'package:hology_fe/providers/QuestProvider/quest_provider.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/AuthProvider/auth_provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';
import 'package:hology_fe/providers/HomeProvider/course_list_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => HomeDataProvider()),
        ChangeNotifierProvider(create: (_) => CourseListProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProfileCourseProvider()),
        ChangeNotifierProvider(create: (_) => QuestProvider()),
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