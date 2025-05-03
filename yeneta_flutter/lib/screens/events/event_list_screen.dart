import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yeneta_flutter/screens/events/event_details_screen.dart';
import 'package:yeneta_flutter/screens/events/eventhistory.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<dynamic> events = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final response = await http.get(
        Uri.parse('https://yeneta-api.onrender.com/api/events'),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          events = responseData['events'] ?? [];
          isLoading = false;
        });
        print('Response body: ${response.body}');
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/home',
            ); 
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventHistoryScreen(),
                ),
              );
            },
            child: const Text(
              'Your events',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Row(
              children: [
                const Text(
                  'Events for You',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset("assets/images/love.png", width: 50, height: 50),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 32.0),
              decoration: BoxDecoration(
                color: Color(0xFFFFA5B8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(24.0),
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : events.isEmpty
                      ? const Center(child: Text('No events found'))
                      : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 columns
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          EventDetailScreen(event: event),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
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
                                  const SizedBox(height: 8),
                                  // Event Title
                                  Text(
                                    event['title'] ?? 'ELMO',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
