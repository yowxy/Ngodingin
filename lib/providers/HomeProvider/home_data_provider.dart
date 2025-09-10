import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/enrolled_course_model.dart';

class HomeDataProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  List<Map<String, dynamic>> _recommendedCourses = [];
  List<EnrolledCourse> _enrolledCourses = [];
  List<Map<String, dynamic>> _allCourses = [];
  List<String> _categories = [];
  bool _isLoading = false;
  String _selectedCategory = '';
  String _searchQuery = '';
  String? _token;

  List<Map<String, dynamic>> get recommendedCourses => _recommendedCourses;
  List<EnrolledCourse> get enrolledCourses => _enrolledCourses;
  List<Map<String, dynamic>> get allCourses => _allCourses;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void setCategory(String category) {
    _selectedCategory = category;
    fetchHomeData();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    fetchHomeData();
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  Future<void> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();
    String url = "$requestBaseUrl/home?";
    if (_selectedCategory.isNotEmpty && _selectedCategory != "Semua") {
      url += "category_id=$_selectedCategory&";
    }
    if (_searchQuery.isNotEmpty) {
      url += "search=$_searchQuery&";
    }
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${_token ?? ''}',
        },
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final data = res['data'];
        // Recommended Courses
        final List<dynamic> recommendedList = data['recommended_courses'] ?? [];
        _recommendedCourses = recommendedList.map((e) => Map<String, dynamic>.from(e)).toList();
        // Enrolled Courses
        final List<dynamic> enrolledList = data['enrolled_courses'] ?? [];
        _enrolledCourses = enrolledList.map((e) => EnrolledCourse.fromJson(e)).toList();
        // All Courses
        final List<dynamic> allList = data['all_courses'] ?? [];
        _allCourses = allList.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        _recommendedCourses = [];
        _enrolledCourses = [];
        _allCourses = [];
      }
    } catch (e) {
      _recommendedCourses = [];
      _enrolledCourses = [];
      _allCourses = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    String url = "$requestBaseUrl/categories";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${_token ?? ''}',
        },
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final List<dynamic> categoryList = res['data'] ?? [];
        _categories = categoryList.map((e) => e['name'].toString()).toList();
      } else {
        _categories = [];
      }
    } catch (e) {
      _categories = [];
    }
    notifyListeners();
  }

  Future<void> fetchCoursesByCategory(String categoryId) async {
    _isLoading = true;
    notifyListeners();
    String url = "$requestBaseUrl/home/category/$categoryId";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${_token ?? ''}',
        },
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final data = res['data'];
        // All Courses by category
        final List<dynamic> allList = data['courses'] ?? [];
        _allCourses = allList.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        _allCourses = [];
      }
    } catch (e) {
      _allCourses = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
