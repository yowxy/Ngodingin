import 'package:flutter/material.dart';
import 'package:hology_fe/features/course/screens/course_detail.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';

class RecommendedCourseCard extends StatelessWidget {
  const RecommendedCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeDataProvider = Provider.of<HomeDataProvider>(context);
    final courses = homeDataProvider.recommendedCourses;
    if (homeDataProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (courses.isEmpty) {
      return Center(child: Text('Tidak ada kursus ditemukan'));
    }
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
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
              print("Course ID : $courseId");
            },
            child: Container(
              width: 230,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
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
                    borderRadius: BorderRadius.circular(16),
                    child: course['banner_url'] != null
                        ? Image.network(
                            course['banner_url'],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(height: 120, color: Colors.grey[300]),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['title'] ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        course['short_description'] ?? '',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.play_circle_fill,
                                size: 18,
                                color: Colors.green,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${course['total_video']} Video',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(width: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 18,
                                color: Colors.green,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${course['duration_hours']} Jam',
                                style: TextStyle(fontSize: 12),
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
