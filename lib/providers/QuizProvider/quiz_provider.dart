import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/models/quiz_model.dart';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:hology_fe/utils/snack_message.dart';
import 'package:http/http.dart' as http;

class QuizProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  bool _isSubmitting = false;
  String? _resMessage;

  bool get isSubmitting => _isSubmitting;
  String? get resMessage => _resMessage;

  Future<CompleteQuizResult?> submitQuiz({
    required String lessonId,
    required Map<String, String> answers,
    required int timeInSeconds, // TAMBAH: Parameter time
    BuildContext? context,
  }) async {
    print("submitQuiz called with lessonId: $lessonId, answers: $answers, time: $timeInSeconds"); // Debug log
    
    final token = await DatabaseProvider().getToken();
    print("Token: $token"); // Debug log

    _isSubmitting = true;
    _resMessage = null;
    notifyListeners();

    final url = "$requestBaseUrl/courses/complete-quiz";
    final body = {
      "lesson_id": lessonId,
      "answers": answers,
      "time": timeInSeconds, // TAMBAH: Kirim waktu dalam detik
    };
    
    print("Request URL: $url"); 
    print("Request body: ${json.encode(body)}"); 

    try {
      final req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: const {
          'Content-Type': 'application/json',
        }.map((k, v) => MapEntry(k, v)).cast<String, String>()
          ..addAll({'Authorization': 'Bearer $token'}),
      );

      _isSubmitting = false;

      print("Response status: ${req.statusCode}");
      print("Response body: ${req.body}");

      if (req.statusCode == 200) {
        final res = json.decode(req.body) as Map<String, dynamic>;
        final result = CompleteQuizResult.fromJson(res);
        _resMessage = res['message']?.toString();
        notifyListeners();
        if (context != null && _resMessage != null) {
          successMessage(message: _resMessage, context: context);
        }
        return result;
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message']?.toString() ?? 'Gagal submit quiz';
        notifyListeners();
        if (context != null) {
          errorMessage(message: _resMessage, context: context);
        }
        return null;
      }
    } on SocketException catch (_) {
      _isSubmitting = false;
      _resMessage = 'Koneksi internet tidak tersedia';
      notifyListeners();
      if (context != null) errorMessage(message: _resMessage, context: context);
      return null;
    } catch (e) {
      _isSubmitting = false;
      _resMessage = 'Terjadi kesalahan, silakan coba lagi';
      if (kDebugMode) print('submitQuiz error: $e');
      notifyListeners();
      if (context != null) errorMessage(message: _resMessage, context: context);
      return null;
    }
  }
}
