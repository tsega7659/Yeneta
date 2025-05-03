import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeneta_flutter/screens/events/eventhistory.dart';

class EventDetailScreen extends StatefulWidget {
  final dynamic event;

  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isLoading = false;

  void showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Payment Method'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Image.asset(
                    'assets/images/chapa_logo.png',
                    width: 40,
                    height: 40,
                  ),
                  title: const Text('Chapa'),
                  onTap: () {
                    Navigator.pop(context);
                    rsvpEvent('Chapa');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    'assets/images/telebirr_logo.jpg',
                    width: 40,
                    height: 40,
                  ),
                  title: const Text('Telebirr'),
                  onTap: () {
                    Navigator.pop(context);
                    rsvpEvent('Telebirr');
                  },
                ),
              ],
            ),
          ),
    );
  }

  void showSuccessDialog(String paymentMethod) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Success!'),
            content: Text(
              'You have successfully reserved your place using $paymentMethod. We\'ve sent you an email with your ticket code.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EventHistoryScreen(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Future<void> rsvpEvent(String paymentMethod) async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please login to RSVP')));
        return;
      }

      print('Token: $token');
      print('Event ID: ${widget.event['_id']}');
      print('Selected Payment Method (for display only): $paymentMethod');

      final response = await http.post(
        Uri.parse(
          'https://yeneta-api.onrender.com/api/events/${widget.event['_id']}/rsvp',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'eventId': widget.event['_id']}),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        showSuccessDialog(paymentMethod);
      } else {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode} - ${response.body}'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print('Exception: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  String formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.event['title'] ?? 'Event Detail',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.event['image'] ??
                              'https://i.pinimg.com/736x/05/95/ef/0595ef0dff385eabffc76f847d8df4a9.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.event['title'] ?? 'Elmo is Here',
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
                  widget.event['description'] ?? 'Elmo is Here',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Date: ${formatDate(widget.event['dueDate'])}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Capacity: ${widget.event['attendanceCapacity']} seats',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : showPaymentMethodDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C4B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child:
                      isLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
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
