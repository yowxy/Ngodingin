import 'dart:convert';
import 'package:hology_fe/providers/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hology_fe/models/user_model.dart';
import 'package:hology_fe/utils/snack_message.dart';
import 'package:hology_fe/constants/url.dart';

class HomeProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> fetchUser(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final userData = await getMe(context: context);
    _user = userData;
    _isLoading = false;
    notifyListeners();
  }

  Future<User?> getMe({BuildContext? context}) async {
    final dbProvider = DatabaseProvider();
    final token = await dbProvider.getToken();
    String url = "$requestBaseUrl/auth/me";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final userJson = res['data']['user'];
        return User.fromJson(userJson);
      } else {
        if (context != null) {
          errorMessage(
            message: 'Gagal mengambil data user',
            context: context,
          );
        }
        return null;
      }
    } catch (e) {
      if (context != null) {
        errorMessage(
          message: 'Terjadi kesalahan, silakan coba lagi',
          context: context,
        );
      }
      return null;
    }
  }
}
