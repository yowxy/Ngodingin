import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

class MyCourseCard extends StatefulWidget {
  const MyCourseCard({super.key});

  @override
  State<MyCourseCard> createState() => _MyCourseCardState();
}

class _MyCourseCardState extends State<MyCourseCard> {
  final List<Map<String, String>> courses = [
    {
      "title": "React JS",
      "desc": "Kursus react dari nol",
      "image": "assets/images/react.png",
      "videos": "10",
      "duration": "10 Jam",
    },
    {
      "title": "Flutter",
      "desc": "Kursus flutter dari nol.",
      "image": "assets/images/flutter.png",
      "videos": "10",
      "duration": "10 Jam",
    },
    {
      "title": "Python",
      "desc": "Kursus python dari nol.",
      "image": "assets/images/python.png",
      "videos": "10",
      "duration": "10 Jam",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
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
                      "Total video : ${course["videos"]!}",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 5,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: lightGrey.withOpacity(0.5),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Apa itu react js cihuys",
                            style: TextStyle(fontSize: 12, color: lightGrey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 18,
                          ),
                          decoration: BoxDecoration(
                            color: orangeColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Lanjut",
                            style: TextStyle(color: whiteColor),
                          ),
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
