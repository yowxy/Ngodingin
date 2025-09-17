import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hology_fe/features/home/screens/homepage.dart';
import 'package:hology_fe/features/landing/landing_screen.dart';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), _checkToken);
  }

  Future<void> _checkToken() async {
    final databaseProvider = Provider.of<DatabaseProvider>(
      context,
      listen: false,
    );
    final token = await databaseProvider.getToken();

    if (!mounted) return;

    if (token == '' || token.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/icons/splash.svg",
          height: 125,
          width: 125,
        ),
      ),
    );
  }
}
