import 'package:flutter/material.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/AuthProvider/auth_provider.dart';
import 'package:hology_fe/utils/snack_message.dart';

class ResendVerifPages extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  ResendVerifPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Kirim ulang Verifikasi',
          style: blackTextStyle.copyWith(fontWeight: semibold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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

            const SizedBox(height: 20),

            CustomTextForm(
              controller: emailController,
              hintText: 'Masukan email anda',
              obscureText: false,
              width: double.infinity,
              height: 47,
            ),

            const SizedBox(height: 48),

            CustomButton(
              title: 'Kirim Kode Verifikasi',
              width: 350,
              height: 55,
              onPressed: () {
                if (emailController.text.isEmpty) {
                  errorMessage(
                    message: 'Email tidak boleh kosong!',
                    context: context,
                  );
                  return;
                }
                Provider.of<AuthenticationProvider>(
                  context,
                  listen: false,
                ).resendVerificationEmail(
                  email: emailController.text.trim(),
                  context: context,
                );
                final provider = Provider.of<AuthenticationProvider>(
                  context,
                  listen: false,
                );
                if (provider.resMessage.isNotEmpty) {
                  if (provider.resMessage.toLowerCase().contains('berhasil') ||
                      provider.resMessage.toLowerCase().contains('success')) {
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
