import 'package:flutter/material.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/shared/theme.dart';

class ResetPasswordPages extends StatefulWidget {
  const ResetPasswordPages({super.key});

  @override
  State<ResetPasswordPages> createState() => _ResetPasswordPagesState();
}

class _ResetPasswordPagesState extends State<ResetPasswordPages> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();

  bool _isObscure = true;

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
          'Reset Kata Sandi',
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

          const SizedBox(height: 20),
          Text(
            'Email',
            style: blackTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 14,
            ),
          ),
          CustomTextForm(
            controller: emailController,
            hintText: 'Masukan Email anda',
            obscureText: false,
            width: double.infinity,
            height: 47,
          ),

          const SizedBox(height: 10),
          Text(
            'Token',
            style: blackTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),
          CustomTextForm(
            controller: tokenController,
            hintText: 'Masukan token dari email',
            obscureText: false,
            width: double.infinity,
            height: 47,
          ),

          const SizedBox(height: 10),
          Text(
            'Kata Sandi',
            style: blackTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),
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
        ],
      ),
    );
  }
}
