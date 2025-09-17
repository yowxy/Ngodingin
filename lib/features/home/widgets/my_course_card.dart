import 'package:flutter/material.dart';
import 'package:hology_fe/features/course/screens/course_detail.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MyCourseCard extends StatefulWidget {
  const MyCourseCard({super.key});

  @override
  State<MyCourseCard> createState() => _MyCourseCardState();
}

class _MyCourseCardState extends State<MyCourseCard> {
  @override
  Widget build(BuildContext context) {
    final homeDataProvider = Provider.of<HomeDataProvider>(context);
    final courses = homeDataProvider.enrolledCourses;

    if (homeDataProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (courses.isEmpty) {
      return const Center(child: Text('Tidak ada kursus ditemukan'));
    }

    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Container(
            width: 230,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    course.thumbnailUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: semibold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Total video : ${course.totalVideo}",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return LinearPercentIndicator(
                          width:
                              constraints.maxWidth,
                          lineHeight: 6,
                          percent: course.progressCourse / 100,
                          backgroundColor: lightGrey.withOpacity(0.5),
                          progressColor: greenColor,
                          padding: EdgeInsets.zero,
                          barRadius: Radius.circular(99),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: lightGrey.withOpacity(0.3),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            course.activeLesson?.title ?? "Belum ada lesson aktif",
                            style: TextStyle(fontSize: 12, color: lightGrey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) =>
                                      CourseDetailProvider(course.id),
                                  child: CourseDetail(courseId: course.id),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 18,
                            ),
                            decoration: BoxDecoration(
                              color: orangeColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "Lanjut",
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
