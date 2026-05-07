import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/registration_stepper.dart';
import 'otp_screen.dart'; // سننشئها لاحقاً
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/custom_button.dart';

class VerifyEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const RegistrationStepper(currentStep: 1), // الخطوة الأولى
            const SizedBox(height: 20),
            Icon(Icons.mark_email_read_outlined, size: 100, color: AppColors.primaryOrange),
            const SizedBox(height: 20),
            Text(AppStrings.verifyEmailTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(AppStrings.verifyEmailSub, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            _buildField(hint: "البريد الإلكتروني", icon: Icons.email_outlined),
            const SizedBox(height: 30),
            AppButton(
              text: AppStrings.verifyBtn,
              color: AppColors.primaryOrange,
              onPressed: () => Get.to(() => OtpScreen()), // الانتقال للخطوة التالية
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: Icon(icon, color: AppColors.primaryOrange),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}