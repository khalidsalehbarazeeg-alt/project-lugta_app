import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // متغيرات للتحكم برؤية كلمة المرور
  bool _isOldObscure = true;
  bool _isNewObscure = true;
  bool _isConfirmObscure = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "تغيير كلمة المرور",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primaryOrange,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "تغيير كلمة المرور",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryOrange,
                ),
              ),
              const SizedBox(height: 40),

              // حقل كلمة المرور القديمة
              _buildPasswordField(
                label: "كلمة المرور القديمة",
                isObscure: _isOldObscure,
                onToggle: () => setState(() => _isOldObscure = !_isOldObscure),
              ),
              const SizedBox(height: 20),

              // حقل كلمة المرور الجديدة
              _buildPasswordField(
                label: "كلمة المرور الجديدة",
                isObscure: _isNewObscure,
                onToggle: () => setState(() => _isNewObscure = !_isNewObscure),
              ),
              const SizedBox(height: 20),

              // حقل تأكيد كلمة المرور
              _buildPasswordField(
                label: "تأكيد كلمة المرور",
                isObscure: _isConfirmObscure,
                onToggle: () => setState(() => _isConfirmObscure = !_isConfirmObscure),
              ),
              const SizedBox(height: 40),

              // زر التحديث
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // هنا تضع منطق التحقق والتحديث
                    Get.snackbar("نجاح", "تم تحديث كلمة المرور بنجاح",
                        backgroundColor: Colors.green, colorText: Colors.white);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "تحديث كلمة المرور",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت بناء حقول الإدخال
  Widget _buildPasswordField({
    required String label,
    required bool isObscure,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.primaryOrange),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.grey,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}