import 'package:flutter/material.dart';
import 'package:yeneta_flutter/screens/quizzes/quize_screen.dart';
import 'package:yeneta_flutter/widgets/base_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TutorialScreen extends StatefulWidget {
  final String subject;
  final int level;
  final dynamic tutorials;

  const TutorialScreen({
    super.key,
    required this.subject,
    required this.level,
    required this.tutorials,
  });

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int currentIndex = 0;

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
                const Text('Good job!', style: TextStyle(fontSize: 18)),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ReadyToQuizScreen(
                              subject: widget.subject,
                              level: widget.level,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 18,
                    ),
                    backgroundColor: Color(0xFFFFCF25),
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
    final tutorialList =
        widget.tutorials is List ? widget.tutorials : [widget.tutorials];
    final tutorial = tutorialList[currentIndex];
    final question = tutorial['title'] ?? 'No title';
    final explanation = tutorial['text'] ?? '';
    final image = tutorial['image'] ?? null;
    final score = (currentIndex + 1).toString();
    final levelTitle = 'Level ${widget.level}';

    return BaseScaffold(
      title: levelTitle,
      showAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    levelTitle,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    score,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(question, style: const TextStyle(fontSize: 16)),
              if (image != null && image != '')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Center(child: Image.network(image, height: 120)),
                ),
              const SizedBox(height: 16),
              const Text(
                'Explanation',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(explanation, style: const TextStyle(fontSize: 16)),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE0B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  onPressed:
                      currentIndex < tutorialList.length - 1
                          ? () {
                            setState(() {
                              currentIndex++;
                            });
                          }
                          : () {
                            _showCompletionPopup();
                          },
                  child: Text(
                    currentIndex < tutorialList.length - 1
                        ? 'Next'
                        : 'Finish Course',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ReadyToQuizScreen extends StatefulWidget {
  final String subject;
  final int level;
  const ReadyToQuizScreen({
    super.key,
    required this.subject,
    required this.level,
  });

  @override
  State<ReadyToQuizScreen> createState() => _ReadyToQuizScreenState();
}

class _ReadyToQuizScreenState extends State<ReadyToQuizScreen> {
  bool isLoading = false;

  Future<void> fetchQuizzes(String subject, int level) async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to view quizzes')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
          'https://yeneta-api.onrender.com/api/quizes?subject=$subject&level=$level',
        ),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final quizzes = responseData['quizzes'] ?? [];
        if (quizzes.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No quiz found for this level')),
          );
        } else {
          // Extract questions from the quizzes
          final List<dynamic> questions =
              quizzes
                  .expand(
                    (quiz) => (quiz['questions'] ?? []) as Iterable<dynamic>,
                  )
                  .toList();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => QuizScreen(
                    quizzes: questions,
                    subject: widget.subject,
                    level: widget.level,
                  ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to load quizzes')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login_image.png',
              width: 500,
              height: 200,
            ),
            const SizedBox(height: 100),
            const Text(
              'Ready to take the Quiz?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFA5B8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    fetchQuizzes(widget.subject, widget.level);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9CEAC0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
