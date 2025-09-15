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
    final categories = homeDataProvider.categories;

    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20), // biar tidak kepotong
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10), // jarak antar item
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              homeDataProvider.setCategory(category['id'] ?? '');
              print("Categoriii : ${category['id']}");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green.shade400 : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.green.shade400),
              ),
              child: Text(
                category['name'] ?? '',
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
