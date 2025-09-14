import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/QuestProvider/quest_provider.dart';
import 'package:hology_fe/utils/snack_message.dart';

class ListMissionWeekly extends StatelessWidget {
  const ListMissionWeekly({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestProvider>(
      builder: (context, questProvider, _) {
        if (questProvider.isLoadingWeekly) {
          return Center(child: CircularProgressIndicator());
        }
        final missions = questProvider.weeklyQuests;
        if (missions.isEmpty) {
          return Center(child: Text('Tidak ada misi mingguan'));
        }
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
                          mission.quest.title,
                          style: TextStyle(fontWeight: semibold),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: mission.quest.targetValue > 0 
                                ? (mission.currentProgress / mission.quest.targetValue).clamp(0.0, 1.0)
                                : 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          mission.isCompleted ? "Completed" : "Progress: ${mission.currentProgress}/${mission.quest.targetValue}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  mission.isCompleted
                      ? ElevatedButton(
                          onPressed: () async {
                            final questProvider = Provider.of<QuestProvider>(context, listen: false);
                            final result = await questProvider.finishQuest(mission.id);
                            if (result['success']) {
                              successMessage(
                                message: result['message'],
                                context: context,
                              );
                              // Refresh data
                              questProvider.fetchWeeklyQuests();
                            } else {
                              errorMessage(
                                message: result['message'],
                                context: context,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          ),
                          child: Text(
                            "Selesai",
                            style: TextStyle(color: whiteColor, fontSize: 12),
                          ),
                        )
                      : Container(
                          width: 50,
                          height: 30,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              "${mission.quest.xpReward} XP",
                              style: TextStyle(color: whiteColor, fontSize: 12),
                            ),
                          ),
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
