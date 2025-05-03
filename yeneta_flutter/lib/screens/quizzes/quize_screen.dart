import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String subject;
  final int level;
  final List quizzes;

  const QuizScreen({
    super.key,
    required this.subject,
    required this.level,
    required this.quizzes,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int? selectedOption;
  int score = 0; 
  bool showAnswer = false;

  void _showPopup(bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
                size: 80,
              ),
              const SizedBox(height: 16),
              Text(
                isCorrect ? 'Correct answer!' : 'Wrong answer!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                  if (currentIndex < widget.quizzes.length - 1) {
                    setState(() {
                      currentIndex++;
                      selectedOption = null;
                      showAnswer = false;
                    });
                  } else {
                    _showCompletionPopup(); 
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  currentIndex < widget.quizzes.length - 1 ? 'Next' : 'Finish',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCompletionPopup() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/completion_image.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Level Complete',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your Score: $score/${widget.quizzes.length}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Reward',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/candy.png', 
                  height: 50,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 18,
                    ),
                    backgroundColor: const Color(0xFFFFCF25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Yay, OK!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizList = widget.quizzes;
    if (quizList.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Text(
              'No quiz found for this level.',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
    final quiz = quizList[currentIndex];
    final question = quiz['question'] ?? '';
    final options = quiz['options'] ?? [];
    final correctAnswer = quiz['correctAnswer'];

    return Scaffold(
      appBar: AppBar(title: Text('Quiz ${currentIndex + 1}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                quizList.length,
                (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: i == currentIndex ? Colors.pink : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: i == currentIndex ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(options.length, (i) {
              final optionLetter = String.fromCharCode(65 + i);
              final isSelected = selectedOption == i;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = i;
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? const Color(0xFFB4F8C8)
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            isSelected
                                ? const Color(0xFFB4F8C8)
                                : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Text(
                          optionLetter,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            options[i],
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[200],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed:
                    selectedOption == null
                        ? null
                        : () {
                          final selectedLetter = String.fromCharCode(
                            65 + selectedOption!,
                          );
                          final isCorrect = selectedLetter == correctAnswer;
                          if (isCorrect) {
                            score++; 
                          }
                          _showPopup(isCorrect);
                        },
                child: Text(
                  currentIndex < quizList.length - 1 ? 'Next' : 'Finish Quiz',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
