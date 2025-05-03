import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeneta_flutter/screens/levels/level_selection_screen.dart';
import 'package:yeneta_flutter/widgets/base_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Kid";

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('fullName') ?? "Kid";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Home',
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Text
              Text(
                "Hi, $userName",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Which subject do you want to learn today?",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              // Subject Cards Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                  children: [
                    _buildSubjectCard(
                      title: "Maths",
                      subtitle: "40 topics",
                      color: const Color(0xFFFF9999),
                      icon: Icons.calculate,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    LevelSelectionScreen(subject: "Math"),
                          ),
                        );
                      },
                    ),
                    _buildSubjectCard(
                      title: "SCIENCE",
                      subtitle: "45 topics",
                      color: const Color(0xFFD1C4E9),
                      icon: Icons.science,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    LevelSelectionScreen(subject: "Science"),
                          ),
                        );
                      },
                    ),
                    _buildSubjectCard(
                      title: "Amharic",
                      subtitle: "30 topics",
                      color: const Color(0xFFB2DFDB),
                      icon: Icons.edit,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    LevelSelectionScreen(subject: "Amharic"),
                          ),
                        );
                      },
                    ),
                    _buildSubjectCard(
                      title: "English",
                      subtitle: "20 videos",
                      color: const Color(0xFFFFECB3),
                      icon: Icons.language,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    LevelSelectionScreen(subject: "English"),
                          ),
                        );
                      },
                    ),
                    _buildSubjectCard(
                      title: "Stories",
                      subtitle: "",
                      color: const Color(0xFFB9EAFB),
                      icon: Icons.book,
                      onTap: () {
                        Navigator.pushNamed(context, '/stories');
                      },
                    ),
                    _buildSubjectCard(
                      title: "Songs",
                      subtitle: "",
                      color: const Color(0xFFF0C6FB),
                      icon: Icons.music_note,
                      onTap: () {
                        Navigator.pushNamed(context, '/songs');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Super Stars Section
              GestureDetector(
                onTap: () {
                  // Navigate to Super Stars screen
                  Navigator.pushNamed(context, '/superstars');
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD), // Light blue
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Super Stars",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.star_border, size: 30, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(icon, size: 40, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
