import 'package:flutter/material.dart';
import 'package:hology_fe/features/mission/screens/mission.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:hology_fe/providers/HomeProvider/home_provider.dart';
import 'package:hology_fe/providers/AuthProvider/auth_provider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  void _showLogoutMenu(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000, 110, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.transparent,
      elevation: 0,
      items: [
        PopupMenuItem(
          value: 'logout',
          height: 40,
          padding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: whiteColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.logout, color: Colors.red, size: 18),
                const SizedBox(width: 10),
                Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    if (result == 'logout') {
      final authProvider = Provider.of<AuthenticationProvider>(
        context,
        listen: false,
      );
      authProvider.logout(token: '', context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).fetchUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final userName = homeProvider.user?.name ?? "";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Halo,",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: semibold,
                  color: grey,
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: semibold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const Mission(),
                    ),
                  );
                },
                icon: Icon(LucideIcons.clipboardList, size: 25, color: greenColor),
                tooltip: "Mission",
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => _showLogoutMenu(context),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/profile.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
