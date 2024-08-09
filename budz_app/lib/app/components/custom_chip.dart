import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.words, this.color});

  final String words;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Chip(
        label: Text(
          words,
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2.sp,
            fontFamily: "Outfit",
          ),
        ),
        backgroundColor: color ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            40.r,
          ),
          side: BorderSide(
            width: 0.w,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
