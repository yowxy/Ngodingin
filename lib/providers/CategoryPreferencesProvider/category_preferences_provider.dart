import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/user_category_preference_model.dart';

class CategoryPreferencesProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  List<Category> _categories = [];
  List<String> _selectedCategoryIds = [];
  bool _isLoading = false;
  String? _token;

  List<Category> get categories => _categories;
  List<String> get selectedCategoryIds => _selectedCategoryIds;
  bool get isLoading => _isLoading;

  void toggleCategorySelection(String categoryId) {
    if (_selectedCategoryIds.contains(categoryId)) {
      _selectedCategoryIds.remove(categoryId);
    } else {
      _selectedCategoryIds.add(categoryId);
    }
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    String url = "$requestBaseUrl/categories";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final List<dynamic> categoryList = res['data'] ?? [];
        _categories = categoryList.map((e) => Category.fromJson(e)).toList();
      } else {
        _categories = [];
      }
    } catch (e) {
      _categories = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> savePreferences() async {
    final token = await DatabaseProvider().getToken();

    if (token == '' || _selectedCategoryIds.isEmpty) return false;
    String url = "$requestBaseUrl/user-preferences";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'category_ids': _selectedCategoryIds,
        }),
      );
      print('DEBUG: statusCode = \\${response.statusCode}');
      print('DEBUG: response.body = \\${response.body}');
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print('DEBUG: Exception = \\${e.toString()}');
    }
    return false;
  }
}
