import 'dart:convert';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/enrolled_course_model.dart';
import 'package:hology_fe/models/course_model.dart';
import 'package:hology_fe/models/favorite_course_model.dart'; // Tambah import

class HomeDataProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  List<Course> _recommendedCourses = [];
  List<EnrolledCourse> _enrolledCourses = [];
  List<FavoriteCourse> _favoriteCourses = []; // Tambah favorite courses
  List<Course> _allCourses = [];
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = false;
  String? _selectedCategory;
  String _searchQuery = '';

  List<Course> get recommendedCourses => _recommendedCourses;
  List<EnrolledCourse> get enrolledCourses => _enrolledCourses;
  List<FavoriteCourse> get favoriteCourses => _favoriteCourses; // Getter untuk favorite courses
  List<Course> get allCourses => _allCourses;
  List<Map<String, dynamic>> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  // Method lama untuk backward compatibility
  void setCategory(String categoryId) {
    _selectedCategory = categoryId.isEmpty ? null : categoryId;
    fetchCoursesByCategory(_selectedCategory);
    notifyListeners();
  }

  // Method baru untuk API getCoursesByCategory
  void setCategoryWithApi(String? categoryId) {
    _selectedCategory = categoryId;
    fetchCoursesByCategoryApi(categoryId);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;

    if (_searchQuery.trim().isEmpty) {
      fetchHomeData();
    } else {
      fetchSearchData(_searchQuery);
    }

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
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final data = res['data'];
        
        final List<dynamic> recommendedList = data['recommended_courses'] ?? [];
        _recommendedCourses = recommendedList
            .map((e) => Course.fromJson(e))
            .toList();
            
        final List<dynamic> enrolledList = data['enrolled_courses'] ?? [];
        _enrolledCourses = enrolledList
            .map((e) => EnrolledCourse.fromJson(e))
            .toList();
            
        // Tambah parsing favorite courses
        final List<dynamic> favoriteList = data['favorite_courses'] ?? [];
        _favoriteCourses = favoriteList
            .map((e) => FavoriteCourse.fromJson(e))
            .toList();
            
        final List<dynamic> allList = data['all_courses'] ?? [];
        _allCourses = allList.map((e) => Course.fromJson(e)).toList();
        
        print('Search - Recommended: ${_recommendedCourses.length}, Enrolled: ${_enrolledCourses.length}, Favorite: ${_favoriteCourses.length}, All: ${_allCourses.length}');
      } else {
        _recommendedCourses = [];
        _enrolledCourses = [];
        _favoriteCourses = [];
        _allCourses = [];
      }
    } catch (e) {
      print("Error fetching search data: $e");
      _recommendedCourses = [];
      _enrolledCourses = [];
      _favoriteCourses = [];
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
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final data = res['data'];
        
        final List<dynamic> recommendedList = data['recommended_courses'] ?? [];
        _recommendedCourses = recommendedList
            .map((e) => Course.fromJson(e))
            .toList();

        print('Recommended Courses: $_recommendedCourses');
        
        final List<dynamic> enrolledList = data['enrolled_courses'] ?? [];
        _enrolledCourses = enrolledList
            .map((e) => EnrolledCourse.fromJson(e))
            .toList();
            
        // Tambah parsing favorite courses
        final List<dynamic> favoriteList = data['favorite_courses'] ?? [];
        _favoriteCourses = favoriteList
            .map((e) => FavoriteCourse.fromJson(e))
            .toList();
            
        final List<dynamic> allList = data['all_courses'] ?? [];
        _allCourses = allList.map((e) => Course.fromJson(e)).toList();
        
        print('Home Data - Recommended: ${_recommendedCourses.length}, Enrolled: ${_enrolledCourses.length}, Favorite: ${_favoriteCourses.length}, All: ${_allCourses.length}');
      } else {
        _recommendedCourses = [];
        _enrolledCourses = [];
        _favoriteCourses = [];
        _allCourses = [];
      }
    } catch (e) {
      print("Error fetching home data: $e");
      _recommendedCourses = [];
      _enrolledCourses = [];
      _favoriteCourses = [];
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
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final List<dynamic> rawCategories = res['data'] ?? [];

        _categories = rawCategories.map<Map<String, dynamic>>((e) {
          if (e is String) {
            return {"id": e, "name": e};
          } else if (e is Map<String, dynamic>) {
            return e;
          } else {
            return {"id": "", "name": e.toString()};
          }
        }).toList();

        _categories.insert(0, {"id": "", "name": "Semua"});
      } else {
        _categories = [
          {"id": "", "name": "Semua"},
        ];
      }
    } catch (e) {
      _categories = [
        {"id": "", "name": "Semua"},
      ];
    }
    notifyListeners();
  }

  // Method baru untuk API getCoursesByCategory
  Future<void> fetchCoursesByCategoryApi(String? categoryId) async {
    _isLoading = true;
    notifyListeners();

    String url;
    if (categoryId == null) {
      // Untuk "Semua", panggil endpoint tanpa categoryId
      url = "$requestBaseUrl/home/category";
    } else {
      // Untuk category tertentu
      url = "$requestBaseUrl/home/category/$categoryId";
    }

    print("API URL: $url");
    print("Category ID: $categoryId");
    final token = await DatabaseProvider().getToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final data = res['data'];

        final List<dynamic> recommendedList = data['recommended_courses'] ?? [];
        _recommendedCourses = recommendedList
            .map((e) => Course.fromJson(e))
            .toList();

        final List<dynamic> enrolledList = data['enrolled_courses'] ?? [];
        _enrolledCourses = enrolledList
            .map((e) => EnrolledCourse.fromJson(e))
            .toList();

        // Tambah parsing favorite courses
        final List<dynamic> favoriteList = data['favorite_courses'] ?? [];
        _favoriteCourses = favoriteList
            .map((e) => FavoriteCourse.fromJson(e))
            .toList();

        final List<dynamic> allList = data['all_courses'] ?? [];
        _allCourses = allList.map((e) => Course.fromJson(e)).toList();

        print("Fetched courses by category - Recommended: ${_recommendedCourses.length}, Enrolled: ${_enrolledCourses.length}, Favorite: ${_favoriteCourses.length}, All: ${_allCourses.length}");
      } else {
        _recommendedCourses = [];
        _enrolledCourses = [];
        _favoriteCourses = [];
        _allCourses = [];
      }
    } catch (e) {
      print("Error fetching courses by category: $e");
      _recommendedCourses = [];
      _enrolledCourses = [];
      _favoriteCourses = [];
      _allCourses = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Method lama untuk backward compatibility
  Future<void> fetchCoursesByCategory(String? categoryId) async {
    _isLoading = true;
    notifyListeners();

    String url;
    if (categoryId == null || categoryId.isEmpty) {
      url = "$requestBaseUrl/courses";
    } else {
      url = "$requestBaseUrl/home/category/$categoryId";
    }

    print("URL: $url");
    final token = await DatabaseProvider().getToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final data = res['data'];
        print("Data: $data");

        List<dynamic> courseList;
        List<dynamic> favoriteList = [];

        if (categoryId == null || categoryId.isEmpty) {
          courseList = data is List ? data : (data['courses'] ?? []);
          // Coba ambil favorite courses jika ada
          if (data is Map<String, dynamic>) {
            favoriteList = data['favorite_courses'] ?? [];
          }
        } else {
          courseList = data['courses'] ?? [];
          favoriteList = data['favorite_courses'] ?? [];
        }

        _allCourses = courseList
            .map((e) => Course.fromJson(e))
            .toList();
        _recommendedCourses = _allCourses;
        
        // Parse favorite courses
        _favoriteCourses = favoriteList
            .map((e) => FavoriteCourse.fromJson(e))
            .toList();
            
        print("Fetched courses - Recommended: ${_recommendedCourses.length}, Favorite: ${_favoriteCourses.length}, All: ${_allCourses.length}");
      } else {
        _allCourses = [];
        _recommendedCourses = [];
        _favoriteCourses = [];
      }
    } catch (e) {
      print("Error fetching courses: $e");
      _allCourses = [];
      _recommendedCourses = [];
      _favoriteCourses = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // TAMBAH: Method untuk manage favorite courses
  Future<bool> addToFavorite(String courseId) async {
    final token = await DatabaseProvider().getToken();
    String url = "$requestBaseUrl/favorite-courses";
    
    print("Adding to favorite - Course ID: $courseId");
    
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
          // Refresh data setelah berhasil menambah favorite
          await fetchHomeData();
          return true;
        }
      } else if (response.statusCode == 409) {
        // Course sudah di favorit
        print("Course already in favorites");
        return false;
      }
    } catch (e) {
      print("Error adding to favorite: $e");
    }
    return false;
  }

  Future<bool> removeFromFavorite(String courseId) async {
    final token = await DatabaseProvider().getToken();
    String url = "$requestBaseUrl/favorite-courses/$courseId";
    
    print("Removing from favorite - Course ID: $courseId");
    
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
          // Refresh data setelah berhasil menghapus favorite
          await fetchHomeData();
          return true;
        }
      } else if (response.statusCode == 404) {
        // Course tidak ditemukan di favorit, tapi tetap refresh
        await fetchHomeData();
        return true;
      }
    } catch (e) {
      print("Error removing from favorite: $e");
    }
    return false;
  }

  // Helper method untuk cek apakah course sudah di-favorite
  bool isFavorite(String courseId) {
    return _favoriteCourses.any((course) => course.id == courseId);
  }
}
