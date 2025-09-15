import 'package:flutter/material.dart';
import 'package:hology_fe/features/home/widgets/header.dart';
import 'package:hology_fe/features/home/widgets/my_course_list.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/ProfileProvider/profile_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      provider.fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final userProfile = profileProvider.userProfile;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: whitegreenColor,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: const EdgeInsets.only(top: 150),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: userProfile?.profile?.photo != null && userProfile!.profile!.photo!.isNotEmpty
                              ? Image.network(
                                  userProfile.profile!.photo!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/profile.png",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 215,
                    right: 0,
                    left: 0,
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Text(
                                userProfile?.profile?.level != null
                                    ? "Level ${userProfile!.profile!.level}"
                                    : "Level -",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              userProfile?.name ?? "-",
                              style: TextStyle(
                                fontWeight: semibold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              userProfile?.email ?? "-",
                              style: TextStyle(
                                color: lightGrey,
                                fontSize: 12,
                              ),
                            ),
                            if (userProfile?.profile?.totalXp != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "XP: ${userProfile!.profile!.totalXp} / ${userProfile.profile!.nextLevelXp ?? '-'}",
                                  style: TextStyle(
                                    color: greenColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 325,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kursus Kamu",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: semibold,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 360,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: MyCourseList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}