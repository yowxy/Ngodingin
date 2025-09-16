import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hology_fe/features/course/screens/course_detail.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/course_list_provider.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({super.key});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  // simpan state love per index
  final Set<int> _lovedCourses = {};

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseListProvider>(context);
    final courses = courseProvider.courses;

    if (courseProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (courses.isEmpty) {
      return const Center(child: Text('Tidak ada kursus ditemukan'));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        final isLoved = _lovedCourses.contains(index);

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
            padding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
            margin: const EdgeInsets.only(bottom: 20),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      course.thumbnailUrl != ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                course.thumbnailUrl,
                                width: 115,
                                height: 115,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 115,
                              height: 115,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(Icons.image_not_supported),
                            ),
                      const SizedBox(width: 15),
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
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/star.svg",
                                  height: 15,
                                  width: 15,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '${course.rating}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isLoved) {
                        _lovedCourses.remove(index);
                      } else {
                        _lovedCourses.add(index);
                      }
                    });
                  },
                  icon: Icon(
                    isLoved ? Icons.favorite : Icons.favorite_border,
                    color: isLoved ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
