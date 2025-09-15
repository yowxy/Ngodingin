import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hology_fe/features/course/widgets/list_chapter.dart';
import 'package:hology_fe/features/course/widgets/rating_bottom_sheet.dart';
import 'package:hology_fe/features/leaderboard/screen/leaderboard.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';

class CourseDetail extends StatefulWidget {
  final String courseId;
  const CourseDetail({super.key, required this.courseId});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  String _formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _showRatingBottomSheet() {
    final courseDetailProvider = Provider.of<CourseDetailProvider>(
      context,
      listen: false,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChangeNotifierProvider.value(
        value: courseDetailProvider,
        child: RatingBottomSheet(courseId: widget.courseId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailProvider = Provider.of<CourseDetailProvider>(context);
    final courseDetail = courseDetailProvider.courseDetail;

    if (courseDetailProvider.errorUiMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Error",
            style: TextStyle(
              color: Colors.black,
              fontWeight: semibold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(courseDetailProvider.errorUiMessage!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: courseDetailProvider.fetchCourseDetail,
                child: Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            courseDetail?.course.title ?? "",
            style: TextStyle(
              color: Colors.black,
              fontWeight: semibold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                color: whitegreenColor,
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 64,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${_formatDuration(const Duration(seconds: 1))} / ${_formatDuration(const Duration(minutes: 10))}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.volume_up,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 10),
                                  const Icon(
                                    Icons.fullscreen,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(99)),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.all(Radius.circular(99)),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: whiteColor,
                        unselectedLabelColor: greenColor,
                        tabs: [
                          Tab(text: "Materi"),
                          Tab(text: "Deskripsi"),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: ListChapter(courseId: widget.courseId),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    courseDetail?.course.description ??
                                        "React JS adalah library JavaScript...", // Gunakan data provider
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.play_circle_fill,
                                        color: Colors.green,
                                        size: 50,
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Siswa",
                                            style: TextStyle(
                                              fontWeight: semibold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "${courseDetail?.course.totalStudents.toString() ?? 10} Siswa",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: lightGrey,
                                            ),
                                          ), // Gunakan data provider
                                        ],
                                      ),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: orangeColor.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(
                                            99,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/star.svg",
                                              width: 20,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "${courseDetail?.rating.average.toString() ?? 4.5} (${courseDetail?.rating.count.toString() ?? 100} ulasan)",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: semibold,
                                              ),
                                            ), // Gunakan data provider
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orangeColor,
                            foregroundColor: whiteColor,
                            textStyle: TextStyle(
                              fontWeight: medium,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: _showRatingBottomSheet,
                          child: const Text("Ulasan"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor,
                            foregroundColor: whiteColor,
                            textStyle: TextStyle(
                              fontWeight: medium,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            if (courseDetail != null) {
                              if (courseDetail.isEnrolled) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Leaderboard(courseId: courseDetail.course.id),
                                  ),
                                );
                              } else {
                                courseDetailProvider.enrollCourse(
                                  courseDetail.course.id,
                                  context: context,
                                );
                              }
                            }
                          },
                          child: Text(
                            courseDetail?.isEnrolled == true
                                ? "Leaderboard"
                                : "Daftar",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
