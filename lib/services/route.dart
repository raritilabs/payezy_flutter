import 'package:flutter/material.dart';

Route<Object?> _createRoute(Widget route) {
    return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1, 0);
      const end = Offset.zero;
      
      return SlideTransition(
      position: Tween(begin: begin, end: end).animate(animation),
        child: child,
      );
    },
  );
  }