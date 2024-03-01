import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/themes/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool value;

   const CustomAppBar({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leadingWidth: 250,
        //payezylogo
        leading: Padding(
          padding: const EdgeInsets.only(left:30),
          child: Text(title,
              style: GoogleFonts.michroma(color: Colors.white, fontSize: 25)),
        ),
    
        backgroundColor: mainBackgroundColor,
        elevation: 0, //z coordinate
        //Login button on the right
        actions: [
          Visibility(
            visible: value,
            child: IconButton(
              onPressed: () {},
              icon:Image.asset('assets/notifyIcon.png')
            ),
          ),
        ],
      );
  }
  
  @override
  
  Size get preferredSize => const Size.fromHeight(60);
}