import 'package:flutter/material.dart';

class CategoryCourseSlider extends StatefulWidget {
  const CategoryCourseSlider({super.key});

  @override
  State<CategoryCourseSlider> createState() => _CategoryCourseSliderState();
}

class _CategoryCourseSliderState extends State<CategoryCourseSlider> {
  int _selectedIndex = 0;

  final List<String> categories = [
    "All",
    "Frontend",
    "Backend",
    "UI/UX",
    "Machine Learning",
    "Mobile",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green.shade400 : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.green.shade400),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.green.shade400,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
