import 'package:flutter/material.dart';
import 'package:hology_fe/features/course/screens/course_detail.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class FavoriteCourse extends StatefulWidget { // Ubah nama class agar tidak bentrok
  const FavoriteCourse({super.key});

  @override
  State<FavoriteCourse> createState() => _FavoriteCourseState();
}

class _FavoriteCourseState extends State<FavoriteCourse> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeDataProvider>(
      builder: (context, homeDataProvider, child) {
        final favoriteCourses = homeDataProvider.favoriteCourses; // Ambil data dari provider

        // Debug print
        print("Favorite courses count: ${favoriteCourses.length}");
        for (var course in favoriteCourses) {
          print("Favorite course: ${course.title}");
        }

        if (homeDataProvider.isLoading) {
          return Container(
            height: 270,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (favoriteCourses.isEmpty) {
          return Container(
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 48,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Belum ada kursus favorit',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tambahkan kursus ke favorit untuk melihatnya di sini',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: favoriteCourses.length,
            itemBuilder: (context, index) {
              final course = favoriteCourses[index];
              
              // Debug print untuk setiap course
              print("Building course card: ${course.title}");
              print("Progress: ${course.progressCourse}/${course.totalVideo}");
              
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
                    // Thumbnail dengan error handling
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: course.thumbnailUrl.isNotEmpty
                          ? Image.network(
                              course.thumbnailUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey[600],
                                    size: 40,
                                  ),
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 120,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.image,
                                color: Colors.grey[600],
                                size: 40,
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                    
                    // Course info
                    Expanded(
                      child: Column(
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
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          
                          // Progress bar
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
                          
                          // Divider
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: lightGrey.withOpacity(0.3),
                          ),
                          const SizedBox(height: 10),
                          
                          // Bottom section dengan favorite icon dan action button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        course.activeLesson?.title ?? 
                                        (course.lessons.isNotEmpty 
                                            ? "Mulai belajar" 
                                            : "Belum ada lesson"),
                                        style: TextStyle(fontSize: 12, color: lightGrey),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              
                              // Action button
                              InkWell(
                                onTap: () {
                                  // Navigate ke course detail
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
                                    course.progressCourse > 0 ? "Lanjut" : "Mulai",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}