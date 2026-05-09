import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'complete_profile_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';


import '../../../../core/widgets/custom_button.dart';
import '../widgets/registration_stepper.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const RegistrationStepper(currentStep: 2), // الخطوة الثانية
            const SizedBox(height: 20),
            const Text("📬", style: TextStyle(fontSize: 80)),
            Text(AppStrings.otpTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(AppStrings.otpSub, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _otpBox(context)),
            ),
            const SizedBox(height: 40),
            AppButton(
              text: AppStrings.confirmBtn,
              color: AppColors.primaryOrange,
              onPressed: () => Get.to(() => CompleteProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(color: AppColors.fieldBg, borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.primaryOrange, width: 0.5)),
      child: TextField(
        onChanged: (value) { if(value.length == 1) FocusScope.of(context).nextFocus(); },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(counterText: "", border: InputBorder.none),
      ),
    );
  }
}