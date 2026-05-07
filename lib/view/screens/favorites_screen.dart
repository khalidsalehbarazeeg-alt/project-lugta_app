import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controllers/add_product_controller.dart';
import 'product_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProductController>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("مفضلاتي", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white, elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Get.back()),
        ),
        body: Obx(() {
          if (controller.favoriteProducts.isEmpty) {
            return const Center(child: Text("قائمة المفضلة فارغة"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: controller.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = controller.favoriteProducts[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(File(product.posterImage), width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${product.price} ${product.currency}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => controller.toggleFavorite(product),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}