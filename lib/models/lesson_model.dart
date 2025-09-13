class Lesson {
  final String id;
  final String courseId;
  final String title;
  final String videoUrl;
  final int durationMinutes;
  final int lessonOrder;
  final bool isCompleted;

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.videoUrl,
    required this.durationMinutes,
    required this.lessonOrder,
    required this.isCompleted,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      courseId: json['course_id'],
      title: json['title'],
      videoUrl: json['video_url'],
      durationMinutes: json["duration_minutes"],
      lessonOrder: json['lesson_order'],
      isCompleted: json['is_completed'].toString() == "1",
    );
  }
}
