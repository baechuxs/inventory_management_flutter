import 'package:flutter/material.dart';
import 'package:storeit/oop_pillars/abstract_color.dart';
import 'package:window_manager/window_manager.dart';

class Headerdrawer extends StatefulWidget {
  const Headerdrawer({super.key});

  @override
  State<Headerdrawer> createState() => _HeaderdrawerState();
}

class _HeaderdrawerState extends State<Headerdrawer> {
  bool _isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PrimaryColor().getColor(),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "STORE IT!",
            style: TextStyle(
              color: AccentColor().getColor(),
              fontSize: 50,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Inventory Management App",
            style: TextStyle(
              color: AccentColor().getColor(),
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  "Fullscreen",
                  style: TextStyle(
                    color: Color.fromRGBO(251, 220, 92, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              Switch(
                value: _isFullScreen,
                onChanged: (value) {
                  setState(() {
                    _isFullScreen = value;
                    _toggleFullScreen(value);
                  });
                },
                activeColor: const Color.fromARGB(255, 255, 255, 255),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleFullScreen(bool value) {
    if (value) {
      windowManager.setFullScreen(true);
    } else {
      windowManager.setFullScreen(false);
    }
  }
}
