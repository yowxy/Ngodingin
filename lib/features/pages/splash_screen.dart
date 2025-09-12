import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hology_fe/features/auth/signin_pages.dart';
import 'package:hology_fe/features/auth/signup_pages.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/splash_image_bg.png'),
            
                Text(
                  'Belajar kapan saja, di mana saja, dengan aplikasi edukasi yang siap mendukung kesuksesanmu.',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                  textAlign: TextAlign.center,
                ),
            
                const SizedBox(height: 20),
            
                CustomButton(
                  title: 'Register',
                  width: 400,
                  height: 55,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupPages(),
                      ),
                    );
                  },
                ),
            
                const SizedBox(height: 20),
            
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Sudah punya akun? ',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                    children: [
                      TextSpan(
                        text: 'Masuk',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          color: greenColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SigninPages(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
