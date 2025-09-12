import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hology_fe/features/auth/signin_pages.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/AuthProvider/auth_provider.dart';
import 'package:hology_fe/utils/snack_message.dart';

class SignupPages extends StatefulWidget {
  const SignupPages({super.key});

  @override
  State<SignupPages> createState() => _SignupPagesState();
}

class _SignupPagesState extends State<SignupPages> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Daftar',
          style: blackTextStyle.copyWith(
            fontWeight: semibold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              hintText: 'Masukan email anda',
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

            const SizedBox(height: 25),

            CustomButton(
              title: 'Daftar',
              width: 388,
              height: 55,
              onPressed: () {
                if (namaController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                  errorMessage(
                    message: 'Nama, email, dan password tidak boleh kosong!',
                    context: context,
                  );
                  return;
                }
                Provider.of<AuthenticationProvider>(context, listen: false).registerUser(
                  name: namaController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  context: context,
                );
                final provider = Provider.of<AuthenticationProvider>(context, listen: false);
                if (provider.resMessage.isNotEmpty) {
                  if (provider.resMessage.toLowerCase().contains('success') || provider.resMessage.toLowerCase().contains('created')) {
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
                        builder: (context) => const SigninPages(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Masuk',
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
