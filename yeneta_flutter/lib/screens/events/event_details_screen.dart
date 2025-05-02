import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final dynamic event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Allow the background to extend behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          event['title'] ?? 'Event Detail',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Event Image
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          event['image'] ??
                              'https://i.pinimg.com/736x/05/95/ef/0595ef0dff385eabffc76f847d8df4a9.jpg', // Fallback image
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Event Title with Heart Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event['title'] ?? 'Elmo is Here',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.favorite, color: Colors.pink, size: 24),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  event['description'] ?? 'Elmo is Here',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Event Date and Location
                Text(
                  '${event['date'] ?? 'May 7'}, ${event['location'] ?? 'Edna Mall'}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Event Time
                Text(
                  event['time'] ?? '3:00 am, Morning',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // RSVP Button
                ElevatedButton(
                  onPressed: () {
                    // Add RSVP functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C4B4), // Cyan color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'RSVP NOW',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
