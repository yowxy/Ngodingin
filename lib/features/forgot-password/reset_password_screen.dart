import 'package:flutter/material.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/AuthProvider/auth_provider.dart';
import 'package:hology_fe/utils/snack_message.dart';

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
        automaticallyImplyLeading: false,
        title: Text(
          'Reset Kata Sandi',
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
        
            const SizedBox(height: 20),
            Text(
              'Email',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 10,),

            CustomTextForm(
              controller: emailController,
              hintText: 'Masukan Email anda',
              obscureText: false,
              width: double.infinity,
              height: 47,
            ),
        
            const SizedBox(height: 15),
            Text(
              'Token',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextForm(
              controller: tokenController,
              hintText: 'Masukan token dari email',
              obscureText: false,
              width: double.infinity,
              height: 47,
            ),
        
            const SizedBox(height: 15),
            Text(
              'Kata Sandi',
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

            const SizedBox(height:  30,),

          CustomButton(
          title: 'Konfirmasi',
          width: 350,
          height: 55,
          onPressed: () {
            if (emailController.text.isEmpty || tokenController.text.isEmpty || passwordController.text.isEmpty) {
              errorMessage(
                message: 'Email, token, dan kata sandi tidak boleh kosong!',
                context: context,
              );
              return;
            }
            Provider.of<AuthenticationProvider>(context, listen: false).resetPassword(
              email: emailController.text.trim(),
              token: tokenController.text.trim(),
              newPassword: passwordController.text.trim(),
              context: context,
            );
            final provider = Provider.of<AuthenticationProvider>(context, listen: false);
            if (provider.resMessage.isNotEmpty) {
              if (provider.resMessage.toLowerCase().contains('berhasil') || provider.resMessage.toLowerCase().contains('password')) {
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
          ],
        ),
      ),
    );
  }
}
