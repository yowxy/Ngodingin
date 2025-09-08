import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/shared/theme.dart';

class SignupPages extends StatefulWidget {
  const SignupPages({super.key});

  @override
  State<SignupPages> createState() => _SignupPagesState();
}

class _SignupPagesState extends State<SignupPages> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true; // buat toggle password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hilangkan back button
        title: Text(
          'Daftar',
          style: blackTextStyle.copyWith(
            fontWeight: semibold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            // Gambar ilustrasi
            Container(
              width: 245,
              height: 234,
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/auth_image_bg.png'),
                ),
              ),
            ),

            // Nama
            Text(
              'Nama',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextForm(
              controller: namaController,
              hintText: 'Masukan nama anda',
              obscureText: false,
              width: double.infinity,
              height: 47,
            ),

            const SizedBox(height: 22),

            // Email
            Text(
              'Email',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            CustomTextForm(
              controller: emailController,
              hintText: 'Masukan email anda',
              obscureText: false,
              width: double.infinity,
              height: 47,
            ),

            const SizedBox(height: 22),

            // Password dengan toggle visibility
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
              hintText: 'Masukan kata sandi',
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

            const SizedBox(height: 15),

            // Tombol daftar
            CustomButton(
              title: 'Daftar',
              width: 388,
              height: 55,
              onPressed: () {
                // Gunakan CupertinoPageRoute biar bisa swipe-back
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Placeholder(), 
                    // ganti Placeholder dengan halaman "ChosePreferencesPage"
                  ),
                  (route) => false,
                );
              },
            ),

            const SizedBox(height: 30),

            // Sudah punya akun
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sudah punya akun ? ',
                  style: blackTextStyle.copyWith(
                    fontWeight: reguler,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const Placeholder(),
                        // ganti Placeholder dengan SigninPage
                      ),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Masuk',
                    style: blackTextStyle.copyWith(
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
