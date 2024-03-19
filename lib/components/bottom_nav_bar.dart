import 'package:flutter/material.dart';
import 'package:payezy/providers/nav_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

   @override
  Widget build(BuildContext context) {
    final navigationProvider=Provider.of<NavigationProvider>(context);
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
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 9.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(0.5.h),
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                    
                      navigationProvider.setCurrentIndex(0);
                     
                     // Navigator.popAndPushNamed(context, '/homepage');
                    },
                    icon:navigationProvider.currentIndex==0?
                    Image.asset('assets/activeSendIcon.png'):
                    Image.asset('assets/inactiveSendIcon.png'),
            
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0.1.h),
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      navigationProvider.setCurrentIndex(1);
                    },
                    icon:navigationProvider.currentIndex==1?
                    Image.asset('assets/activeProfileIcon.png'):
                    Image.asset('assets/inactiveProfileIcon.png'),
                  ),
                ),Padding(
                  padding:  EdgeInsets.all(0.1.h),
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      navigationProvider.setCurrentIndex(2);
                    },
                    icon:
                    navigationProvider.currentIndex==2?
                    Image.asset('assets/activeTransferIcon.png'):
                    Image.asset('assets/inactiveTransferIcon.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
}
