import 'package:flutter/material.dart';
import 'package:hology_fe/features/chose_prefrences/widget/CustomButtonRefrences.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/shared/theme.dart';

class choosePrefrencesPages extends StatelessWidget {
  const choosePrefrencesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Apa yang menarik minat anda',
                      style: blackTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Silahkan pilih yang tersedia',
                      style: grayTextStyle.copyWith(
                        fontWeight: semibold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        CustomButtonRefrences(
                          title: "Frontend Development",
                          width: 170,
                          height: 45,
                        ),
                        CustomButtonRefrences(
                          title: "Backend Development",
                          width: 150,
                          height: 45,
                        ),
                        CustomButtonRefrences(
                          title: "Mobile Development",
                          width: 170,
                          height: 45,
                        ),
                        CustomButtonRefrences(
                          title: "UI/UX Designer",
                          width: 150,
                          height: 45,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomButton(title: 'Simpan', width: double.infinity, height: 47),
            ],
          ),
        ),
      ),
    );
  }
}
