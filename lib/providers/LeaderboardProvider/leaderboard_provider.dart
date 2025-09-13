import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/leaderboard_entry_model.dart';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;

class LeaderboardProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  List<LeaderboardEntry> _entries = [];
  bool _isLoading = false;

  List<LeaderboardEntry> get entries => _entries;
  bool get isLoading => _isLoading;

  Future<void> fetchLeaderboard(String courseId) async {
    _isLoading = true;
    notifyListeners();
    String url = "$requestBaseUrl/courses/leaderboard-quiz/$courseId";
    final token = await DatabaseProvider().getToken();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(courseId);
        final res = json.decode(response.body);
        final List<dynamic> data = res['data'] ?? [];
        _entries = data.map((e) => LeaderboardEntry.fromJson(e)).toList();
      } else {
        _entries = [];
      }
    } catch (e) {
      _entries = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
