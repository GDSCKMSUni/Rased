import 'package:flutter/material.dart';
import 'package:rasedapp_ye/utils/app_themes.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final void Function()? onPressed;

  const CircleButton({
    Key? key,
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: const BoxDecoration(
        color: AppThemes.primaryColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: iconSize,
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
