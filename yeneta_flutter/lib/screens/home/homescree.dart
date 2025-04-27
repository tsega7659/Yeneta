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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Which subject do you want to learn today?",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
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
                    ),
                    _buildSubjectCard(
                      title: "SCIENCE",
                      subtitle: "45 topics",
                      color: const Color(0xFFD1C4E9), // Light purple
                      icon: Icons.local_hospital,
                    ),
                    _buildSubjectCard(
                      title: "Amharic",
                      subtitle: "30 topics",
                      color: const Color(0xFFB2DFDB), // Light teal
                      icon: Icons.edit,
                    ),
                    _buildSubjectCard(
                      title: "English",
                      subtitle: "20 videos",
                      color: const Color(0xFFFFECB3), // Light yellow
                      icon: Icons.language,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Super Stars Section
              Container(
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
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.orange,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      // Floating Buttons for Stories and Songs
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.orange,
            child: const Icon(Icons.book),
            mini: true,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.orange,
            child: const Icon(Icons.music_note),
            mini: true,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSubjectCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(icon, size: 40, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
