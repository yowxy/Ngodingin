import 'package:flutter/material.dart';

class MyCourse extends StatefulWidget {
  const MyCourse({super.key});

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  final List<Map<String, String>> courses = [
    {
      "title": "React JS",
      "desc": "Kursus react dari nol",
      "image": "assets/images/react.png",
      "videos": "10 Video",
      "duration": "10 Jam",
    },
    {
      "title": "Flutter",
      "desc": "Kursus flutter dari nol.",
      "image": "assets/images/flutter.png",
      "videos": "10 Video",
      "duration": "10 Jam",
    },
    {
      "title": "Python",
      "desc": "Kursus python dari nol.",
      "image": "assets/images/python.png",
      "videos": "10 Video",
      "duration": "10 Jam",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Container(
            width: 230,
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(right: 20),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: Image.asset(
                    course["image"]!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course["title"]!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      course["desc"]!,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.play_circle_fill,
                              size: 18,
                              color: Colors.green,
                            ),
                            SizedBox(width: 4),
                            Text(
                              course["videos"]!,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(width: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 18,
                              color: Colors.green,
                            ),
                            SizedBox(width: 4),
                            Text(
                              course["duration"]!,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}