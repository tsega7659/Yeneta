import 'package:flutter/material.dart';
import 'package:yeneta_flutter/widgets/bottom_navigation_bar.dart';
import 'package:yeneta_flutter/screens/levels/level_selection_screen.dart';

class BaseScaffold extends StatefulWidget {
  final Widget body;
  final String title;
  final bool showAppBar;
  final bool extendBodyBehindAppBar;
  final List<Widget>? actions;
  final Widget? leading;

  const BaseScaffold({
    super.key,
    required this.body,
    this.title = '',
    this.showAppBar = true,
    this.extendBodyBehindAppBar = false,
    this.actions,
    this.leading,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/events_list');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/stories');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      appBar:
          widget.showAppBar
              ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  widget.title,
                  style: const TextStyle(color: Colors.black),
                ),
                leading: widget.leading,
                actions: widget.actions,
              )
              : null,
      body: widget.body,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
