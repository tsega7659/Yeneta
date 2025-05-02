import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventHistoryScreen extends StatefulWidget {
  const EventHistoryScreen({super.key});

  @override
  State<EventHistoryScreen> createState() => _EventHistoryScreenState();
}

class _EventHistoryScreenState extends State<EventHistoryScreen> {
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
        Uri.parse('https://yeneta-api.onrender.com/api/events/myEvents'),
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

  // Function to calculate countdown or determine if the event has passed
  String getEventStatus(String? eventDate) {
    if (eventDate == null) return 'Unknown';

    // Parse the event date (assuming the API returns a date in 'yyyy-MM-dd' format)
    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(eventDate);
    } catch (e) {
      return 'Invalid Date';
    }

    final now = DateTime.now(); // Current date: April 29, 2025
    final difference = parsedDate.difference(now);

    if (difference.isNegative) {
      return 'Already passed';
    } else {
      // Calculate countdown
      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;
      return '$days days, $hours hrs, $minutes mins';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.pink[100], // Pink background for the entire screen
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        elevation: 0,
        title: const Text(
          'Your Events',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : events.isEmpty
                ? const Center(child: Text('No events found'))
                : ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final status = getEventStatus(event['date']);
                    final isFutureEvent =
                        status != 'Already passed' &&
                        status != 'Invalid Date' &&
                        status != 'Unknown';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color:
                              isFutureEvent
                                  ? Colors.cyan[50]
                                  : Colors.yellow[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Event Number
                            Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Event Image
                            Container(
                              width: 50,
                              height: 50,
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
                            const SizedBox(width: 12),
                            // Event Name
                            Expanded(
                              child: Text(
                                event['title'] ?? 'No Title',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Event Status (Countdown or "Already passed")
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isFutureEvent
                                        ? Colors.cyan[200]
                                        : Colors.yellow[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isFutureEvent
                                    ? 'Reserved\n$status'
                                    : status == 'Already passed'
                                    ? 'Already passed'
                                    : 'ETB ${event['price']?.toString() ?? '0'}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
