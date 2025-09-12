import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/course_list_provider.dart';

class CategoryTimeSlider extends StatefulWidget {
  const CategoryTimeSlider({super.key});

  @override
  State<CategoryTimeSlider> createState() => _CategoryTimeSliderState();
}

class _CategoryTimeSliderState extends State<CategoryTimeSlider> {
  int _selectedIndex = 0;

  final List<String> categories = ["Semua", "Populer", "Terbaru", "Terlama"];
  final List<String> filters = ["all", "popular", "terbaru", "terlama"];

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
              Provider.of<CourseListProvider>(context, listen: false)
                  .setFilter(filters[index]);
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
