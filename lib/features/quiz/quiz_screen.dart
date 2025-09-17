import 'package:flutter/material.dart';
import 'package:hology_fe/features/quiz/widget/buttonQuiz.dart';
import 'package:hology_fe/features/quiz/widget/nextButton.dart';
import 'package:hology_fe/features/quiz/widget/textQuiz.dart';
import 'package:hology_fe/models/quiz_model.dart';
import 'package:hology_fe/providers/QuizProvider/quiz_provider.dart';
import 'package:hology_fe/shared/theme.dart';
import 'package:provider/provider.dart';

class QuizPages extends StatefulWidget {
  final String lessonId;
  final List<Map<String, dynamic>> quizzesData;

  const QuizPages({
    super.key,
    required this.lessonId,
    required this.quizzesData,
  });

  @override
  State<QuizPages> createState() => _QuizPagesState();
}

class _QuizPagesState extends State<QuizPages> {
  late final List<QuizQuestion> _quizzes;
  int _current = 0;
  final Map<String, String> _answers = {}; // quizId -> selected choice

  @override
  void initState() {
    super.initState();
    _quizzes = widget.quizzesData.map((e) => QuizQuestion.fromJson(e)).toList();
  }

  void _onSubmit() async {
    print("_onSubmit called"); // Debug log
    print("Current answers: $_answers"); // Debug log
    
    final provider = Provider.of<QuizProvider>(context, listen: false);
    final result = await provider.submitQuiz(
      lessonId: widget.lessonId,
      answers: _answers,
      context: context,
    );
    print("Submit result: $result"); // Debug log
    
    if (!mounted) return;
    
    if (result != null) {
      // Show dialog and wait for user action
      final shouldRefresh = await showDialog<bool>(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (_) => AlertDialog(
          title: const Text('Hasil Quiz'),
          content: Text('Skor: ${result.score}/${result.maxScore}\n${result.message}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true to indicate refresh needed
              },
              child: const Text('Kembali ke Course'),
            ),
          ],
        ),
      );
      
      // If dialog returned true, go back to course detail with refresh flag
      if (shouldRefresh == true && mounted) {
        Navigator.of(context).pop(true); // Back to course detail with refresh flag
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_quizzes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Quiz', style: blackTextStyle.copyWith(fontWeight: semibold, fontSize: 18)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Tidak ada quiz untuk lesson ini'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }

    final total = _quizzes.length;
    final currentQuiz = _quizzes[_current];
    final selected = _answers[currentQuiz.id];

    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Quiz',
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
                                    text: '${_current + 1}',
                                    style: greenTextStyle.copyWith(
                                      fontWeight: semibold,
                                      fontSize: 24,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '/$total',
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
                          value: (_current + 1) / total,
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
                                text: currentQuiz.question,
                                height: 90,
                                width: 382,
                              ),
                              const SizedBox(height: 20),
                              ...currentQuiz.choices.asMap().entries.map((entry) {
                                final index = entry.key;
                                final choice = entry.value;
                                final letters = ['A', 'B', 'C', 'D'];
                                final letter = index < letters.length ? letters[index] : '${index + 1}';
                                
                                return Column(
                                  children: [
                                    _QuizButton(
                                      text: choice,
                                      letter: letter,
                                      isSelected: selected == choice,
                                      onTap: () {
                                        setState(() {
                                          _answers[currentQuiz.id] = choice;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                );
                              }).toList(),
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
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15))
                      ),
                      child: Consumer<QuizProvider>(
                        builder: (_, qp, __) => nextButtonQuiz(
                          text: qp.isSubmitting 
                              ? 'Loading...'
                              : (_current < total - 1 ? 'Selanjutnya' : 'Selesai'),
                          width: double.infinity,
                          height: 30,
                          onPressed: qp.isSubmitting 
                              ? null 
                              : () {
                                  print("Button clicked! Current: $_current, Total: $total"); // Debug log
                                  print("Selected answer: $selected"); // Debug log
                                  
                                  if (selected == null || selected.isEmpty) {
                                    print("No answer selected, showing snackbar"); // Debug log
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Pilih salah satu jawaban dulu')), 
                                    );
                                    return;
                                  }
                                  if (_current < total - 1) {
                                    print("Moving to next question"); // Debug log
                                    setState(() => _current++);
                                  } else {
                                    print("Last question, calling _onSubmit"); // Debug log
                                    _onSubmit();
                                  }
                                },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _QuizButton extends StatelessWidget {
  final String text;
  final String letter;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuizButton({
    required this.text,
    required this.letter,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green[100],
              child: Text(
                letter,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
