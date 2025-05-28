import 'package:flutter/material.dart';

class IconoMeGustaHorizontal extends StatelessWidget {
  final Color color; 

  const IconoMeGustaHorizontal({
    super.key,
    this.color = Colors.red, 
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      color: color, 
      size: 22,
    );
  }
}