import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:hology_fe/providers/CourseDetailProvider/course_detail_provider.dart';

class RatingBottomSheet extends StatefulWidget {
  final String courseId;
  const RatingBottomSheet({super.key, required this.courseId});

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  int _selectedRating = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailProvider = Provider.of<CourseDetailProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          Text(
            "Beri Penilaian",
            style: TextStyle(
              fontSize: 18,
              fontWeight: semibold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          
          Text(
            "Bagaimana pengalaman belajar Anda?",
            style: TextStyle(
              fontSize: 14,
              color: lightGrey,
            ),
          ),
          const SizedBox(height: 20),
          
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      index < _selectedRating 
                          ? Icons.star 
                          : Icons.star_border,
                      color: orangeColor,
                      size: 40,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedRating > 0 && !courseDetailProvider.isLoading 
                    ? greenColor 
                    : Colors.grey[300],
                foregroundColor: _selectedRating > 0 && !courseDetailProvider.isLoading
                    ? whiteColor 
                    : Colors.grey[500],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _selectedRating > 0 && !courseDetailProvider.isLoading
                  ? () async {
                      await courseDetailProvider.ratingCourse(
                        courseId: widget.courseId,
                        rating: _selectedRating,
                        context: context,
                      );
                      
                      if (!courseDetailProvider.isLoading) {
                        Navigator.pop(context);
                      }
                    }
                  : null,
              child: courseDetailProvider.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      "Kirim Ulasan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: semibold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}