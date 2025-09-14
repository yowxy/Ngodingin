import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hology_fe/features/course/screens/course_detail.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/course_list_provider.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseListProvider>(context);
    final courses = courseProvider.courses;

    if (courseProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (courses.isEmpty) {
      return Center(child: Text('Tidak ada kursus ditemukan'));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => CourseDetailProvider(course.id),
                  child: CourseDetail(courseId: course.id),
                ),
              ),
            );
          },
          child: Container(
            height: 110,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 20),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.network(
                        course.image,
                        width: 115,
                        height: 115,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 115,
                            height: 115,
                            color: Colors.grey[300],
                            child: Icon(Icons.broken_image),
                          );
                        },
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              course.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: semibold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/star.svg",
                                  height: 15,
                                  width: 15,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  '${course.rating}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Icon(LineIcons.heart),
              ],
            ),
          ),
        );
      },
    );
  }
}
