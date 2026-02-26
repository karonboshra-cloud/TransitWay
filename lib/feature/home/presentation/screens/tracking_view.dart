import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_points_badge.dart';

class TrackingView extends StatelessWidget {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),

          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 0.61.sh,
                  child: Image.asset(
                    'assets/images/track bus.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "15 mins  1.3 km",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bus Number",
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "359",
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildLocationItem("From", "El Shorouk City"),
                            Text("-", style: TextStyle(fontSize: 24.sp, color: Colors.black38)),
                            _buildLocationItem("To", "Fifth Settlement"),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.black)
            ),
            Text("Transit", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
            Text("Way", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B6A4C))),
            Icon(Icons.location_on, color: const Color(0xFF1B6A4C), size: 22.sp),
            const Spacer(),
            const CustomPointsBadge(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationItem(String label, String city) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.black54, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 40.h),
        Text(
          city,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}