import 'package:flutter/material.dart';
import 'package:yeneta_flutter/widgets/base_scaffold.dart';

class SuperstarsDetail extends StatelessWidget {
  final dynamic superstar;
  const SuperstarsDetail({super.key, required this.superstar});

  @override
  Widget build(BuildContext context) {
    // Debugging: Print the superstar object to verify its structure
    print(superstar);

    // Ensure superstar is a Map
    if (superstar is! Map) {
      return Scaffold(
        body: Center(
          child: Text(
            'Invalid data format for superstar',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return BaseScaffold(
      title: 'Superstar Detail',
      extendBodyBehindAppBar: true,
      showAppBar: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    superstar['image'] ??
                        'https://i.pinimg.com/736x/05/95/ef/0595ef0dff385eabffc76f847d8df4a9.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          superstar['title'] ?? 'Untitled Superstar',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        superstar['text'] ?? 'No superstar content available',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
