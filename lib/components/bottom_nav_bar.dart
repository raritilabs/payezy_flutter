
import 'package:flutter/material.dart';
import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex=0;
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
                   setState(() {
                     currentIndex=1;
                   });
                    Navigator.popAndPushNamed(context, '/homepage');
                  },
                  icon:Image.asset('assets/inactiveSendIcon.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1.h),
                child: IconButton(
                  onPressed: () {
                     setState(() {
                     currentIndex=2;
                   });
                    Navigator.popAndPushNamed(context,'/profile');
                  },
                  icon:Image.asset('assets/inactiveProfileIcon.png'),
                ),
              ),Padding(
                padding:  EdgeInsets.all(1.h),
                child: IconButton(
                  onPressed: () {
                    currentIndex=3;
                    Navigator.popAndPushNamed(context, '/fetchData');
                  },
                  icon:Image.asset('assets/inactiveTransferIcon.png'),
                ),
              ),
            ],
          ),
        ),
      );
}
}