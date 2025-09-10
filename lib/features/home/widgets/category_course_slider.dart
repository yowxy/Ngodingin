import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/HomeProvider/home_data_provider.dart';

class CategoryCourseSlider extends StatefulWidget {
  const CategoryCourseSlider({super.key});

  @override
  State<CategoryCourseSlider> createState() => _CategoryCourseSliderState();
}

class _CategoryCourseSliderState extends State<CategoryCourseSlider> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeDataProvider>(context, listen: false).fetchCategories();
      Provider.of<HomeDataProvider>(context, listen: false).fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeDataProvider = Provider.of<HomeDataProvider>(context);
    final categories = homeDataProvider.categories.isNotEmpty
        ? homeDataProvider.categories
        : [
            "Semua",
            "Frontend",
            "Backend",
            "UI/UX",
            "Machine Learning",
            "Mobile"
          ];
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
              homeDataProvider.setCategory(categories[index]);
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
