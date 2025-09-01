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

  bool _isObscure = true; // pindahin ke sini (stateful)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Daftar',
          style: blackTextStyle.copyWith(
            fontWeight: semibold,
            fontSize: 21,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
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
            hintText: 'Masukan Email anda',
            obscureText: false,
            width: double.infinity,
            height: 47,
          ),

          const SizedBox(height: 22),

          // Password dengan eye toggle
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
            hintText: 'Masukan Kata sandi',
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

          CustomButton(
            title: 'Daftar',
            width: 388,
            height: 55,
          ),

          const SizedBox(height: 30),

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
                  Navigator.pushNamed(context, '/signin');
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
    );
  }
}
