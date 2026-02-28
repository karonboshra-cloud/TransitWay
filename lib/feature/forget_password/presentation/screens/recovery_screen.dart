import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/forget_password_web_services.dart';
import 'otp_screen.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _showSnackBar(String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: isError ? Colors.redAccent : const Color(0xFF065D45),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text("Password Recovery", style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E232C))),
              SizedBox(height: 10.h),
              Text("Enter your email address to recover your password", style: TextStyle(fontSize: 14.sp, color: const Color(0xFF8391A1))),
              SizedBox(height: 35.h),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                  prefixIcon: Icon(Icons.email_outlined, color: const Color(0XFF054F3A), size: 22.sp),
                  hintText: "Email",
                  filled: true,
                  fillColor: const Color(0xFFF7F8F9),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFE8ECF4))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0XFF054F3A), width: 1.5)),
                ),
                validator: (v) => (v == null || v.isEmpty) ? "Please enter your email" : null,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF054F3A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                  onPressed: _isLoading ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isLoading = true);
                      bool ok = await ForgetPasswordWebServices().requestReset(_emailController.text);
                      setState(() => _isLoading = false);
                      if (ok) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(email: _emailController.text)));
                      } else {
                        _showSnackBar("This email is not registered.", true);
                      }
                    }
                  },
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Text("Send Link", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}