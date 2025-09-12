class UserProfile {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final Profile? profile;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    this.profile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerified: json['email_verified'] ?? false,
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }
}

class Profile {
  final String? photo;
  final int? level;
  final int? totalXp;
  final int? nextLevelXp;
  final String? bio;

  Profile({
    this.photo,
    this.level,
    this.totalXp,
    this.nextLevelXp,
    this.bio,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      photo: json['photo'],
      level: json['level'],
      totalXp: json['total_xp'],
      nextLevelXp: json['next_level_xp'],
    );
  }
}
