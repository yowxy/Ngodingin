import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hology_fe/constants/url.dart';
import 'package:hology_fe/features/chose_prefrences/chose.prefrences.dart';
import 'package:hology_fe/features/forgot-password/reset-password_screen.dart';
import 'package:http/http.dart' as http;
import 'package:hology_fe/providers/database/db_provider.dart';
import 'package:hology_fe/features/auth/signin_pages.dart';
import 'package:hology_fe/features/home/screens/homepage.dart';
import 'package:hology_fe/features/email-verification/email-verification_screen.dart';
import 'package:hology_fe/utils/snack_message.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String name,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/auth/register";

    final body = {"name": name, "email": email, "password": password};
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);

        _isLoading = false;
        _resMessage = res['message'] ?? "Akun berhasil dibuat! Silahkan cek email untuk verifikasi.";
        notifyListeners();
        // Tampilkan pesan sebelum pindah halaman
        successMessage(
          message: _resMessage,
          context: context!,
        );
        await Future.delayed(const Duration(milliseconds: 1200));
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(builder: (context) => emailVerificationPages()),
          (route) => false,
        );
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];
        errorMessage(
          message: _resMessage,
          context: context!,
        );
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Silakan coba lagi";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/auth/login";

    final body = {"email": email, "password": password};
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = res['message'] ?? "Berhasil masuk!";
        notifyListeners();
        successMessage(
          message: _resMessage,
          context: context,
        );
        await Future.delayed(const Duration(milliseconds: 1200));
        ///Save users data and then navigate to homepage
        final userId = res['data']['user']['id'];
        final token = res['data']['access_token'];
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false,
        );
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'];
        errorMessage(
          message: _resMessage,
          context: context!,
        );
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Silakan coba lagi";
      notifyListeners();

      print(":::: $e");
    }
  }

  void emailVerification({
    required String email,
    required String token,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/auth/verify-email";

    final body = {"email": email, "token": token};
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        final userId = res['data']['user']['id'];
        final token = res['data']['access_token'];
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);
        print(res);
        _isLoading = false;
        _resMessage = res['message'] ?? "Email berhasil diverifikasi!";
        notifyListeners();
        successMessage(
          message: _resMessage,
          context: context,
        );
        await Future.delayed(const Duration(milliseconds: 1200));
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(builder: (context) => const choosePrefrencesPages()),
          (route) => false,
        );
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'];
        errorMessage(
          message: _resMessage,
          context: context!,
        );
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Silakan coba lagi";
      notifyListeners();

      print(":::: $e");
    }
  }

  void resendVerificationEmail({
    required String email,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/auth/resend-verification";

    final body = {"email": email};
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        print(res);
        _isLoading = false;
        _resMessage = res['message'] ?? "Email verifikasi berhasil dikirim!";
        notifyListeners();
        successMessage(
          message: _resMessage,
          context: context,
        );
        await Future.delayed(const Duration(milliseconds: 1200));
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(builder: (context) => emailVerificationPages()),
          (route) => false,
        );
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'];
        errorMessage(
          message: _resMessage,
          context: context!,
        );
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Silakan coba lagi";
      notifyListeners();

      print(":::: $e");
    }
  }

  void forgotPassword({
    required String email,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/auth/forgot-password";

    final body = {"email": email};
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        print(res);
        _isLoading = false;
        _resMessage = res['message'] ?? "Kode reset password telah dikirim ke email!";
        notifyListeners();
        successMessage(
          message: _resMessage,
          context: context,
        );
        await Future.delayed(const Duration(milliseconds: 1200));
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(builder: (context) => const ResetPasswordPages()),
          (route) => false,
        );
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'];
        errorMessage(
          message: _resMessage,
          context: context!,
        );
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Silakan coba lagi";
      notifyListeners();

      print(":::: $e");
    }
  }

  void resetPassword({
    required String email,
    required String token,
    required String newPassword,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/auth/reset-password";

    final body = {"email": email, "token": token, "password": newPassword};
    print(body);

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        print(res);
        _isLoading = false;
        _resMessage = res['message'] ?? "Password berhasil direset!";
        notifyListeners();
        successMessage(
          message: _resMessage,
          context: context,
        );
        await Future.delayed(const Duration(milliseconds: 1200));
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(builder: (context) => SigninPages()),
          (route) => false,
        );
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'];
        errorMessage(
          message: _resMessage,
          context: context!,
        );
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
      Navigator.pushAndRemoveUntil(
        context!,
        MaterialPageRoute(builder: (context) => SigninPages()),
        (route) => false,
      );
    } catch (e) {
      _isLoading = false;
      _resMessage = "Silakan coba lagi";
      notifyListeners();

      print(":::: $e");
    }
  }

  void logout({
    required String token,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final dbProvider = DatabaseProvider();
    final token = await dbProvider.getToken();

    String url = "$requestBaseUrl/auth/logout";

    try {
      http.Response req = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        _resMessage = "Berhasil logout!";
        notifyListeners();
        successMessage(
          message: _resMessage,
          context: context,
        );
        await Future.delayed(const Duration(milliseconds: 1200));
        DatabaseProvider().saveToken('');
        DatabaseProvider().saveUserId('');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SigninPages()),
          (route) => false,
        );
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'] ?? "Logout gagal!";
        errorMessage(
          message: _resMessage,
          context: context,
        );
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Koneksi internet tidak tersedia";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Silakan coba lagi";
      notifyListeners();
      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
