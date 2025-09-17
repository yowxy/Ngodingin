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

  // PERBAIKI: Add favorite dengan API yang benar
  Future<bool> addFavorite(String courseId) async {
    final url = "$requestBaseUrl/favorite-courses";
    final token = await DatabaseProvider().getToken();
    
    print("Adding to favorite - Course ID: $courseId");
    print("API URL: $url");
    
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'course_id': courseId}),
      );
      
      print("Add favorite response status: ${response.statusCode}");
      print("Add favorite response body: ${response.body}");
      
      if (response.statusCode == 201) {
        final res = json.decode(response.body);
        if (res['success'] == true) {
          _favoriteCourseIds.add(courseId);
          notifyListeners();
          return true;
        }
      } else if (response.statusCode == 409) {
        // Course sudah di favorit
        final res = json.decode(response.body);
        print("Course already in favorites: ${res['message']}");
        _favoriteCourseIds.add(courseId);
        notifyListeners();
        return false; // Return false untuk menunjukkan sudah ada
      }
    } catch (e) {
      print("Error adding to favorite: $e");
    }
    return false;
  }

  // PERBAIKI: Remove favorite dengan API yang benar
  Future<bool> removeFavorite(String courseId) async {
    final url = "$requestBaseUrl/favorite-courses/$courseId";
    final token = await DatabaseProvider().getToken();
    
    print("Removing from favorite - Course ID: $courseId");
    print("API URL: $url");
    
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      
      print("Remove favorite response status: ${response.statusCode}");
      print("Remove favorite response body: ${response.body}");
      
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        if (res['success'] == true) {
          _favoriteCourseIds.remove(courseId);
          notifyListeners();
          return true;
        }
      } else if (response.statusCode == 404) {
        // Course tidak ditemukan di favorit, tapi tetap remove dari local state
        _favoriteCourseIds.remove(courseId);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error removing from favorite: $e");
    }
    return false;
  }

  // PERBAIKI: Toggle favorite dengan proper API calls
  Future<bool> toggleFavorite(String courseId) async {
  if (_favoriteCourseIds.contains(courseId)) {
    // Remove dari favorite
    final success = await removeFavorite(courseId);
    return success;
  } else {
    // Add ke favorite
    final success = await addFavorite(courseId);
    return success;
  }
}

  // Helper method untuk cek apakah course di favorite
  bool isFavorite(String courseId) {
    return _favoriteCourseIds.contains(courseId);
  }

  // Method untuk fetch favorite status dari server
  Future<void> fetchFavoriteStatus() async {
    final token = await DatabaseProvider().getToken();
    final url = "$requestBaseUrl/favorite-courses";
    
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final List<dynamic> favorites = res['data'] ?? [];
        
        // Extract course IDs dari favorite courses
        _favoriteCourseIds = favorites
            .map<String>((fav) => fav['course_id'] ?? fav['id'] ?? '')
            .where((id) => id.isNotEmpty)
            .toSet();
            
        notifyListeners();
        print("Fetched favorite course IDs: $_favoriteCourseIds");
      }
    } catch (e) {
      print("Error fetching favorite status: $e");
    }
  }
}
