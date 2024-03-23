//Custom AppBar(Bar at the top of the app)
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title; //title of the appBar
  final bool? isVisible; //whether the notification icon is visible or not

   const CustomAppBar({super.key, required this.title, this.isVisible=false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.only(top:1.h),
        child: AppBar(
          scrolledUnderElevation: 0.0,
            leadingWidth: 150.w,
            //payezylogo
            leading: Padding(
              padding: EdgeInsets.only(left: 5.w,top: 1.h,),
              child: Text(title,
              
                  style: GoogleFonts.michroma(color: Colors.white, fontSize: 22.sp)),
            ),
        
            backgroundColor:Colors.transparent,
            elevation: 0, //z coordinate
            //Login button on the right
            actions: [
              if (isVisible ?? false)
              IconButton(
                onPressed: () {
                  // Action for the notification button
                },
                icon: SvgPicture.asset( 'assets/notifyIcon.svg'),
              
              ),
            ],
          ),
      ),
    );
  }
  
  @override
  
  Size get preferredSize =>  Size.fromHeight(8.h);
}