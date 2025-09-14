import 'package:hology_fe/models/lesson_model.dart';

class EnrolledCourse {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String categoryId;
  final int durationHours;
  final double rating;
  final String isCompleted;
  final int totalVideo;
  final double totalDurationHours;
  final int progressCourse;
  final String activeLesson;
  final List<Lesson> lessons;

  EnrolledCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.categoryId,
    required this.durationHours,
    required this.rating,
    required this.isCompleted,
    required this.totalVideo,
    required this.totalDurationHours,
    required this.progressCourse,
    required this.activeLesson,
    required this.lessons,
  });

  factory EnrolledCourse.fromJson(Map<String, dynamic> json) {
    return EnrolledCourse(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      categoryId: json['category_id'] ?? '',
      durationHours: json['duration_hours'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      isCompleted: json['is_completed'] ?? '0',
      totalVideo: json['total_video'] ?? 0,
      totalDurationHours:
          (json['total_duration_hours'] ?? 0).toDouble(),
      progressCourse: json['progress_course'] ?? 0,
      activeLesson: json['active_lesson'] ?? '',
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((e) => Lesson.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail_url': thumbnailUrl,
      'category_id': categoryId,
      'duration_hours': durationHours,
      'rating': rating,
      'is_completed': isCompleted,
      'total_video': totalVideo,
      'total_duration_hours': totalDurationHours,
      'progress_course': progressCourse,
      'active_lesson': activeLesson,
      'lessons': lessons.map((e) => e.toJson()).toList(),
    };
  }
}
