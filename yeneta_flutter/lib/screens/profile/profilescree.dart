import 'package:flutter/material.dart';
import 'package:yeneta_flutter/widgets/base_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Profile',
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 80, // Increased size of the avatar
                      backgroundImage: AssetImage(
                        "assets/images/profile_image.png",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Hi Abeba Abebe",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5), // Adjusted spacing
                        Image.asset(
                          "assets/images/love.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10), // Reduced spacing
              // Grid Menu
              GridView.count(
                shrinkWrap: true, // Prevents GridView from expanding
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling
                children: [
                  _buildMenuItem(
                    icon: Icons.home,
                    label: "Home",
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.star,
                    label: "Leaders",
                    onTap: () {
                      Navigator.pushNamed(context, '/leaders');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.emoji_events,
                    label: "Score",
                    onTap: () {
                      Navigator.pushNamed(context, '/score');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.emoji_emotions,
                    label: "Stickers",
                    onTap: () {
                      Navigator.pushNamed(context, '/stickers');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.card_membership,
                    label: "Certificates",
                    onTap: () {
                      Navigator.pushNamed(context, '/certificates');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.event,
                    label: "Events",
                    onTap: () {
                      Navigator.pushNamed(context, '/events_list');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 70), // Adjusted spacing
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF73DBD5), // Light teal
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/premium');
                  },
                  child: const Center(
                    child: Text(
                      "Upgrade to Premium",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFEE8B60), // Light orange
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
