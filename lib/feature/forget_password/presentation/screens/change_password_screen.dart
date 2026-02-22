import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/forget_password_web_services.dart';
import 'success_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email, code;
  const ChangePasswordScreen({super.key, required this.email, required this.code});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _isLoading = false;

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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.w),
                Text(
                    "Change Password",
                    style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 10.w),
                Text(
                    "Please enter a new password",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14.sp)
                ),
                SizedBox(height: 40.w),

                _buildField(
                  _passController,
                  "New Password",
                  isHidden: _isPasswordHidden,
                  onToggle: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
                ),
                SizedBox(height: 20.w),

                _buildField(
                  _confirmController,
                  "Confirm Password",
                  isConfirm: true,
                  isHidden: _isConfirmPasswordHidden,
                  onToggle: () => setState(() => _isConfirmPasswordHidden = !_isConfirmPasswordHidden),
                ),

                SizedBox(height: 20.w),
                _buildRequirementItem("At least 8 characters"),
                _buildRequirementItem("Contains Uppercase & Lowercase letters"),
                _buildRequirementItem("Contains numbers & special characters (!@#\$%)"),

                SizedBox(height: 60.w),

                SizedBox(
                  width: double.infinity,
                  height: 55.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF065D45),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
                    ),
                    onPressed: _isLoading ? null : _handleReset,
                    child: _isLoading
                        ? SizedBox(width: 25.w, height: 25.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text("Reset Password", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 30.w),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.w),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 14.sp, color: Colors.grey),
          SizedBox(width: 8.w),
          Expanded(child: Text(text, style: TextStyle(color: Colors.grey, fontSize: 13.sp))),
        ],
      ),
    );
  }

  void _handleReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      bool success = await ForgetPasswordWebServices().confirmReset(
          widget.email,
          widget.code,
          _passController.text
      );
      setState(() => _isLoading = false);

      if (success) {
        if (!mounted) return;
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessScreen()));
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to reset password. Please check your data."))
        );
      }
    }
  }

  Widget _buildField(
      TextEditingController ctrl,
      String hint,
      {bool isConfirm = false,
        required bool isHidden,
        required VoidCallback onToggle}
      ) {
    return TextFormField(
      controller: ctrl,
      obscureText: isHidden,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 16.w),
        prefixIcon: Icon(Icons.lock_outline, color: const Color(0xFF065D45), size: 22.sp),
        suffixIcon: IconButton(
          icon: Icon(isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20.sp),
          onPressed: onToggle,
        ),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.w)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.w),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return "Field is required";

        if (isConfirm) {
          if (v != _passController.text) return "Passwords do not match";
          return null;
        }

        if (v.length < 8) return "Must be at least 8 characters";

        bool hasUppercase = v.contains(RegExp(r'[A-Z]'));
        bool hasLowercase = v.contains(RegExp(r'[a-z]'));
        bool hasDigits = v.contains(RegExp(r'[0-9]'));
        bool hasSpecialCharacters = v.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

        if (!hasUppercase) return "Must contain at least one uppercase letter";
        if (!hasLowercase) return "Must contain at least one lowercase letter";
        if (!hasDigits) return "Must contain at least one number";
        if (!hasSpecialCharacters) return "Must contain at least one special character";

        return null;
      },
    );
  }
}