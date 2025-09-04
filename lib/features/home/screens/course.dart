import 'package:flutter/material.dart';
import 'package:hology_fe/features/home/widgets/category_time_slider.dart';
import 'package:hology_fe/features/home/widgets/course_card.dart';
import 'package:hology_fe/features/home/widgets/header.dart';
import 'package:hology_fe/shared/theme.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
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
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
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
                        CategoryTimeSlider(),
                        SizedBox(height: 20),
                        CourseCard()
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
