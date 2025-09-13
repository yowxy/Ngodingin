import 'dart:convert';
import 'package:hology_fe/models/course_detail_model.dart';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';

class CourseDetailProvider extends ChangeNotifier {
  final String courseId;
  final requestBaseUrl = AppUrl.baseUrl;
  
  CourseDetail? _courseDetail;
  bool _isLoading = false;
  String? _errorMessage;


  CourseDetail? get courseDetail => _courseDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  CourseDetailProvider(this.courseId) {
    fetchCourseDetail();
  }

  Future<void> fetchCourseDetail() async {
    final token = await DatabaseProvider().getToken();
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = "$requestBaseUrl/courses/$courseId";
      print("URL : $url");
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final courseData = res['data'] ?? {};
        _courseDetail = CourseDetail.fromJson(courseData);
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load course details: ${response.statusCode}';
        _courseDetail = null;
      }
    } catch (e) {
      _errorMessage = 'Error fetching course details: $e';
      _courseDetail = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> ratingCourse() async {
    
  }

  Future<void> refresh() async {
    await fetchCourseDetail();
  }

  void reset() {
    _courseDetail = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }

  bool get hasContent => _courseDetail != null;
}