import 'package:get/get.dart';

class ProductModel {
  final String title;
  final String description;
  final double price;
  final String category;
  final String posterImage;
  final List<String> additionalImages; // إضافة قائمة الصور
  final String currency;
  var isFavorite = false.obs; // حالة المفضلة

  ProductModel({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.posterImage,
    required this.additionalImages,
    required this.currency,
  });
}