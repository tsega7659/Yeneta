import 'package:flutter/material.dart';
import 'package:yeneta_flutter/widgets/base_scaffold.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  String userName = "User";

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('fullName') ?? "User";
    });
  }

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
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                        "assets/images/profile_image.png",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hi, $userName",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
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
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const NeverScrollableScrollPhysics(),
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
                      _showComingSoonDialog(context);
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF73DBD5),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    showPaymentMethodDialog(context);
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
            backgroundColor: const Color(0xFFEE8B60),
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

void showPaymentMethodDialog(BuildContext context) {
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
                  _showSuccessDialog(context, 'Chapa');
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
                  _showSuccessDialog(context, 'Telebirr');
                },
              ),
            ],
          ),
        ),
  );
}

void _showSuccessDialog(BuildContext context, String paymentMethod) {
  showDialog(
    context: context,
    builder:
        (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              Text(
                'Payment via $paymentMethod Successful!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEE8B60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
  );
}

void _showComingSoonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.face, color: Color(0xFFEE8B60), size: 80),
              const SizedBox(height: 16),
              const Text(
                'Certificates Page is Coming Soon!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEE8B60),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEE8B60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
  );
}
