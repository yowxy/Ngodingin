import 'package:flutter/material.dart';
import 'package:hology_fe/features/leaderboard/widgets/leaderboard_list.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/LeaderboardProvider/leaderboard_provider.dart';
import 'package:hology_fe/shared/theme.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    // Ganti courseId sesuai kebutuhan, bisa dari argumen atau provider
    final String courseId = this.courseId;
    return ChangeNotifierProvider(
      create: (_) => LeaderboardProvider()..fetchLeaderboard(courseId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Leaderboard",
            style: TextStyle(
              color: Colors.black,
              fontWeight: semibold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            color: whitegreenColor,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<LeaderboardProvider>(
              builder: (context, provider, _) {
                final top3 = provider.entries.length >= 3 ? provider.entries.sublist(0, 3) : provider.entries;
                final rest = provider.entries.length > 3 ? provider.entries.sublist(3) : [];
                return Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(top3.length, (i) {
                        final entry = top3[i];
                        final rank = i + 1;
                        final name = entry.user?.name ?? '-';
                        final point = entry.totalScore;
                        double width = (rank == 2) ? 115 : (rank == 1 ? 125 : 115);
                        double height = (rank == 2) ? 200 : (rank == 1 ? 250 : 180);
                        return Column(
                          children: [
                            SizedBox(
                              width: width,
                              child: Text(
                                name,
                                style: TextStyle(fontWeight: bold, fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Text("$point Point", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 10),
                            Container(
                              width: width,
                              height: height,
                              decoration: BoxDecoration(
                                color: greenColor,
                                border: rank == 1
                                    ? Border(left: BorderSide(color: whiteColor, width: 1), right: BorderSide(color: whiteColor, width: 1), top: BorderSide(color: whiteColor, width: 1))
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  rank.toString(),
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: bold,
                                    fontSize: 80,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 500,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                        ),
                        child: LeaderboardList(entries: rest, isLoading: provider.isLoading),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
