import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

class LeaderboardList extends StatelessWidget {
  final List entries;
  final bool isLoading;

  const LeaderboardList({super.key, required this.entries, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (entries.isEmpty) {
      return Center(child: Text('Belum ada data leaderboard'));
    }
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final rank = index + 1;
        final name = entry.user?.name ?? '-';
        final point = entry.totalScore;
        return Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          margin: const EdgeInsets.only(bottom: 10, top: 5, left: 5, right: 5),
          decoration: BoxDecoration(
            color: greenColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: whitegreenColor,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Center(
                  child: Text(
                    rank.toString(),
                    style: TextStyle(fontWeight: semibold),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Container(
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
                  child: Image.asset("assets/images/profile.png", height: 40, width: 40, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      name,
                      style: TextStyle(color: whiteColor, fontWeight: bold, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text("$point Point", style: TextStyle(color: whiteColor, fontSize: 12))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
