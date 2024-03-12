import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool? isVisible;

   const CustomAppBar({super.key, required this.title, this.isVisible=false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leadingWidth: 150.w,
        //payezylogo
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(title,
              style: GoogleFonts.michroma(color: Colors.white, fontSize: 30)),
        ),
    
        backgroundColor: mainBackgroundColor,
        elevation: 0, //z coordinate
        //Login button on the right
        actions: [
          if (isVisible ?? false)
          IconButton(
            onPressed: () {
              // Action for the notification button
            },
            icon: Image.asset('assets/notifyIcon.png'),
          ),
        ],
      );
  }
  
  @override
  
  Size get preferredSize =>  Size.fromHeight(6.h);
}