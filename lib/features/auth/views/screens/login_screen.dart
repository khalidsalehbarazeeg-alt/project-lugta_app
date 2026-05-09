import 'package:flutter/material.dart';
import 'package:get/get.dart';
// 1. استيراد الواجهات الجديدة للتنقل
import '../../../../core/widgets/custom_button.dart';
import 'verify_email_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';


class LoginScreen extends StatelessWidget {
  final RxBool isPasswordHidden = true.obs;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 40),

              _buildInputField(
                hint: "البريد الإلكتروني أو رقم الجوال",
                icon: Icons.alternate_email,
              ),
              const SizedBox(height: 16),

              Obx(() => _buildInputField(
                hint: "كلمة المرور",
                icon: Icons.lock_outline_rounded,
                isPassword: true,
                obscureText: isPasswordHidden.value,
                onSuffixIconTap: () {
                  isPasswordHidden.value = !isPasswordHidden.value;
                },
              )),

              _buildForgotPassword(),
              const SizedBox(height: 32),

              AppButton(
                text: AppStrings.loginBtn,
                color: AppColors.primaryOrange,
                onPressed: () => Get.offAllNamed('/home'), // يدخل للرئيسية ويمسح صفحات التسجيل من الذاكرة
              ),

              const SizedBox(height: 24),
              // 2. تعديل الفاصل ليكون قابلاً للنقر وينقلنا لصفحة التسجيل
              _buildCustomDivider(),

              const SizedBox(height: 24),

              AppButton(
                text: AppStrings.guestEntryBtn,
                color: AppColors.secondaryBlue,
                isOutlined: true,
                onPressed: () => Get.offAllNamed('/home'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- التحسين في الفاصل لجعله تفاعلياً ---
  Widget _buildCustomDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell( // إضافة خاصية النقر
            onTap: () => Get.to(() => VerifyEmailScreen()), // الانتقال للقائمة الثانية
            child: const Text(
              AppStrings.signUpSection,
              style: TextStyle(
                color: AppColors.secondaryBlue, // تغيير اللون للأزرق ليوحي بأنه رابط
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline, // إضافة خط تحت النص
              ),
            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }

  // باقي الدوال (_buildHeader, _buildInputField, إلخ) تبقى كما هي في كودك السابق

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/luqta.jpeg',
          height: 150,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.shopping_bag, size: 100, color: AppColors.primaryOrange),
        ),
        const SizedBox(height: 10),
        const Text(
          AppStrings.welcome,
          style: TextStyle(color: AppColors.textGray, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixIconTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fieldBg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textAlign: TextAlign.right,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: isPassword
              ? IconButton(
            icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
            onPressed: onSuffixIconTap,
          )
              : null,
          suffixIcon: Icon(icon, color: AppColors.primaryOrange),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.scaffoldBg,
      elevation: 0,
      leading: IconButton(icon: const Icon(Icons.close, color: Colors.black), onPressed: () {}),
      title: const Text(AppStrings.loginTitle, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      centerTitle: true,
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(AppStrings.forgotPassword, style: TextStyle(color: AppColors.textGray)),
      ),
    );
  }
}