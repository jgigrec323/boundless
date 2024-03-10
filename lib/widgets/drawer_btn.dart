import 'package:flutter/material.dart';

class DrawerBtn extends StatefulWidget {
  bool drawerOpen = true;
  DrawerBtn({super.key, required this.drawerOpen});

  @override
  State<DrawerBtn> createState() => _DrawerBtnState();
}

class _DrawerBtnState extends State<DrawerBtn> {
  @override
  Widget build(BuildContext context) {
    return widget.drawerOpen
        ? Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 9,
                    offset: const Offset(1, 1),
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //condition ici
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 2,
                      height: 2,
                      decoration: const BoxDecoration(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 20,
                      height: 2,
                      decoration: const BoxDecoration(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 2,
                      height: 2,
                      decoration: const BoxDecoration(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 15,
                      height: 2,
                      decoration: const BoxDecoration(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 2,
                      height: 2,
                      decoration: const BoxDecoration(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 17,
                      height: 2,
                      decoration: const BoxDecoration(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 9,
                    offset: const Offset(1, 1),
                  ),
                ]),
            child: const Icon(Icons.close),
          );
  }
}
