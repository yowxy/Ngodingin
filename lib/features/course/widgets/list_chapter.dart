import 'package:flutter/material.dart';
import 'package:hology_fe/shared/theme.dart';

class ListChapter extends StatefulWidget {
  const ListChapter({super.key});

  @override
  State<ListChapter> createState() => _ListChapterState();
}

class _ListChapterState extends State<ListChapter> {
  final List<Map<String, String>> chapters = [
    {"title": "Pengenalan"},
    {"title": "Apa itu React JS"},
  ];

  String _formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: lightGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(99),
                ),
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.all(13),
                child: Center(
                  child: Text(
                    index.toString(),
                    style: TextStyle(fontWeight: semibold),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter["title"]!,
                      style: TextStyle(
                        fontWeight: semibold,
                        fontSize: 15,
                      ),
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${_formatDuration(const Duration(seconds: 1))} / ${_formatDuration(const Duration(minutes: 10))}",
                      style: TextStyle(fontSize: 13, color: lightGrey),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(99),
                ),
                margin: const EdgeInsets.only(right: 3),
                padding: const EdgeInsets.all(13),
                child: Image.asset("assets/images/lock.png"),
              ),
            ],
          ),
        );
      },
    );
  }
}