import 'package:hology_fe/models/course_model.dart';
import 'package:hology_fe/models/lesson_model.dart';
import 'package:hology_fe/models/rating_model.dart';

class CourseDetail {
  final Course course;
  final List<Lesson> lesson;
  final Rating rating;
  final bool isEnrolled;
  final Lesson? activeLesson;

  CourseDetail({
    required this.course, 
    required this.lesson, 
    required this.rating, 
    required this.isEnrolled,
    this.activeLesson,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    var lessonList = json['lessons'] as List? ?? [];
    return CourseDetail(
      course: Course.fromJson(json['course'] ?? {}),
      lesson: lessonList.map((e) => Lesson.fromJson(e)).toList(),
      rating: Rating.fromJson(json['rating'] ?? {}),
      isEnrolled: json['is_enrolled'] ?? false,
      activeLesson: json['active_lesson'] != null 
          ? Lesson.fromJson(json['active_lesson']) 
          : null,
    );
  }

  operator [](int other) {}
}
