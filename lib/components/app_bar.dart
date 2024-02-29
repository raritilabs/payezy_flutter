import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/string_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leadingWidth: 100,
        //payezylogo
        leading: Center(
          child: Text(send,
              style: GoogleFonts.michroma(color: Colors.white, fontSize: 25)),
        ),
    
        backgroundColor: mainBackgroundColor,
        elevation: 0, //z coordinate
        //Login button on the right
        actions: [
          IconButton(
            onPressed: () {},
            icon:Image.asset('assets/notifyIcon.png')
          ),
        ],
      );
  }
  
  @override
  
  Size get preferredSize => const Size.fromHeight(60);
}