import 'package:flutter/material.dart';
import 'package:get/get.dart';

class textFieldWidget extends StatelessWidget {
  textFieldWidget({super.key, required this.hint, this.maxlines,required this.controller,this.isOptional=false});
  final String hint;
  final int? maxlines;
  bool? isOptional;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8, ),
        child: TextFormField(
          validator: (value) {
            if(value!.length > 0 || isOptional!){
              return null;
            }
            return "Please enter the $hint";
          },
          controller: controller,
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
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF42C3A7).withOpacity(0.1),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF42C3A7).withOpacity(0.5),
                width: 1,
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
