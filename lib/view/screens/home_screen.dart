import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../logic/controllers/add_product_controller.dart';
import 'add_product_screen.dart';
import 'product_details_screen.dart';
import 'favorites_screen.dart'; // تأكد من استيراد شاشة المفضلات

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استدعاء الكنترولر
    final controller = Get.put(AddProductController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "لقطة",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // 1. حقل البحث
            _buildSearchField(),

            // 2. قائمة التصنيفات
            _buildCategoryList(controller),

            const SizedBox(height: 10),

            // 3. عرض المنتجات
            Expanded(
              child: Obx(() {
                final list = controller.allProducts
                    .where((p) => p.category == controller.selectedCategoryHome.value)
                    .toList();

                if (list.isEmpty) {
                  return const Center(child: Text("لا توجد إعلانات في هذا القسم حالياً"));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () => Get.to(() => ProductDetailsScreen(product: list[i])),
                    child: _buildProductCard(list[i]),
                  ),
                );
              }),
            ),
          ],
        ),

        // الزر العائم للإضافة
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryOrange,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
          onPressed: () => Get.to(() => const AddProductScreen()),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // الشريط السفلي (Bottom Navigation)
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomAction(Icons.home, "الرئيسية", true, () {}),
                _buildBottomAction(Icons.list_alt, "الإعلانات", false, () {}),

                const SizedBox(width: 40), // مساحة للزر العائم الوسطي

                // زر المفضلة التفاعلي
                _buildBottomAction(Icons.favorite_border, "المفضلة", false, () {
                  Get.to(() => const FavoritesScreen());
                }),

                _buildBottomAction(Icons.person_outline, "الملف الشخصي", false, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ودجت البحث
  Widget _buildSearchField() => Padding(
    padding: const EdgeInsets.all(15),
    child: TextField(
      decoration: InputDecoration(
        hintText: "بحث عن لقطة...",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    ),
  );

  // ودجت قائمة التصنيفات
  Widget _buildCategoryList(AddProductController controller) => SizedBox(
    height: 45,
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: ["جوالات", "إلكترونيات", "سيارات", "ساعات"].map((cat) => Obx(() {
        bool isSelected = controller.selectedCategoryHome.value == cat;
        return GestureDetector(
          onTap: () => controller.selectedCategoryHome.value = cat,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryOrange : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                cat,
                style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      })).toList(),
    ),
  );

  // ودجت كرت المنتج
  Widget _buildProductCard(product) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(20)),
            child: Image.file(File(product.posterImage), fit: BoxFit.cover, width: double.infinity),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text(
                "${product.price} ${product.currency}",
                style: TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ودجت بناء أزرار الشريط السفلي
  Widget _buildBottomAction(IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? AppColors.primaryOrange : Colors.grey[400], size: 26),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? AppColors.primaryOrange : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}