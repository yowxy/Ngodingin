import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hology_fe/features/course/screens/course_detail.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:line_icons/line_icons.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({super.key});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  final List<Map<String, String>> courses = [
    {
      "title": "React JS",
      "image": "assets/images/react.png",
      "videos": "10 Video",
      "rating": "4.2",
    },
    {
      "title": "React JS",
      "image": "assets/images/react.png",
      "videos": "10 Video",
      "rating": "4.2",
    },
    {
      "title": "React JS",
      "image": "assets/images/react.png",
      "videos": "10 Video",
      "rating": "4.2",
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(builder: (_) => CourseDetail()),
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
                Row(
                  children: [
                    Image.asset(course["image"]!, height: 120, width: 120),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          course["title"]!,
                          style: TextStyle(fontSize: 14, fontWeight: semibold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          course["videos"]!,
                          style: TextStyle(
                            fontSize: 12,
                            color: lightGrey,
                            fontWeight: semibold,
                          ),
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
                            Text(course["rating"]!),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(LineIcons.heart),
              ],
            ),
          ),
        );
      },
    );
  }
}
