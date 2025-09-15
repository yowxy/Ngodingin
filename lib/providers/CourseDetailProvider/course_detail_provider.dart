import 'dart:convert';
import 'dart:io';
import 'package:hology_fe/models/course_detail_model.dart';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:hology_fe/utils/snack_message.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';

class CourseDetailProvider extends ChangeNotifier {
  final String courseId;
  final requestBaseUrl = AppUrl.baseUrl;

  CourseDetail? _courseDetail;
  bool _isLoading = false;
  String? _errorUiMessage;
  String? _resMessage;
  String? _inProgressLessonId;

  CourseDetail? get courseDetail => _courseDetail;
  bool get isLoading => _isLoading;
  String? get errorUiMessage => _errorUiMessage;
  String? get inProgressLessonId => _inProgressLessonId;

  CourseDetailProvider(this.courseId) {
    fetchCourseDetail();
  }

  Future<void> fetchCourseDetail() async {
    final token = await DatabaseProvider().getToken();
    _isLoading = true;
    _errorUiMessage = null;
    notifyListeners();

    try {
      final url = "$requestBaseUrl/courses/$courseId";
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
      final courseData = res['data'] ?? {};
        _courseDetail = CourseDetail.fromJson(courseData);
        _errorUiMessage = null;
      } else {
        _errorUiMessage =
            'Failed to load course details: ${response.statusCode}';
        _courseDetail = null;
      }
    } catch (e) {
      _errorUiMessage = 'Error fetching course details: $e';
      _courseDetail = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> ratingCourse({
    required String courseId,
    required int rating,
    BuildContext? context,
  }) async {
    final token = await DatabaseProvider().getToken();
    _isLoading = true;
    _resMessage = null;
    notifyListeners();

    final url = "$requestBaseUrl/courses/review";
    final body = {"course_id": courseId, "rating": rating};

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'] ?? "Review berhasil ditambahkan";
        notifyListeners();

        await fetchCourseDetail();

        successMessage(message: _resMessage, context: context);
      } else {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'] ?? "Review berhasil ditambahkan";
        notifyListeners();
        errorMessage(message: _resMessage, context: context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Silakan coba lagi";
      notifyListeners();

      print(":::: $e");
    }
  }

  Future<void> enrollCourse(String courseId, {BuildContext? context}) async {
    final token = await DatabaseProvider().getToken();
    _isLoading = true;
    _resMessage = null;
    notifyListeners();

    final url = "$requestBaseUrl/courses/enroll";
    final body = {"course_id": courseId};

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'] ?? "Berhasil mendaftar course";
        notifyListeners();

        await fetchCourseDetail();

        successMessage(message: _resMessage, context: context);
      } else {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'] ?? "Gagal mendaftar course";
        notifyListeners();
        errorMessage(message: _resMessage, context: context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
      errorMessage(message: _resMessage, context: context);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Terjadi kesalahan, silakan coba lagi";
      notifyListeners();
      print("Enroll error: $e");
      errorMessage(message: _resMessage, context: context);
    }
  }

  Future<void> refresh() async {
    await fetchCourseDetail();
  }

  Future<void> startLesson(String lessonId, {BuildContext? context}) async {
    final token = await DatabaseProvider().getToken();
    _isLoading = true;
    _resMessage = null;
    notifyListeners();

    final url = "$requestBaseUrl/courses/start-lesson";
    final body = {"lesson_id": lessonId};

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'] ?? "Lesson berhasil dimulai";
        _inProgressLessonId = lessonId;
        notifyListeners();

        await fetchCourseDetail();

        successMessage(message: _resMessage, context: context);
      } else {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'] ?? "Gagal memulai lesson";
        notifyListeners();
        errorMessage(message: _resMessage, context: context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
      errorMessage(message: _resMessage, context: context);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Terjadi kesalahan, silakan coba lagi";
      notifyListeners();
      print("Start lesson error: $e");
      errorMessage(message: _resMessage, context: context);
    }
  }

  Future<List<Map<String, dynamic>>?> finishLesson(String lessonId, {BuildContext? context}) async {
    final token = await DatabaseProvider().getToken();
    _isLoading = true;
    _resMessage = null;
    notifyListeners();

    final url = "$requestBaseUrl/courses/complete-lesson";
    final body = {"lesson_id": lessonId};

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        print("Finish lesson response: $res"); // Debug log
        _isLoading = false;
        _resMessage = res['message'] ?? "Lesson berhasil diselesaikan";
        notifyListeners();

        await fetchCourseDetail();

        // Clear in-progress if it matches the finished lesson
        if (_inProgressLessonId == lessonId) {
          _inProgressLessonId = null;
        }

        successMessage(message: _resMessage, context: context);
        // Extract quizzes if present
        final data = res['data'] as Map<String, dynamic>?;
        print("Data from response: $data"); // Debug log
        final quizzes = data != null && data['quizzes'] is List
            ? List<Map<String, dynamic>>.from(data['quizzes'] as List)
            : null;
        print("Parsed quizzes: $quizzes"); // Debug log
        return quizzes;
      } else {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'] ?? "Gagal menyelesaikan lesson";
        notifyListeners();
        errorMessage(message: _resMessage, context: context);
        return null;
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
      errorMessage(message: _resMessage, context: context);
      return null;
    } catch (e) {
      _isLoading = false;
      _resMessage = "Terjadi kesalahan, silakan coba lagi";
      notifyListeners();
      print("Finish lesson error: $e");
      errorMessage(message: _resMessage, context: context);
      return null;
    }
  }

  void reset() {
    _courseDetail = null;
    _isLoading = false;
    _errorUiMessage = null;
    _inProgressLessonId = null;
    notifyListeners();
  }

  bool get hasContent => _courseDetail != null;
}
