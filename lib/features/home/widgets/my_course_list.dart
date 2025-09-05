import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

class MyCourseList extends StatefulWidget {
  const MyCourseList({super.key});

  @override
  State<MyCourseList> createState() => _MyCourseListState();
}

class _MyCourseListState extends State<MyCourseList> {
  final List<Map<String, String>> courses = [
    {
      "title": "React JS",
      "progress": "70%",
      "image": "assets/images/react.png",
    },
    {
      "title": "Flutter",
      "progress": "70%",
      "image": "assets/images/flutter.png",
    },
    {
      "title": "Python",
      "progress": "90%.",
      "image": "assets/images/python.png",
    },
    {
      "title": "Python",
      "progress": "90%.",
      "image": "assets/images/python.png",
    },
    {
      "title": "Python",
      "progress": "90%.",
      "image": "assets/images/python.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Container(
          height: 110,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 10, top: 5, left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(course["image"]!, height: 120, width: 120),
              const SizedBox(width: 15),
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
                            course["title"]!,
                            style: TextStyle(fontSize: 14, fontWeight: semibold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          course["progress"]!,
                          style: TextStyle(fontSize: 16, fontWeight: semibold),
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
    );
  }
}
