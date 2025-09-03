import 'package:flutter/material.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/shared/theme.dart';

class ForgotPasswordPages extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPages({super.key});


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
          'Lupa Kata Sandi',
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
            const SizedBox(
              height: 10,
            ),
          
          Text(
            'Email',
            style: blackTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 14,
            ),
          ),
            const SizedBox(
              height: 20,
            ),

            CustomTextForm(
              controller: emailController, 
              hintText: 'Masukan Email anda', 
              obscureText: false, 
              width: double.infinity, 
              height: 47
            ),

            const SizedBox(height: 20,),


            CustomButton(
              title: 'Kirim KKode', 
              width: double.infinity, 
              height: 47,
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/reset-password', (route) => false );
              },
            ),

            const SizedBox(height: 22,),

          

          
        ],
      ),
    );
  }
}