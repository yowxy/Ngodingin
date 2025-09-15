import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';
import 'package:hology_fe/shared/theme.dart';

class MyCourseList extends StatelessWidget {
  const MyCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeDataProvider = Provider.of<HomeDataProvider>(context);
    final courses = homeDataProvider.enrolledCourses;

    if (homeDataProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (courses.isEmpty) {
      return const Center(child: Text('Belum ada kursus yang diikuti'));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Container(
          height: 110,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 10, top: 5, left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              course.thumbnailUrl.isNotEmpty
                  ? Image.network(course.thumbnailUrl, height: 120, width: 120)
                  : Container(height: 120, width: 120, color: Colors.grey[300]),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            course.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: semibold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${course.progressCourse}%",
                          style: TextStyle(fontSize: 16, fontWeight: semibold),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 5,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(99)
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
