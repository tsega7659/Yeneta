import 'package:flutter/material.dart';

class StoryDetailScreen extends StatelessWidget {
  final dynamic story;

  const StoryDetailScreen({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: Column(
          children: [
            // Story Image (Rectangular and full width)
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      story['image'] ??
                          'https://i.pinimg.com/736x/05/95/ef/0595ef0dff385eabffc76f847d8df4a9.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Content Section
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Story Title with Book Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            story['title'] ?? 'Untitled Story',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Category Badge
                      // Center(
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 16,
                      //       vertical: 8,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xFFFFA5B8),
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     child: Text(
                      //       story['category'] ?? 'Uncategorized',
                      //       style: const TextStyle(
                      //         fontSize: 14,
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      // Story Text
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          story['text'] ?? 'No story content available',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Read More Button
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
