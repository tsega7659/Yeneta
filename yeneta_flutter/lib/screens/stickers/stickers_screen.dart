import 'package:flutter/material.dart';

class MyStickersScreen extends StatelessWidget {
  const MyStickersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stickers = [
      {'image': "assets/images/candy.png"},
      {'image': "assets/images/food1.png"},
      {'image': "assets/images/food2.png"},
      {'image': "assets/images/food3.png"},
      {'image': "assets/images/woman.png"},
      {'image': "assets/images/astronut.png"},
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'My Stickers',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 185, 55, 8),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 1.0,
                            ),
                        itemCount: stickers.length,
                        itemBuilder: (context, index) {
                          final sticker = stickers[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  sticker['image'],
                                  height: 150,
                                  width: 150,
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: TabClipper(),
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, size.height, 0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
