import 'dart:convert';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/enrolled_course_model.dart';

class ProfileCourseProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  List<EnrolledCourse> _enrolledCourses = [];
  bool _isLoading = false;

  List<EnrolledCourse> get enrolledCourses => _enrolledCourses;
  bool get isLoading => _isLoading;

  Future<void> fetchEnrolledCourses() async {
    _isLoading = true;
    notifyListeners();
    String url = "$requestBaseUrl/profile/enrolled-courses";
    final token = await DatabaseProvider().getToken();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final List<dynamic> courseList = res['data'] ?? [];
        _enrolledCourses = courseList.map((e) => EnrolledCourse.fromJson(e)).toList();
      } else {
        _enrolledCourses = [];
      }
    } catch (e) {
      _enrolledCourses = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
