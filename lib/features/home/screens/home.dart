import 'package:flutter/material.dart';
import 'package:hology_fe/features/home/widgets/category_course_slider.dart';
import 'package:hology_fe/features/home/widgets/favorite_course.dart';
import 'package:hology_fe/features/home/widgets/header.dart';
import 'package:hology_fe/features/home/widgets/my_course_card.dart';
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                onChanged: (value) {
                                  Provider.of<HomeDataProvider>(
                                    context,
                                    listen: false,
                                  ).setSearchQuery(value);
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Image.asset("assets/images/banner.png"),
                            const SizedBox(height: 25),
                            Text(
                              "Rekomendasi Kursus",
                              style: TextStyle(
                                fontWeight: semibold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CategoryCourseSlider(),
                      const SizedBox(height: 20),
                      const RecommendedCourseCard(),
                      const SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Kursus Kamu",
                          style: TextStyle(fontWeight: semibold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const MyCourseCard(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Kursus Favorit",
                          style: TextStyle(fontWeight: semibold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const FavoriteCourse(),
                      const SizedBox(height: 20),
                    ],
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
