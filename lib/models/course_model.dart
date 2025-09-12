class Course {
  final String id;
  final String title;
  final String description;
  final String image;
  final String instructor;
  final String category;
  final int totalStudents;
  final double rating;
  final DateTime createdAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.instructor,
    required this.category,
    required this.totalStudents,
    required this.rating,
    required this.createdAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      instructor: json['instructor']?['name'] ?? '',
      category: json['category']?['name'] ?? '',
      totalStudents: json['total_students'] ?? 0,
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] ?? 0.0),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}
