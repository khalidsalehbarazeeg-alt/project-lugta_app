import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../models/product_model.dart';
import '../../controllers/add_product_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProductController>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // الصورة الرئيسية وزر العودة
            Stack(
              children: [
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(product.posterImage)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50, right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // العنوان والسعر
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          Text("${product.price} ${product.currency}",
                              style: TextStyle(fontSize: 20, color: AppColors.primaryOrange, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // --- عرض الصور الإضافية ---
                      const Text("صور المنتج", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.additionalImages.length,
                          itemBuilder: (context, i) {
                            if (product.additionalImages[i].isEmpty) return const SizedBox();
                            return Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(File(product.additionalImages[i])),
                                    fit: BoxFit.cover
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text("الوصف", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(product.description, style: TextStyle(color: Colors.grey[700], height: 1.5)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // شريط الأزرار السفلي
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.contactSeller(product.title),
                  icon: const Icon(Icons.chat, color: Colors.white),
                  label: const Text("تواصل عبر الواتس", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF075E54),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // زر القلب التفاعلي للمفضلة
              Obx(() => GestureDetector(
                onTap: () => controller.toggleFavorite(product),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: product.isFavorite.value ? Colors.red[50] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    product.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                    color: product.isFavorite.value ? Colors.red : Colors.grey,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}