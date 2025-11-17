import 'entities.dart';

class PostItem {
  final String title;
  final String description;
  final String imageUrl;
  final Author author;
  final double price;
  final String location;
  final String timeAgo;

  PostItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.price,
    required this.location,
    required this.timeAgo,
  });
}
