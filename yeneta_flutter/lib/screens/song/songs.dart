import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';

class Song {
  final String id;
  final String title;
  final String audio;
  final String createdAt;
  final String updatedAt;

  Song({
    required this.id,
    required this.title,
    required this.audio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['_id'],
      title: json['title'],
      audio: json['audio'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class SongsScreen extends StatefulWidget {
  const SongsScreen({super.key});

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  late Future<List<Song>> futureSongs;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    futureSongs = fetchSongs();
  }

  Future<List<Song>> fetchSongs() async {
    final response = await http.get(
      Uri.parse('https://yeneta-api.onrender.com/api/songs'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> songsData =
          jsonResponse['songs'] ?? []; // Extract the 'songs' list
      return songsData.map((song) => Song.fromJson(song)).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }

  Future<void> playSong(String url) async {
  try {
    print("Initializing audio player...");
    await _audioPlayer.setUrl(url);
    print("Playing song...");
    await _audioPlayer.play();
  } catch (e) {
    print("Error playing song: $e");
  }
}

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Songs for You',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 64),
              decoration: BoxDecoration(
                color: Color(0xFFFFA5B8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(24.0),
              child: FutureBuilder<List<Song>>(
                future: futureSongs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No songs available'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final song = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color:
                              index % 2 == 0
                                  ? const Color(0xFF90E0EF)
                                  : const Color(0xFFFFE8A3),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          title: Text(
                            song.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => playSong(song.audio),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  index % 2 == 0
                                      ? const Color(0xFF48CAE4)
                                      : const Color(0xFFFFD60A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              'play',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
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
