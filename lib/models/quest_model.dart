import 'package:flutter/foundation.dart';

class Quest {
  final String id;
  final String userId;
  final String questId;
  final int currentProgress;
  final bool isCompleted;
  final QuestDetail quest;

  Quest({
    required this.id,
    required this.userId,
    required this.questId,
    required this.currentProgress,
    required this.isCompleted,
    required this.quest,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      questId: json['quest_id'] ?? '',
      currentProgress: json['current_progress'] ?? 0,
      isCompleted: json['is_completed'] ?? false,
      quest: QuestDetail.fromJson(json['quest'] ?? {}),
    );
  }
}

class QuestDetail {
  final String id;
  final String title;
  final int targetValue;
  final int xpReward;
  final String questType;

  QuestDetail({
    required this.id,
    required this.title,
    required this.targetValue,
    required this.xpReward,
    required this.questType,
  });

  factory QuestDetail.fromJson(Map<String, dynamic> json) {
    return QuestDetail(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      targetValue: json['target_value'] ?? 0,
      xpReward: json['xp_reward'] ?? 0,
      questType: json['quest_type'] ?? '',
    );
  }
}
