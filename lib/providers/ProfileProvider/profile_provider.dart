import 'dart:convert';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/user_profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  UserProfile? _userProfile;
  bool _isLoading = false;

  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;

  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();
    String url = "$requestBaseUrl/profile";
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
        final userJson = res['data']['user'];
        _userProfile = UserProfile.fromJson(userJson);
      } else {
        _userProfile = null;
      }
    } catch (e) {
      _userProfile = null;
    }
    _isLoading = false;
    notifyListeners();
  }
}
