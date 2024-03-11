
import 'package:flutter/material.dart';
import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w), //padding
        child: Container(  //bottom bar
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [mainCardGradient1, mainCardGradient2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(5)),
              width: double.maxFinite,
              height: 7.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(1.h),
                child: IconButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/homepage');
                  },
                  icon:Image.asset('assets/bottomNavIcon1.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1.h),
                child: IconButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context,'/profile');
                  },
                  icon:Image.asset('assets/bottomNavIcon2.png'),
                ),
              ),Padding(
                padding:  EdgeInsets.all(1.h),
                child: IconButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/fetchData');
                  },
                  icon:Image.asset('assets/bottomNavIcon3.png'),
                ),
              ),
            ],
          ),
        ),
      );
}
}