import 'dart:math';
import 'package:flutter/material.dart';
import 'package:storeit/oop_pillars/abstract_icon.dart';
import 'package:storeit/pages/productinpage.dart';
import 'package:storeit/pages/productoutpage.dart';
import 'package:storeit/pages/productupdatepage.dart';
import 'package:storeit/oop_pillars/abstract_color.dart';

class Popup extends StatefulWidget {
  const Popup({super.key});

  @override
  State<Popup> createState() => PopupState();
}

class PopupState extends State<Popup> with SingleTickerProviderStateMixin {
  bool toggle = true;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 150));

    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn);

    _controller.addListener(() {
      setState(() {});
    });
  }

  Alignment alignment1 = const Alignment(0.4, 0.3);
  Alignment alignment2 = const Alignment(0.4, 0.3);
  Alignment alignment3 = const Alignment(0.4, 0.3);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 250,
      width: 250,
      child: Stack(
        children: [
          AnimatedAlign(
            duration: toggle
                ? const Duration(milliseconds: 200)
                : const Duration(milliseconds: 500),
            alignment: alignment1,
            curve: toggle ? Curves.easeIn : Curves.elasticOut,
            child: AnimatedContainer(
              duration: toggle
                  ? const Duration(milliseconds: 250)
                  : const Duration(milliseconds: 500),
              curve: toggle ? Curves.easeIn : Curves.easeOut,
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: PrimaryColor().getColor(),
                borderRadius: BorderRadius.circular(60),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InPage()),
                  );
                },
                child: Icon(
                  IconIn().getIcon(),
                  size: 60,
                  color: const Color.fromARGB(255, 21, 237, 29),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: toggle
                ? const Duration(milliseconds: 200)
                : const Duration(milliseconds: 500),
            alignment: alignment2,
            curve: toggle ? Curves.easeIn : Curves.elasticOut,
            child: AnimatedContainer(
              duration: toggle
                  ? const Duration(milliseconds: 250)
                  : const Duration(milliseconds: 500),
              curve: toggle ? Curves.easeIn : Curves.easeOut,
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(60),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DeletePage()),
                  );
                },
                child: Icon(
                  IconOut().getIcon(),
                  size: 60,
                  color: const Color.fromARGB(255, 236, 46, 3),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: toggle
                ? const Duration(milliseconds: 200)
                : const Duration(milliseconds: 500),
            alignment: alignment3,
            curve: toggle ? Curves.easeIn : Curves.elasticOut,
            child: AnimatedContainer(
              duration: toggle
                  ? const Duration(milliseconds: 250)
                  : const Duration(milliseconds: 500),
              curve: toggle ? Curves.easeIn : Curves.easeOut,
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(60),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UpdatePage()),
                  );
                },
                child: Icon(
                  IconUpdate().getIcon(),
                  size: 60,
                  color: const Color.fromARGB(255, 32, 97, 182),
                ),
              ),
            ),
          ),
          Align(
              alignment: const Alignment(0.4, 0.3),
              child: Transform.rotate(
                angle: _animation.value * pi * (3 / 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  height: toggle ? 90 : 80,
                  width: toggle ? 90 : 80,
                  decoration: BoxDecoration(
                      color: PrimaryColor().getColor(),
                      borderRadius: BorderRadius.circular(60)),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (toggle) {
                              toggle = !toggle;
                              _controller.forward();
                              Future.delayed(const Duration(milliseconds: 10),
                                  () {
                                alignment1 = const Alignment(0.4, -1.4);
                              });
                              Future.delayed(const Duration(milliseconds: 10),
                                  () {
                                alignment2 = const Alignment(-1.4, 0.4);
                              });
                              Future.delayed(const Duration(milliseconds: 10),
                                  () {
                                alignment3 = const Alignment(-1, -0.9);
                              });
                            } else {
                              toggle = !toggle;
                              _controller.reverse();
                              alignment1 = const Alignment(0.4, 0.3);
                              alignment2 = const Alignment(0.4, 0.3);
                              alignment3 = const Alignment(0.4, 0.3);
                            }
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: 65,
                          color: AccentColor().getColor(),
                        )),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
