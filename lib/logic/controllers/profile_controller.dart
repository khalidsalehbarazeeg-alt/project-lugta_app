import 'package:flutter/material.dart'; // هذا السطر يحل مشكلة الألوان Colors
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // متغيرات البيانات الشخصية
  var name = ".....".obs;
  var email = "........".obs;
  var username = ".......".obs;
  var phone = "+967 ........".obs;
  var profileImagePath = "".obs; // مسار الصورة الشخصية

  // دالة اختيار الصورة الشخصية
  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImagePath.value = image.path;
    }
  }

  // دالة حفظ التعديلات
  void updateProfile() {
    // منطق الحفظ (يمكن ربطه بـ API لاحقاً)
    Get.back();
    Get.snackbar(
      "نجاح",
      "تم تحديث بيانات الملف الشخصي",
      backgroundColor: Colors.green, // الآن لن يظهر خط أحمر هنا
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}