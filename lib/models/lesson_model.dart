class Lesson {
  final String id;
  final String courseId;
  final String title;
  final String videoUrl;
  final int durationMinutes;
  final int lessonOrder;
  final bool isCompleted;
  final LessonProgress? progress;

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.videoUrl,
    required this.durationMinutes,
    required this.lessonOrder,
    required this.isCompleted,
    this.progress,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] ?? '',
      courseId: json['course_id'] ?? '',
      title: json['title'] ?? '',
      videoUrl: json['video_url'] ?? '',
      durationMinutes: json["duration_minutes"] ?? 0,
      lessonOrder: json['lesson_order'] ?? 0,
      isCompleted: json['is_completed']?.toString() == "1" ||
          json['is_completed'] == true ||
          json['is_completed'] == 1,
      progress: json['progress'] != null
          ? LessonProgress.fromJson(json['progress'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'title': title,
      'video_url': videoUrl,
      'duration_minutes': durationMinutes,
      'lesson_order': lessonOrder,
      'is_completed': isCompleted,
      'progress': progress?.toJson(),
    };
  }
}

class LessonProgress {
  final int completionPercentage;
  final int watchTimeSeconds;
  final bool isCompleted;
  final String? lastWatchedAt;

  LessonProgress({
    required this.completionPercentage,
    required this.watchTimeSeconds,
    required this.isCompleted,
    this.lastWatchedAt,
  });

  factory LessonProgress.fromJson(Map<String, dynamic> json) {
    return LessonProgress(
      completionPercentage: json['completion_percentage'] ?? 0,
      watchTimeSeconds: json['watch_time_seconds'] ?? 0,
      isCompleted: json['is_completed'] == true ||
          json['is_completed'] == 1 ||
          json['is_completed']?.toString() == "1",
      lastWatchedAt: json['last_watched_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completion_percentage': completionPercentage,
      'watch_time_seconds': watchTimeSeconds,
      'is_completed': isCompleted,
      'last_watched_at': lastWatchedAt,
    };
  }
}
