class EnrolledCourse {
  final String id;
  final String title;
  final String image;
  final String progress;

  EnrolledCourse({
    required this.id,
    required this.title,
    required this.image,
    required this.progress,
  });

  factory EnrolledCourse.fromJson(Map<String, dynamic> json) {
    return EnrolledCourse(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      progress: json['progress']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'progress': progress,
    };
  }
}
