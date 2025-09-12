import 'dart:convert';
import 'package:hology_fe/providers/Database/db_provider.dart';
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

  List<Map<String, dynamic>> get recommendedCourses => _recommendedCourses;
  List<EnrolledCourse> get enrolledCourses => _enrolledCourses;
  List<Map<String, dynamic>> get allCourses => _allCourses;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void setCategory(String categoryId) {
    _selectedCategory = categoryId;
    fetchCoursesByCategory(categoryId);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    fetchSearchData(query);
    notifyListeners();
  }

  Future<void> fetchSearchData(String query) async {
    _isLoading = true;
    notifyListeners();
    String url = "$requestBaseUrl/home/search?q=$query";
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
        final data = res['data'];
        final List<dynamic> recommendedList = data['recommended_courses'] ?? [];
        _recommendedCourses = recommendedList.map((e) => Map<String, dynamic>.from(e)).toList();
        final List<dynamic> enrolledList = data['enrolled_courses'] ?? [];
        _enrolledCourses = enrolledList.map((e) => EnrolledCourse.fromJson(e)).toList();
        final List<dynamic> allList = data['all_courses'] ?? [];
        _allCourses = allList.map((e) => Map<String, dynamic>.from(e)).toList();
        print(_allCourses);
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

  Future<void> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();
    String url = "$requestBaseUrl/home";
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
        final data = res['data'];
        final List<dynamic> recommendedList = data['recommended_courses'] ?? [];
        _recommendedCourses = recommendedList.map((e) => Map<String, dynamic>.from(e)).toList();
        final List<dynamic> enrolledList = data['enrolled_courses'] ?? [];
        _enrolledCourses = enrolledList.map((e) => EnrolledCourse.fromJson(e)).toList();
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
