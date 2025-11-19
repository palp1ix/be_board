import 'entities.dart';

class PostItem {
  final String title;
  final String description;
  final String imageUrl;
  final Author author;
  final double price;
  final double? oldPrice;
  final String category;
  final int? discountPercentage;
  final double rating;
  final bool isFavorite;
  final bool isBestDeal;
  final String location;
  final String createdAt;
  final List<String> gallery;

  PostItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.price,
    required this.location,
    required this.createdAt,
    required this.category,
    required this.rating,
    this.oldPrice,
    this.discountPercentage,
    this.isFavorite = false,
    this.isBestDeal = false,
    List<String>? gallery,
  }) : gallery = gallery ?? [imageUrl];
}
