
import 'package:flutter/material.dart';
import 'package:payezy/themes/colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [mainCardGradient1, mainCardGradient2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(5)),
              width: double.maxFinite,
              height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon:Image.asset('assets/bottomNavIcon1.png'),
              ),
              IconButton(
                onPressed: () {},
                icon:Image.asset('assets/bottomNavIcon2.png'),
              ),IconButton(
                onPressed: () {},
                icon:Image.asset('assets/bottomNavIcon3.png'),
              ),
            ],
          ),
        ),
      );
}
}