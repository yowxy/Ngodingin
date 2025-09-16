import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hology_fe/features/home/screens/chatbot.dart';
import 'package:hology_fe/features/home/screens/course.dart';
import 'package:hology_fe/features/home/screens/home.dart';
import 'package:hology_fe/features/home/screens/profile.dart';
import 'package:hology_fe/shared/theme.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Course(),
    const Chatbot(),
    const Profile(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedIndex == 3 
        ? whiteColor // kalau tab Profile
        : whitegreenColor, // selain itu
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // warna bayangan
              spreadRadius: 0.5, // seberapa jauh menyebar
              blurRadius: 10, // tingkat blur
              offset: const Offset(0, 1), // arah bayangan (x, y)
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GNav(
              onTabChange: _onTabChange,
              selectedIndex: _selectedIndex,
              color: greenColor,
              activeColor: whiteColor,
              tabBackgroundColor: greenColor,
              padding: const EdgeInsets.all(16),
              gap: 8,
              iconSize: 20,
              tabs: const [
                GButton(icon: Icons.home, text: "Home"),
                GButton(icon: Icons.menu_book, text: "Kursus"),
                GButton(icon: Icons.chat, text: "Chatbot"),
                GButton(icon: Icons.person, text: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
