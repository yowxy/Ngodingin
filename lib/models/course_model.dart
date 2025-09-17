class Course {
  final String id;
  final String title;
  final String description;
  final String bannerUrl;
  final String thumbnailUrl;
  final String instructor;
  final String category;
  final int totalStudents;
  final String shortDescription;
  final int totalVideo;
  final double rating;
  final DateTime createdAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerUrl,
    required this.thumbnailUrl,
    required this.instructor,
    required this.category,
    required this.totalStudents,
    required this.totalVideo,
    required this.rating,
    required this.createdAt,
    required this.shortDescription,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      bannerUrl: json['banner_url'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      instructor: json['instructor']?['name'] ?? '',
      category: json['category']?['name'] ?? '',
      totalStudents: json['total_students'] ?? 0,
      totalVideo: json['total_video'] ?? 0, // Fixed: was using 'total_students'
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] ?? 0.0),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}
