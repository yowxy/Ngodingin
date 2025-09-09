import 'package:flutter/material.dart';
import 'package:hology_fe/features/chose_prefrences/chose.prefrences.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/features/widgets/form.dart';
import 'package:hology_fe/shared/theme.dart';

class resendVerifPages extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  resendVerifPages({super.key});

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
          'Kirim ulang Verifikasi',
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
        
        
            const SizedBox(height: 20,),
        
            Text(
              'Email',
              style: blackTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
        
            const SizedBox(height: 20,),
        
            CustomTextForm(
              controller: emailController, 
              hintText: 'Masukan email anda', 
              obscureText: false, 
              width: double.infinity, 
              height: 47
              ),
        
              const SizedBox(height: 48,),
        
               CustomButton(
            title: 'Verifikasi',
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
          ],
        ),
      ),

    );
  }
}