import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool isVisible;

   const CustomAppBar({super.key, required this.title, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leadingWidth: 50.w,
        //payezylogo
        leading: Padding(
          padding: EdgeInsets.only(left:4.w,top: 1.h),
          child: Text(title,
              style: GoogleFonts.michroma(color: Colors.white, fontSize: 25)),
        ),
    
        backgroundColor: mainBackgroundColor,
        elevation: 0, //z coordinate
        //Login button on the right
        actions: [
          Visibility(
            visible: isVisible,
            child: IconButton(
              onPressed: () {},
              icon:Image.asset('assets/notifyIcon.png')
            ),
          ),
        ],
      );
  }
  
  @override
  
  Size get preferredSize =>  Size.fromHeight(6.h);
}