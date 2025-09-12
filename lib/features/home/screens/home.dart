import 'package:flutter/material.dart';
import 'package:hology_fe/features/home/widgets/category_course_slider.dart';
import 'package:hology_fe/features/home/widgets/header.dart';
import 'package:hology_fe/features/home/widgets/my_course_card.dart';
import 'package:hology_fe/features/home/widgets/my_course_list.dart';
import 'package:hology_fe/features/home/widgets/recommended_course_card.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            Expanded(
              child: Container(
                color: whitegreenColor,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) {
                              Provider.of<HomeDataProvider>(context, listen: false).setSearchQuery(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Cari kursus",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: lightGrey,
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                size: 28,
                                color: lightGrey,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Image.asset("assets/images/banner.png"),
                        SizedBox(height: 25),
                        Text(
                          "Rekomendasi Kursus",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        CategoryCourseSlider(),
                        SizedBox(height: 20),
                        RecommendedCourseCard(),
                        SizedBox(height: 25),
                        Text(
                          "Kursus Kamu",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        MyCourseCard(),
                        SizedBox(height: 20), // Tambahan agar tidak overflow di bawah
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
