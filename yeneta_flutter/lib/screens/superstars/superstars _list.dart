import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yeneta_flutter/screens/superstars/superstars_detail.dart';
import 'dart:convert';
import 'package:yeneta_flutter/widgets/base_scaffold.dart';

class SuperstarsScreen extends StatefulWidget {
  const SuperstarsScreen({super.key});

  @override
  State<SuperstarsScreen> createState() => _SuperstarsScreenState();
}

class _SuperstarsScreenState extends State<SuperstarsScreen> {
  List<dynamic> superstars = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchsuperstars();
  }

  Future<void> fetchsuperstars() async {
    try {
      final response = await http.get(
        Uri.parse('https://yeneta-api.onrender.com/api/stories/actor'),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          superstars = responseData;
          isLoading = false;
        });
        print('Response body: ${response.body}');
      } else {
        throw Exception('Failed to load superstars');
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
    return BaseScaffold(
      title: 'superstars',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Row(
              children: [
                const Text(
                  'superstars for You',
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
                      : superstars.isEmpty
                      ? const Center(child: Text('No superstars found'))
                      : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: superstars.length,
                        itemBuilder: (context, index) {
                          final story = superstars[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          SuperstarsDetail(superstar: story),
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
                                          story['image'] ??
                                              'https://i.pinimg.com/736x/05/95/ef/0595ef0dff385eabffc76f847d8df4a9.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    story['title'] ?? 'Untitled Story',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
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
