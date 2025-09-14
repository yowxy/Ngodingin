import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

class ListMission extends StatelessWidget {
  const ListMission({super.key});

  final List<Map<String, String>> missions = const [
    {'name': 'Tonton 1 video kursus', 'xp': '10'},
    {'name': 'Tonton 3 video kursus', 'xp': '30'},
    {'name': 'Tonton 5 video kursus', 'xp': '50'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: missions.length,
      itemBuilder: (context, index) {
        final mission = missions[index];

        return Container(
          margin: EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          width: double.infinity,
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mission['name']!,
                      style: TextStyle(fontWeight: semibold),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: 5,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text("Completed", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              SizedBox(width: 15),
              Container(
                width: 50,
                height: 30,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    "${mission['xp']} XP",
                    style: TextStyle(color: whiteColor, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
