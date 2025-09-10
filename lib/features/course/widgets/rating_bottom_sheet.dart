import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

class RatingBottomSheet extends StatefulWidget {
  const RatingBottomSheet({super.key});

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
                backgroundColor: _selectedRating > 0 ? greenColor : Colors.grey[300],
                foregroundColor: _selectedRating > 0 ? whiteColor : Colors.grey[500],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _selectedRating > 0
                  ? () {
                      print("Rating: $_selectedRating");
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Terima kasih atas ulasan $_selectedRating bintang!"),
                          backgroundColor: greenColor,
                        ),
                      );
                    }
                  : null,
              child: Text(
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