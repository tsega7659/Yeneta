import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Text
              const Text(
                "Hi, Abeba",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                  childAspectRatio: 1.0, // Square cards
                  children: [
                    _buildSubjectCard(
                      title: "Maths",
                      subtitle: "40 topics",
                      color: const Color(0xFFFF9999), // Light red
                      icon: Icons.calculate,
                      onTap: () {
                        // Navigate to Maths screen
                        Navigator.pushNamed(context, '/maths');
                      },
                    ),
                    _buildSubjectCard(
                      title: "SCIENCE",
                      subtitle: "45 topics",
                      color: const Color(0xFFD1C4E9), // Light purple
                      icon: Icons.science,
                      onTap: () {
                        // Navigate to Science screen
                        Navigator.pushNamed(context, '/science');
                      },
                    ),
                    _buildSubjectCard(
                      title: "Amharic",
                      subtitle: "30 topics",
                      color: const Color(0xFFB2DFDB), // Light teal
                      icon: Icons.edit,
                      onTap: () {
                        // Navigate to Amharic screen
                        Navigator.pushNamed(context, '/amharic');
                      },
                    ),
                    _buildSubjectCard(
                      title: "English",
                      subtitle: "20 videos",
                      color: const Color(0xFFFFECB3), // Light yellow
                      icon: Icons.language,
                      onTap: () {
                        // Navigate to English screen
                        Navigator.pushNamed(context, '/english');
                      },
                    ),
                    _buildSubjectCard(
                      title: "Stories",
                      subtitle: "",
                      color: const Color(0xFFB9EAFB), // Light blue
                      icon: Icons.book,
                      onTap: () {
                        // Navigate to Stories screen
                        Navigator.pushNamed(context, '/stories');
                      },
                    ),
                    _buildSubjectCard(
                      title: "Songs",
                      subtitle: "",
                      color: const Color(0xFFF0C6FB), // Light yellow
                      icon: Icons.music_note,
                      onTap: () {
                        // Navigate to Songs screen
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 32),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Icon(Icons.person, size: 32),
            ),
            label: "",
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.orange,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
