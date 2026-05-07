import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/screens/login_screen.dart';
import 'view/screens/home_screen.dart';
// تأكد من استيراد الملفات الجديدة هنا (غير المسارات حسب مجلداتك)
import 'view/screens/product_details_screen.dart';
import 'view/screens/add_product_screen.dart';
import 'core/constants/app_strings.dart';

void main() {
  runApp(const LuqtaApp());
}

class LuqtaApp extends StatelessWidget {
  const LuqtaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      // دعم اللغة العربية بشكل افتراضي
      locale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Cairo', // تأكد من إضافة الخط في pubspec.yaml
      ),

      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () =>  LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),

        // الروابط الجديدة التي أضفناها للأزرار

        GetPage(
          name: '/add-product',
          page: () => const AddProductScreen(),
          transition: Transition.downToUp, // حركة صعود من الأسفل للأعلى لصفحة الإضافة
        ),
      ],
    );
  }
}