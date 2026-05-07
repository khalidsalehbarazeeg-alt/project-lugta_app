import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../logic/controllers/add_product_controller.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProductController>();

    final List<String> categories = ["جوالات", "إلكترونيات", "سيارات", "ساعات"];
    final List<String> currencies = ["ر.ي", "ر.س", "\$"];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("إضافة لقطة جديدة", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Get.back()),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("صورة الغلاف"),
              Obx(() => _buildImagePicker(160, double.infinity, Icons.add_a_photo, controller.posterPath.value, () => controller.pickImage(true))),

              const SizedBox(height: 10),

              _buildSectionTitle("صور إضافية"),
              Obx(() => Row(
                children: List.generate(3, (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: index == 2 ? 0 : 8.0),
                    child: _buildImagePicker(90, double.infinity, Icons.add_photo_alternate, controller.additionalImages[index], () => controller.pickImage(false, index: index)),
                  ),
                )),
              )),

              _buildTextField("عنوان المنتج", "مثال: آيفون 15 نظيف", (val) => controller.title.value = val),

              // --- قسم السعر والعملة (التعديل المطلوب) ---
              _buildSectionTitle("السعر واختيار العملة"),
              Row(
                children: [
                  // حقل السعر
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (val) => controller.price.value = val,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "0.00",
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // قائمة اختيار العملة
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: controller.selectedCurrency.value,
                          items: currencies.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontWeight: FontWeight.bold)))).toList(),
                          onChanged: (v) => controller.selectedCurrency.value = v!,
                        ),
                      )),
                    ),
                  ),
                ],
              ),

              _buildSectionTitle("تصنيف المنتج"),
              _buildDropdown(controller.selectedCategory, categories),

              _buildTextField("الوصف", "اكتب تفاصيل المنتج...", (val) => controller.description.value = val, isLong: true),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => controller.saveProduct(),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryOrange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  child: const Text("نشر الإعلان", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دوال مساعدة للتنسيق
  Widget _buildSectionTitle(String t) => Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)));

  Widget _buildTextField(String l, String h, Function(String) o, {bool isLong = false}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle(l),
      TextField(onChanged: o, maxLines: isLong ? 3 : 1, decoration: InputDecoration(hintText: h, filled: true, fillColor: Colors.grey[50], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
    ],
  );

  Widget _buildDropdown(RxString value, List<String> items) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
    child: Obx(() => DropdownButtonHideUnderline(child: DropdownButton<String>(isExpanded: true, value: value.value, items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(), onChanged: (v) => value.value = v!))),
  );

  Widget _buildImagePicker(double h, double w, IconData i, String p, VoidCallback t) => GestureDetector(
    onTap: t,
    child: Container(
      height: h, width: w,
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey[300]!),
          image: p.isNotEmpty ? DecorationImage(image: FileImage(File(p)), fit: BoxFit.cover) : null),
      child: p.isEmpty ? Icon(i, color: AppColors.primaryOrange, size: 28) : null,
    ),
  );
}