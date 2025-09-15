import 'package:flutter/material.dart';
import 'package:hology_fe/features/course/screens/course_detail.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';

class RecommendedCourseCard extends StatelessWidget {
  const RecommendedCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeDataProvider = Provider.of<HomeDataProvider>(context);
    final courses = homeDataProvider.recommendedCourses;

    if (homeDataProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (courses.isEmpty) {
      return const Center(child: Text('Tidak ada kursus ditemukan'));
    }

    return SizedBox(
      height: 245,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          final courseId = course['id'];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => CourseDetailProvider(courseId),
                    child: CourseDetail(courseId: courseId),
                  ),
                ),
              );
            },
            child: Container(
              width: 230,
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 0,
                right: 20,
              ),
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
                    child: course['thumbnail_url'] != null
                        ? Image.network(
                            course['banner_url'],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(height: 120, color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        course['description'] ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.play_circle_fill,
                                size: 18,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                course['videos']?.toString() ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 18,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${course['duration_hours']} Jam",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: lightGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
