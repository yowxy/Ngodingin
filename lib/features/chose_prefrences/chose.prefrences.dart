import 'package:flutter/material.dart';
import 'package:hology_fe/features/chose_prefrences/widget/CustomButtonRefrences.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/CategoryPreferencesProvider/category_preferences_provider.dart';
import 'package:hology_fe/features/home/screens/homepage.dart';
import 'package:hology_fe/features/widgets/button.dart';
import 'package:hology_fe/shared/theme.dart';
import 'dart:convert';

class choosePrefrencesPages extends StatelessWidget {
  const choosePrefrencesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryPreferencesProvider()..fetchCategories(),
      child: Consumer<CategoryPreferencesProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: provider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView(
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
                                  children: provider.categories.map((cat) {
                                    final isSelected = provider.selectedCategoryIds.contains(cat.id);
                                    return GestureDetector(
                                      onTap: () => provider.toggleCategorySelection(cat.id),
                                      child: Container(
                                        width: 150,
                                        height: 45,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.green : Colors.white,
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          cat.name,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.green,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                    ),
                    CustomButton(
                      title: 'Simpan',
                      width: 350,
                      height: 55,
                      onPressed: () async {
                        final success = await provider.savePreferences();
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Preferensi berhasil disimpan!'), backgroundColor: Colors.green),
                          );
                          await Future.delayed(const Duration(milliseconds: 800));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homepage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal menyimpan preferensi'), backgroundColor: Colors.red), 
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
