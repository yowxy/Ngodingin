import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/quest_model.dart';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;

class QuestProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  List<Quest> _dailyQuests = [];
  List<Quest> _weeklyQuests = [];
  bool _isLoadingDaily = false;
  bool _isLoadingWeekly = false;

  List<Quest> get dailyQuests => _dailyQuests;
  List<Quest> get weeklyQuests => _weeklyQuests;
  bool get isLoadingDaily => _isLoadingDaily;
  bool get isLoadingWeekly => _isLoadingWeekly;

  Future<void> fetchDailyQuests() async {
    _isLoadingDaily = true;
    notifyListeners();
    String url = "$requestBaseUrl/quests/daily";
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
        final res = json.decode(response.body);
        final List<dynamic> data = res['data'] ?? [];
        _dailyQuests = data.map((e) => Quest.fromJson(e)).toList();
      } else {
        _dailyQuests = [];
      }
    } catch (e) {
      _dailyQuests = [];
    }
    _isLoadingDaily = false;
    notifyListeners();
  }

  Future<void> fetchWeeklyQuests() async {
    _isLoadingWeekly = true;
    notifyListeners();
    String url = "$requestBaseUrl/quests/weekly";
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
        final res = json.decode(response.body);
        final List<dynamic> data = res['data'] ?? [];
        _weeklyQuests = data.map((e) => Quest.fromJson(e)).toList();
      } else {
        _weeklyQuests = [];
      }
    } catch (e) {
      _weeklyQuests = [];
    }
    _isLoadingWeekly = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> finishQuest(String userQuestId) async {
    String url = "$requestBaseUrl/quests/finish";
    final token = await DatabaseProvider().getToken();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_quest_id': userQuestId,
        }),
      );
      final res = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': res['message'] ?? 'Quest berhasil diselesaikan',
          'data': res,
        };
      } else {
        return {
          'success': false,
          'message': res['message'] ?? 'Gagal menyelesaikan quest',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
}
