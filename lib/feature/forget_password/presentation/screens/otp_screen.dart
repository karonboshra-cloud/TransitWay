import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/forget_password_web_services.dart';
import 'change_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  bool _isLoading = false;

  bool isOtpComplete() => _controllers.every((c) => c.text.isNotEmpty);

  void _handleVerify() async {
    if (isOtpComplete()) {
      setState(() => _isLoading = true);

      String fullCode = _controllers.map((e) => e.text).join();

      bool isValid = await ForgetPasswordWebServices().verifyOtp(
          email: widget.email,
          otp: fullCode
      );

      if (!mounted) return;

      setState(() => _isLoading = false);

      if (isValid) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(email: widget.email, code: fullCode)
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter the 6-digit code"))
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.w),
            Text("Enter the code", style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.w),
            Text("An authentication code has been sent to your email", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
            SizedBox(height: 40.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _otpBox(index)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF065D45),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
                ),
                onPressed: _isLoading ? null : _handleVerify,
                child: _isLoading
                    ? SizedBox(width: 25.w, height: 25.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text("Verify", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 30.w),
          ],
        ),
      ),
    );
  }

  Widget _otpBox(int index) {
    return Container(
      width: 45.w,
      height: 55.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: TextField(
        controller: _controllers[index],
        autofocus: index == 0,
        onChanged: (value) {
          if (value.length == 1 && index < 5) FocusScope.of(context).nextFocus();
          if (value.isEmpty && index > 0) FocusScope.of(context).previousFocus();
        },
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF065D45)),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
      ),
    );
  }
}