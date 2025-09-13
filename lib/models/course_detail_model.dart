import 'package:hology_fe/models/course_model.dart';
import 'package:hology_fe/models/lesson_model.dart';
import 'package:hology_fe/models/rating_model.dart';

class CourseDetail {
  final Course course;
  final List<Lesson> lesson;
  final Rating rating;

  CourseDetail({required this.course, required this.lesson, required this.rating});

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    var lessonList = json['lessons'] as List? ?? [];
    return CourseDetail(
      course: Course.fromJson(json['course'] ?? {}),
      lesson: lessonList.map((e) => Lesson.fromJson(e)).toList(),
      rating: Rating.fromJson(json['rating'] ?? {}),
    );
  }

  operator [](int other) {}
}
