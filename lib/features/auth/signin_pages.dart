import 'package:flutter/material.dart';
import 'package:hology_fe/features/auth/signup_pages.dart';
import 'package:hology_fe/features/forgot-password/forgot-password_screen.dart';
import 'package:hology_fe/features/home/screens/homepage.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:hology_fe/utils/snack_message.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/AuthProvider/auth_provider.dart';

class SigninPages extends StatefulWidget {
  const SigninPages({super.key});

  @override
  State<SigninPages> createState() => _SigninPagesState();
}

class _SigninPagesState extends State<SigninPages> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Masuk',
          style: blackTextStyle.copyWith(fontWeight: semibold, fontSize: 21),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
              width: 245,
              height: 234,
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/auth_image_bg.png'),
                ),
              ),
            ),

            Text(
              'Email',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),

            CustomTextForm(
              controller: emailController,
              hintText: 'Masukkan Email anda',
              obscureText: false,
              width: double.infinity,
              height: 47,
            ),
            const SizedBox(height: 22),

            Text(
              'Kata sandi',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),

            CustomTextForm(
              controller: passwordController,
              hintText: 'Masukkan kata sandi anda',
              obscureText: _isObscure,
              width: double.infinity,
              height: 47,
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),

            const SizedBox(height: 5),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),
                Text(
                  "Ingat saya",
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPages(),
                      ),
                    );
                  },
                  child: Text(
                    'Lupa Password',
                    style: greenTextStyle.copyWith(
                      fontWeight: semibold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            CustomButton(
              title: 'Masuk',
              width: 350,
              height: 55,
              onPressed: () {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  errorMessage(
                    message: 'Email dan password tidak boleh kosong!',
                    context: context,
                  );
                  return;
                }
                Provider.of<AuthenticationProvider>(
                  context,
                  listen: false,
                ).loginUser(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  context: context,
                );
                final provider = Provider.of<AuthenticationProvider>(
                  context,
                  listen: false,
                );
                if (provider.resMessage.isNotEmpty) {
                  if (provider.resMessage.toLowerCase().contains('success') ||
                      provider.resMessage.toLowerCase().contains('berhasil')) {
                    successMessage(
                      message: provider.resMessage,
                      context: context,
                    );
                  } else {
                    errorMessage(
                      message: provider.resMessage,
                      context: context,
                    );
                  }
                }
              },
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum punya akun? ',
                  style: blackTextStyle.copyWith(
                    fontWeight: reguler,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPages()),
                    );
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      color: greenColor,
                      fontWeight: bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
