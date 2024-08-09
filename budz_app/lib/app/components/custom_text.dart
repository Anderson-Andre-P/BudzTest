import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextTitle extends StatelessWidget {
  const CustomTextTitle({super.key, required this.words});

  final String words;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        words,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2.sp,
          fontFamily: "Outfit",
          color: const Color.fromRGBO(0, 0, 0, 1),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class CustomTextSubTitle extends StatelessWidget {
  const CustomTextSubTitle({super.key, required this.words, this.align});

  final String words;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        words,
        textAlign: align ?? TextAlign.center,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15.sp,
          fontFamily: "Outfit",
          color: const Color.fromRGBO(0, 0, 0, 1),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class CustomTextBody extends StatelessWidget {
  const CustomTextBody({super.key, required this.words});

  final String words;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        words,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2.sp,
          fontFamily: "Outfit",
          color: const Color.fromRGBO(58, 72, 77, 1),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class CustomTextBodyTwo extends StatelessWidget {
  const CustomTextBodyTwo({super.key, required this.words});

  final String words;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        words,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2.sp,
          fontFamily: "Outfit",
          color: const Color.fromRGBO(58, 72, 77, 1),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        ),
      ),
    );
  }
}
