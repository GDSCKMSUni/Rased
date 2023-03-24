import 'package:flutter/material.dart';

class textFieldWidget extends StatelessWidget {
  const textFieldWidget({super.key, required this.hint, this.maxlines});
  final String hint;
  final int? maxlines;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8, ),
        child: TextField(
          maxLines: maxlines,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF42C3A7),
                width: 2,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }
}