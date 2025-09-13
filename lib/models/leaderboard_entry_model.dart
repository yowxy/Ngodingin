class LeaderboardEntry {
  final String userId;
  final int totalScore;
  final LeaderboardUser? user;

  LeaderboardEntry({
    required this.userId,
    required this.totalScore,
    this.user,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['user_id'],
      totalScore: json['total_score'] is int ? json['total_score'] : int.tryParse(json['total_score'].toString()) ?? 0,
      user: json['user'] != null ? LeaderboardUser.fromJson(json['user']) : null,
    );
  }
}

class LeaderboardUser {
  final String id;
  final String name;
  final String? email;

  LeaderboardUser({required this.id, required this.name, this.email});

  factory LeaderboardUser.fromJson(Map<String, dynamic> json) {
    return LeaderboardUser(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'],
    );
  }
}
