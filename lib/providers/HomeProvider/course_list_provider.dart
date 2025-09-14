import 'dart:convert';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/course_model.dart';

class CourseListProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  List<Course> _courses = [];
  bool _isLoading = false;
  String _selectedCategory = '';
  String _searchQuery = '';
  String _filter = 'all';
  Set<String> _favoriteCourseIds = {};

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String get filter => _filter;
  Set<String> get favoriteCourseIds => _favoriteCourseIds;

  void setCategory(String categoryId) {
    _selectedCategory = categoryId;
    fetchCourses();
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    fetchCourses();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    print("Search query : $_searchQuery");
    fetchCourses();
    notifyListeners();
  }

  Future<void> fetchCourses() async {
    final token = await DatabaseProvider().getToken();
    _isLoading = true;
    notifyListeners();
    String url;
    Map<String, String> params = {};
    if (_searchQuery.isNotEmpty) {
      url = "$requestBaseUrl/courses/search";
      params['q'] = _searchQuery;
      params['filter'] = _filter;
    } else {
      url = "$requestBaseUrl/courses";
      if (_selectedCategory.isNotEmpty && _selectedCategory != "Semua") {
        params['category_id'] = _selectedCategory;
      }
      params['filter'] = _filter;
    }

    final uri = Uri.parse(url).replace(queryParameters: params);

    print("Final URL dipanggil: $uri");

    try {
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final List<dynamic> courseList = res['data'] ?? [];
        _courses = courseList.map((e) => Course.fromJson(e)).toList();
      } else {
        _courses = [];
      }
    } catch (e) {
      _courses = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addFavorite(String courseId) async {
    final url = "$requestBaseUrl/favorite-courses";
    final token = await DatabaseProvider().getToken();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'course_id': courseId}),
      );
      if (response.statusCode == 201) {
        _favoriteCourseIds.add(courseId);
        notifyListeners();
      }
      // Optional: handle error response
    } catch (e) {
      // Optional: handle error
    }
  }

  void toggleFavorite(String courseId) {
    if (_favoriteCourseIds.contains(courseId)) {
      _favoriteCourseIds.remove(courseId);
      notifyListeners();
      // TODO: implement remove favorite API if available
    } else {
      addFavorite(courseId);
    }
  }
}
