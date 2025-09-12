import 'package:flutter/material.dart';
import 'package:hology_fe/features/leaderboard/widgets/leaderboard_list.dart';
import 'package:hology_fe/shared/theme.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("Nama", style: TextStyle(fontWeight: bold, fontSize: 16)),
                      Text("12345 Point", style: TextStyle(fontSize: 12)),
                      SizedBox(height: 10),
                      Container(
                        width: 115,
                        height: 200,
                        color: greenColor,
                        child: Center(
                          child: Text(
                            "2",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: bold,
                              fontSize: 80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Nama", style: TextStyle(fontWeight: bold, fontSize: 16)),
                      Text("12345 Point", style: TextStyle(fontSize: 12)),
                      SizedBox(height: 10),
                      Container(
                        width: 125,
                        height: 250,
                        decoration: BoxDecoration(
                          color: greenColor,
                          border: Border(left: BorderSide(color: whiteColor, width: 1), right: BorderSide(color: whiteColor, width: 1), top: BorderSide(color: whiteColor, width: 1))
                        ),
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: bold,
                              fontSize: 80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Nama", style: TextStyle(fontWeight: bold, fontSize: 16)),
                      Text("12345 Point", style: TextStyle(fontSize: 12)),
                      SizedBox(height: 10),
                      Container(
                        width: 115,
                        height: 180,
                        color: greenColor,
                        child: Center(
                          child: Text(
                            "3",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: bold,
                              fontSize: 80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                  child: LeaderboardList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
