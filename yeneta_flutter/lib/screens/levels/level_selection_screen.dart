import 'package:flutter/material.dart';
import 'package:yeneta_flutter/widgets/base_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yeneta_flutter/screens/levels/tutorial_screen.dart';

class LevelData {
  final int level;
  final String title;
  LevelData({required this.level, required this.title});
}

class LevelSelectionScreen extends StatefulWidget {
  final String subject;
  const LevelSelectionScreen({super.key, required this.subject});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  List<LevelData> levels = [];
  List tutorials = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTutorialsForSubject();
  }

  Future<void> _fetchTutorialsForSubject() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to view tutorials')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }
    final url =
        'https://yeneta-api.onrender.com/api/tutorials?subject=${widget.subject}';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        tutorials =
            responseData['tutorials'] ?? []; // Extract the 'tutorials' list
        // Extract unique levels and their titles
        final levelMap = <int, String>{};
        for (final t in tutorials) {
          if (t['level'] != null && t['title'] != null) {
            levelMap[t['level']] = t['title'];
          }
        }
        levels =
            levelMap.entries
                .map((e) => LevelData(level: e.key, title: e.value))
                .toList()
              ..sort((a, b) => a.level.compareTo(b.level));
        setState(() {
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to load tutorials. Please try again later.'),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onLevelTap(LevelData levelData) {
    final filtered =
        tutorials.where((t) => t['level'] == levelData.level).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TutorialScreen(
              subject: widget.subject,
              level: levelData.level,
              tutorials: filtered,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Color(0xFFB9F6CA), // Green
      Color(0xFFB2EBF2), // Blue
      Color(0xFFFFCDD2), // Red
      Color(0xFFFFF9C4), // Yellow
      Color(0xFFB3E5FC), // Light Blue
      Color(0xFFE1BEE7), // Purple
    ];

    return BaseScaffold(
      title: widget.subject,
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : levels.isEmpty
                ? const Center(child: Text('No levels found for this subject.'))
                : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Color(0xFFFFE0B2),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "${widget.subject} is fun!",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE57300),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Select a Topic",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE57300),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 18,
                              crossAxisSpacing: 18,
                              childAspectRatio: 1.1,
                            ),
                        itemCount: levels.length,
                        itemBuilder: (context, index) {
                          final level = levels[index];
                          final color = colors[index % colors.length];
                          return GestureDetector(
                            onTap: () => _onLevelTap(level),
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Level ${level.level}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.teal[900],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      level.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.teal[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
