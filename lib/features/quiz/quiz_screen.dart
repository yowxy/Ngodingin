import 'package:flutter/material.dart';
import 'package:hology_fe/features/quiz/widget/buttonQuiz.dart';
import 'package:hology_fe/features/quiz/widget/nextButton.dart';
import 'package:hology_fe/features/quiz/widget/textQuiz.dart';
import 'package:hology_fe/shared/theme.dart';

class QuizPages extends StatelessWidget {
  const QuizPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/chose-prefrences',
              (route) => false,
            );
          },
        ),
        title: Text(
          'Pengenalan React JS',
          style: blackTextStyle.copyWith(fontWeight: semibold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.green[100],
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pertanyaan",
                              style: blackTextStyle.copyWith(
                                fontWeight: semibold,
                                fontSize: 12,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '3',
                                style: greenTextStyle.copyWith(
                                  fontWeight: semibold,
                                  fontSize: 24,
                                ),
                                children: [
                                  TextSpan(
                                    text: '/5',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Time",
                              style: blackTextStyle.copyWith(
                                fontWeight: semibold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "01:45",
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 21,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                
                    const SizedBox(height: 20),
                
                    // Progress bar
                    LinearProgressIndicator(
                      value: 1 / 5,
                      minHeight: 8,
                      color: Colors.green,
                      backgroundColor: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                
                    const SizedBox(height: 20),
                
                    Expanded(
                      child: ListView(
                        children: [
                          textQuiz(
                            text: 'Apa itu React js',
                            height: 90,
                            width: 382,
                          ),
                          const SizedBox(height: 20),
                          ButtonQuiz(
                            text: 'asjdbas',
                            width: double.infinity,
                            height: 52,
                          ),
                          const SizedBox(height: 15),
                          ButtonQuiz(
                            text: 'asjdbas',
                            width: double.infinity,
                            height: 52,
                          ),
                          const SizedBox(height: 15),
                          ButtonQuiz(
                            text: 'asjdbas',
                            width: double.infinity,
                            height: 52,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                  ),
                  child: nextButtonQuiz(
                    text: 'Selanjutnya',
                    width: double.infinity,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
