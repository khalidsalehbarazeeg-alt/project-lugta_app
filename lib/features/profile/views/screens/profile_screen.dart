import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import '../../../auth/views/screens/login_screen.dart'; // افترضنا وجود شاشة تسجيل الدخول

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("الملف الشخصي", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: AppColors.primaryOrange, // استخدام لون التطبيق الموحد
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // صورة المستخدم واسمه
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/user_placeholder.png'), // أضف صورة افتراضية
              ),
              const SizedBox(height: 15),
              const Text(
                "اسم المستخدم",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                "user@example.com",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // قائمة الخيارات (مثل الصورة المرفقة)
              _buildProfileOption(
                icon: Icons.person_outline,
                title: "عرض البيانات الشخصية",
                onTap: () {
                  Get.to(() => EditProfileScreen()); // الانتقال لشاشة التعديل
                },
              ),
              _buildProfileOption(
                icon: Icons.lock_outline,
                title: "تغيير كلمة المرور",
                onTap: () {
                  Get.to(() => const ChangePasswordScreen()); // يفتح شاشة تغيير كلمة المرور
                },
              ),
              _buildProfileOption(
                icon: Icons.person_add_alt,
                title: "تسجيل مستخدم جديد",
                onTap: () {
                  Get.to(() => LoginScreen()); // الانتقال لشاشة التسجيل
                },
              ),
              const SizedBox(height: 20),
              _buildProfileOption(
                icon: Icons.logout,
                title: "تسجيل الخروج",
                color: Colors.red,
                onTap: () {
                  // كود تسجيل الخروج
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت بناء خيار في القائمة
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}