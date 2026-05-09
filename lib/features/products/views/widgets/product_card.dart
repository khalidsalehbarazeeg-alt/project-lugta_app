import 'dart:io'; // أضفنا هذا لاستخدام File
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final dynamic product; // استخدمنا dynamic أو ProductModel حسب تعريفك
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. صورة المنتج (استخدمنا posterImage كما في ملف الهوم)
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(15)),
                child: Image.file(
                    File(product.posterImage), // التعديل هنا: استخدام posterImage
                    fit: BoxFit.cover,
                    width: double.infinity
                ),
              ),
            ),

            // 2. تفاصيل المنتج (استخدمنا title و currency كما في ملف الهوم)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title, // التعديل هنا: استخدام title بدلاً من name
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${product.price} ${product.currency}", // التعديل هنا: استخدام price و currency
                    style: TextStyle(
                      color: AppColors.primaryOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}