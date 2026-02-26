import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transite_way/feature/home/presentation/screens/tracking_view.dart';

import '../widgets/custom_points_badge.dart';

class BusTrackingScreen extends StatefulWidget {
  const BusTrackingScreen({super.key});

  @override
  State<BusTrackingScreen> createState() => _BusTrackingScreenState();
}

class _BusTrackingScreenState extends State<BusTrackingScreen> {
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
                Container(
                  height: 0.5.sh,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/maps.jpg',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 0.35.sh,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildBusDetailsCard(),
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
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
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

  Widget _buildBusDetailsCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bus Details", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Bus Number", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
                decoration: BoxDecoration(color: const Color(0xFF1B6A4C), borderRadius: BorderRadius.circular(15.r)),
                child: Text("359", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text("Arrives In 15 mins", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B6A4C))),
          SizedBox(height: 20.h),
          _buildRouteFlow(),
          SizedBox(height: 20.h),
          Text("Route", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          Text(
            "El Shrouk City - El Mashtal - El Shrouk Central - Heliopolis Club - El Shrouk Academy - British University - Suez Gate 1 - Suez Road - Fifth Settlement",
            style: TextStyle(color: Colors.black87, fontSize: 13.sp, height: 1.4),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TrackingView()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B6A4C),
              minimumSize: Size(double.infinity, 55.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
            ),
            child: Text("Track Bus", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteFlow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("From", style: TextStyle(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.bold)),
            Text("El Shrouk City", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
          ],
        ),
        const Text("-", style: TextStyle(fontSize: 24, color: Colors.grey)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("To", style: TextStyle(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.bold)),
            Text("Fifth Settlement", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
          ],
        ),
      ],
    );
  }
}