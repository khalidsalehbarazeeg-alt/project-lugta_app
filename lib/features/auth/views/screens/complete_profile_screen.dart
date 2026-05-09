import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/register_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/registration_stepper.dart';

class CompleteProfileScreen extends StatelessWidget {
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const RegistrationStepper(currentStep: 3), // الخطوة الثالثة والأخيرة
              const SizedBox(height: 20),
              Text(AppStrings.completeProfileTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              _buildField(hint: "الاسم الكامل", icon: Icons.person_outline),
              const SizedBox(height: 16),
              _buildField(hint: "البريد الإلكتروني", icon: Icons.email_outlined),
              const SizedBox(height: 16),
              _buildField(hint: "رقم الواتساب", icon: Icons.phone_android),
              const SizedBox(height: 16),

              // حقل كلمة المرور
              Obx(() => _buildField(
                hint: "كلمة المرور",
                icon: Icons.lock_outline,
                isPass: true,
                hide: controller.isPasswordHidden.value,
                onTap: controller.togglePassword,
              )),
              const SizedBox(height: 16),

              // حقل تأكيد كلمة المرور
              Obx(() => _buildField(
                hint: "إعادة كلمة المرور",
                icon: Icons.lock_reset,
                isPass: true,
                hide: controller.isConfirmPasswordHidden.value,
                onTap: controller.toggleConfirmPassword,
              )),

              const SizedBox(height: 40),
              AppButton(
                text: AppStrings.registerBtn,
                color: AppColors.secondaryBlue, // لون أزرق لتمييز التسجيل
                onPressed: () {
                  Get.offAllNamed('/home'); // الانتقال للرئيسية ومسح التاريخ
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String hint, required IconData icon, bool isPass = false, bool hide = false, VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        textAlign: TextAlign.right,
        obscureText: hide,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: isPass ? IconButton(icon: Icon(hide ? Icons.visibility_off : Icons.visibility), onPressed: onTap) : null,
          suffixIcon: Icon(icon, color: AppColors.primaryOrange),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}