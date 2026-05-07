import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/product_model.dart';
import '../../core/constants/app_colors.dart';

class AddProductController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // متغيرات النصوص
  var title = "".obs;
  var description = "".obs;
  var price = "".obs;

  // العملة والنوع
  var selectedCurrency = "ر.ي".obs;
  var selectedCategory = "جوالات".obs;

  // الفلترة في شاشة الهوم
  var selectedCategoryHome = "جوالات".obs;

  // مسارات الصور
  var posterPath = "".obs;
  var additionalImages = <String>[].obs; // قائمة الصور الإضافية

  // قائمة المنتجات الكلية والمفضلة
  var allProducts = <ProductModel>[].obs;
  var favoriteProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // تهيئة 3 أماكن للصور الإضافية
    additionalImages.assignAll(["", "", ""]);
  }

  // دالة اختيار وقص الصور
  Future<void> pickImage(bool isPoster, {int? index}) async {
    try {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 70
      );

      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'تعديل الصورة',
              toolbarColor: AppColors.primaryOrange,
              toolbarWidgetColor: Colors.white,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
              ],
            ),
            IOSUiSettings(title: 'تعديل الصورة'),
          ],
        );

        if (croppedFile != null) {
          if (isPoster) {
            posterPath.value = croppedFile.path;
          } else {
            additionalImages[index!] = croppedFile.path;
          }
        }
      }
    } catch (e) {
      Get.snackbar("تنبيه", "فشل اختيار أو قص الصورة");
    }
  }

  // دالة الحفظ (تم تعديلها لإرسال الصور الإضافية)
  void saveProduct() {
    if (title.value.isEmpty || posterPath.value.isEmpty || price.value.isEmpty) {
      Get.snackbar(
          "تنبيه",
          "يرجى إكمال البيانات الأساسية وصورة الغلاف",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white
      );
      return;
    }

    // هنا النقص اللي كان عندك: تمرير additionalImages للمودل
    final newProduct = ProductModel(
      title: title.value,
      description: description.value,
      price: double.tryParse(price.value) ?? 0.0,
      category: selectedCategory.value,
      posterImage: posterPath.value,
      currency: selectedCurrency.value,
      additionalImages: List<String>.from(additionalImages.where((path) => path.isNotEmpty)),
    );

    allProducts.insert(0, newProduct);

    Get.back();

    Get.snackbar(
        "تم بنجاح",
        "تم نشر لقطتك الجديدة في قسم ${selectedCategory.value}",
        backgroundColor: Colors.green,
        colorText: Colors.white
    );

    _resetFields();
  }

  // دالة التواصل عبر الواتساب
  void contactSeller(String productName) async {
    var phone = "9677xxxxxxxx"; // تذكر تغيير الرقم هنا

    final Uri whatsappUrl = Uri.parse(
        "whatsapp://send?phone=$phone&text=${Uri.encodeComponent('أنا مهتم بـ $productName من تطبيق لقطة')}"
    );

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("خطأ", "لا يمكن فتح تطبيق الواتساب");
      }
    } catch (e) {
      Get.snackbar("تنبيه", "تطبيق الواتساب غير مثبت على هذا الجهاز");
    }
  }

  // دالة المفضلة (إضافة وحذف)
  void toggleFavorite(ProductModel product) {
    product.isFavorite.value = !product.isFavorite.value;

    if (product.isFavorite.value) {
      if (!favoriteProducts.contains(product)) {
        favoriteProducts.add(product);
      }
    } else {
      favoriteProducts.remove(product);
    }
  }

  // إعادة تعيين الحقول
  void _resetFields() {
    title.value = "";
    description.value = "";
    price.value = "";
    posterPath.value = "";
    selectedCategory.value = "جوالات";
    selectedCurrency.value = "ر.ي";
    additionalImages.assignAll(["", "", ""]);
  }
}