import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class RegistrationStepper extends StatelessWidget {
  final int currentStep; // الخطوة الحالية: 1 أو 2 أو 3

  const RegistrationStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStep(step: 1, icon: Icons.email_outlined, title: "التحقق"),
          _buildLine(isActive: currentStep >= 2),
          _buildStep(step: 2, icon: Icons.lock_clock_outlined, title: "الرمز"),
          _buildLine(isActive: currentStep >= 3),
          _buildStep(step: 3, icon: Icons.person_outline, title: "البيانات"),
        ],
      ),
    );
  }

  Widget _buildStep({required int step, required IconData icon, required String title}) {
    bool isCompleted = currentStep > step;
    bool isActive = currentStep == step;

    return Column(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : (isActive ? AppColors.primaryOrange : Colors.grey[300]),
            shape: BoxShape.circle,
            boxShadow: isActive ? [BoxShadow(color: AppColors.primaryOrange.withOpacity(0.3), blurRadius: 10)] : null,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: (isActive || isCompleted) ? Colors.white : Colors.grey[600],
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? AppColors.primaryOrange : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildLine({required bool isActive}) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.only(bottom: 20), // ليتوسط الدوائر
      color: isActive ? AppColors.primaryOrange : Colors.grey[300],
    );
  }
}