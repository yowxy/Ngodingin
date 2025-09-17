import 'package:flutter/material.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/features/quiz/quiz_screen.dart';

class ListChapter extends StatefulWidget {
  final String courseId;
  const ListChapter({super.key, required this.courseId});

  @override
  State<ListChapter> createState() => _ListChapterState();
}

class _ListChapterState extends State<ListChapter> {
  Widget _buildActionButton(lesson, bool isActiveLesson, bool isUnlocked, CourseDetailProvider courseDetailProvider, bool hasActiveLesson) {
    // Cek apakah lesson sudah completed (progress.is_completed = true)
    final bool isCompletedByProgress = lesson.progress?.isCompleted == true;
    
    print('DEBUG: Lesson ${lesson.title}');
    print('DEBUG: - isCompleted (from lesson): ${lesson.isCompleted}');
    print('DEBUG: - progress.is_completed: ${lesson.progress?.isCompleted}');
    print('DEBUG: - isCompletedByProgress: $isCompletedByProgress');
    print('DEBUG: - isActiveLesson: $isActiveLesson');
    
    // CEK COMPLETED TERLEBIH DAHULU - lesson yang sudah selesai (progress.is_completed = true)
    if (isCompletedByProgress) {
      return GestureDetector(
        onTap: () async {
          print('DEBUG: Completed lesson clicked - ID: ${lesson.id}, Title: ${lesson.title}');
          try {
            // Call setActiveLesson API to make this lesson active again
            await courseDetailProvider.setActiveLesson(lesson.id, context: context);
            print('DEBUG: setActiveLesson completed successfully');
          } catch (e) {
            print('DEBUG: setActiveLesson failed with error: $e');
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(99),
          ),
          margin: const EdgeInsets.only(right: 3),
          padding: const EdgeInsets.all(13),
          child: const Icon(Icons.check, color: Colors.white, size: 20),
        ),
      );
    }

    // Locked lessons - lesson yang belum bisa diakses
    if (!isUnlocked) {
      return Container(
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(99),
        ),
        margin: const EdgeInsets.only(right: 3),
        padding: const EdgeInsets.all(13),
        child: const Icon(Icons.lock, color: Colors.white, size: 20),
      );
    }

    // HANYA active lesson yang bisa menampilkan tombol Mulai/Selesaikan
    if (isActiveLesson) {
      final String? inProgressId = courseDetailProvider.inProgressLessonId;
      final bool isInProgress = inProgressId == lesson.id;

      if (isInProgress) {
        // Show Finish button
        return ElevatedButton.icon(
          onPressed: () async {
            final quizzesRaw = await courseDetailProvider.finishLesson(lesson.id, context: context);
            print('quiz: $quizzesRaw');
            if (!mounted) return;
            
            // Navigate to quiz and wait for result
            final needsRefresh = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (_) => QuizPages(
                  lessonId: lesson.id,
                  quizzesData: quizzesRaw ?? const [],
                ),
              ),
            );
            
            // If quiz completed and returned true, refresh course detail
            if (needsRefresh == true) {
              print('Refreshing course detail after quiz completion');
              await courseDetailProvider.fetchCourseDetail();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: orangeColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          icon: const Icon(Icons.flag),
          label: const Text("Selesaikan"),
        );
      } else {
        // Show Start button
        return ElevatedButton.icon(
          onPressed: () {
            courseDetailProvider.startLesson(lesson.id, context: context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: greenColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          icon: const Icon(Icons.play_arrow),
          label: const Text("Mulai"),
        );
      }
    }

    // Semua lesson lain (yang bukan active lesson) tidak menampilkan tombol apapun
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailProvider = Provider.of<CourseDetailProvider>(context);
    final chapters = courseDetailProvider.courseDetail;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: chapters?.lesson.length ?? 0,
      itemBuilder: (context, index) {
        final chapter = chapters!.lesson[index];
        final sequence = index + 1;
        
        // DEBUG: Print data lesson untuk melihat field apa saja yang ada
        print('DEBUG Chapter $sequence: ${chapter.toJson()}');
        
        // Logika untuk menentukan apakah lesson terbuka
        final activeLesson = chapters.activeLesson;
        final isActiveLesson = activeLesson?.id == chapter.id;
        final hasActiveLesson = activeLesson != null;
        
        // Cek apakah lesson sudah completed berdasarkan progress
        final bool isCompletedByProgress = chapter.progress?.isCompleted == true;
        
        // Cek apakah lesson punya progress (artinya pernah diakses)
        final bool hasProgress = chapter.progress != null;
        
        print('DEBUG: Lesson ${chapter.title} - hasProgress: $hasProgress, isCompletedByProgress: $isCompletedByProgress, isActiveLesson: $isActiveLesson');
        
        // Lesson terbuka jika:
        // 1. Sudah selesai (progress.is_completed = true)
        // 2. Adalah active lesson
        // 3. Lesson pertama dan user sudah enrolled
        // 4. Lesson yang punya progress (pernah diakses) - TAMBAHAN INI
        final isUnlocked = isCompletedByProgress ||
          isActiveLesson ||
          hasProgress ||
          (index == 0 && chapters.isEnrolled);

        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: isUnlocked ? greenColor.withOpacity(0.2) : lightGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(99),
                ),
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.all(13),
                child: Center(
                  child: Text(
                    sequence.toString(),
                    style: TextStyle(
                      fontWeight: semibold,
                      color: isUnlocked ? greenColor : lightGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter.title,
                      style: TextStyle(
                        fontWeight: semibold, 
                        fontSize: 15,
                        color: isUnlocked ? Colors.black : lightGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${chapter.durationMinutes} menit",
                      style: TextStyle(fontSize: 13, color: lightGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _buildActionButton(chapter, isActiveLesson, isUnlocked, courseDetailProvider, hasActiveLesson),
            ],
          ),
        );
      },
    );
  }
}
