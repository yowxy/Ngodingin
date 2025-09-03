import 'package:flutter/material.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/shared/theme.dart';

class emailVerificationPages extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  emailVerificationPages({super.key});

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
          'Verifikasi Email',
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

          const SizedBox(height: 20,),
          
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
            hintText: "Masukan email anda",
            obscureText: false, 
            width: double.infinity, 
            height: 47
            ),

            const SizedBox(height: 20,),

            Text(
              'Token',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14
              ),
            ),

            const SizedBox(height: 12,),

            CustomTextForm(
              controller: tokenController, 
              hintText: 'Masukan token dari email anda', 
              obscureText: false, 
              width: double.infinity, 
              height: 47
              ),

              const SizedBox(height: 50,),

              CustomButton(title: 'Verifikasi', width: double.infinity, height: 47),

              const SizedBox(height: 14,),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kirim email verifikasi lagi ? ',
                style: blackTextStyle.copyWith(
                  fontWeight: reguler,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/resend-verivication',(route) => false);
                },
                child: Text(
                  'Kirim',
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