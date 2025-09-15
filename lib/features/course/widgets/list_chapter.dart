import 'package:flutter/material.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';

class ListChapter extends StatefulWidget {
  final String courseId;
  const ListChapter({super.key, required this.courseId});

  @override
  State<ListChapter> createState() => _ListChapterState();
}

class _ListChapterState extends State<ListChapter> {
  Widget _buildActionButton(lesson, bool isActiveLesson, bool isUnlocked, courseDetailProvider, bool hasActiveLesson) {
    // If lesson is completed, show check
    if (lesson.isCompleted) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(99),
        ),
        margin: const EdgeInsets.only(right: 3),
        padding: const EdgeInsets.all(13),
        child: const Icon(Icons.check, color: Colors.white, size: 20),
      );
    }

    // Locked lessons
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

    // If there is an active lesson, only it should show a "Finish" button
    if (hasActiveLesson) {
      if (isActiveLesson) {
        return ElevatedButton.icon(
          onPressed: () {
            courseDetailProvider.finishLesson(lesson.id, context: context);
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
        // Other unlocked lessons should not be actionable while another is active
        return const SizedBox.shrink();
      }
    }

    // No active lesson yet (user just enrolled): allow starting the first unlocked lesson
    return GestureDetector(
      onTap: () {
        courseDetailProvider.startLesson(lesson.id, context: context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: orangeColor,
          borderRadius: BorderRadius.circular(99),
        ),
        margin: const EdgeInsets.only(right: 3),
        padding: const EdgeInsets.all(13),
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
      ),
    );
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
        
        // Logika untuk menentukan apakah lesson terbuka
  final activeLesson = chapters.activeLesson;
  final isActiveLesson = activeLesson?.id == chapter.id;
  final hasActiveLesson = activeLesson != null;
        
        // Lesson terbuka jika:
        // 1. Sudah selesai
        // 2. Adalah active lesson
        // 3. Lesson pertama dan user sudah enrolled
    final isUnlocked = chapter.isCompleted ||
      isActiveLesson ||
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
