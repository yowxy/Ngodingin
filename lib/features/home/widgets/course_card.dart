import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hology_fe/features/course/screens/course_detail.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/course_list_provider.dart';
import 'package:hology_fe/utils/snack_message.dart'; // Import custom snack message

class CourseCard extends StatefulWidget {
  const CourseCard({super.key});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  void initState() {
    super.initState();
    // Fetch favorite status saat widget dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider = Provider.of<CourseListProvider>(context, listen: false);
      courseProvider.fetchFavoriteStatus();
    });
  }

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
        final isLoved = courseProvider.isFavorite(course.id);

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
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 115,
                                    height: 115,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(Icons.image_not_supported),
                                  );
                                },
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
                  onPressed: () async {
                    // Show loading indicator saat toggle favorite
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

                    // Store nilai isLoved sebelum toggle
                    final wasLoved = isLoved;

                    // Toggle favorite via API
                    final success = await courseProvider.toggleFavorite(course.id);
                    
                    // Close loading dialog
                    if (mounted) {
                      Navigator.of(context).pop();
                    }

                    // PERBAIKI: Gunakan custom snack message
                    if (mounted) {
                      if (success) {
                        // Berhasil toggle favorite
                        final message = wasLoved 
                            ? 'Kursus berhasil dihapus dari favorit' 
                            : 'Kursus berhasil ditambahkan ke favorit';
                        successMessage(message: message, context: context);
                      } else {
                        // Gagal toggle favorite
                        final message = wasLoved
                            ? 'Gagal menghapus kursus dari favorit'
                            : 'Kursus sudah ada di favorit atau gagal menambahkan';
                        errorMessage(message: message, context: context);
                      }
                    }
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
