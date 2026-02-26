import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPointsBadge extends StatelessWidget {
  final String points;
  const CustomPointsBadge({super.key, this.points = "9833"});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFCDDFDA),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.amber, size: 20.sp),
          SizedBox(width: 5.w),
          Text(points, style: TextStyle(color: const Color(0xFF1B5E20), fontWeight: FontWeight.bold, fontSize: 16.sp)),
        ],
      ),
    );
  }
}