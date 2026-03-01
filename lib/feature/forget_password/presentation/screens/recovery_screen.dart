import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/forget_password_web_services.dart';
import 'confirm_email_screen.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _showSnackBar(String message, bool isError) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: isError ? Colors.redAccent : const Color(0XFF054F3A),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black)
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text("Password Recovery", style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              Text("Enter your phone number to recover your password", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
              SizedBox(height: 35.h),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_android_outlined, color: const Color(0XFF054F3A)),
                  hintText: "Phone Number",
                  filled: true,
                  fillColor: const Color(0xFFF7F8F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                validator: (v) => (v == null || v.isEmpty || v.length < 11) ? "Please enter a valid phone number" : null,
              ),
              SizedBox(height: 120.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF054F3A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                  onPressed: _isLoading ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isLoading = true);

                      // --- الجزء الخاص بالـ Skip مؤقتاً ---
                      await Future.delayed(const Duration(seconds: 1));
                      String? fakeEmail = "youssefmahmoud772@gmail.com";

                      setState(() => _isLoading = false);

                      if (fakeEmail != null && mounted) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmEmailScreen(fullEmail: fakeEmail)));
                      }
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Find Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}