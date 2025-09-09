import 'package:flutter/material.dart';
import 'package:hology_fe/features/chose_prefrences/chose.prefrences.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/shared/theme.dart';

class SigninPages extends StatefulWidget {
  const SigninPages({super.key});

  @override
  State<SigninPages> createState() => _SigninPagesState();
}

class _SigninPagesState extends State<SigninPages> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true; // untuk toggle password
  bool _rememberMe = false; // untuk checkbox "ingat saya"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        title: Text(
          'Masuk',
          style: blackTextStyle.copyWith(
            fontWeight: semibold,
            fontSize: 21,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            // Gambar di tengah
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
        
            // Label email
            Text(
              'Email',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
        
            // Input email
            CustomTextForm(
              controller: emailController,
              hintText: 'Masukkan Email anda',
              obscureText: false,
              width: double.infinity,
              height: 47,
            ),
            const SizedBox(height: 22),
        
            // Label password
            Text(
              'Kata sandi',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
        
            // Input password dengan eye icon
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
        
            const SizedBox(height: 10),
        
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
                    Navigator.pushNamedAndRemoveUntil(context, '/forgot-password', (route) => false);
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
          title: 'Register',
          width: 350,
          height: 55,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => choosePrefrencesPages(), // ganti dengan halaman tujuanmu
              ),
            );
          },
        ),
        
            const SizedBox(height: 10),
        
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
                    Navigator.pushNamedAndRemoveUntil(context, '/signup',(route) => false);
                  },
                  child: Text(
                    'Daftar',
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
