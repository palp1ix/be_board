import 'package:be_board/core/core.dart';
import 'package:be_board/features/home/domain/entities/entities.dart';

final List<PostItem> mockPosts = [
  PostItem(
    id: 'mock-1',
    imageUrl: AppAssets.post1,
    title: 'Vintage Leather Armchair',
    description:
        'A detailed paragraph outlining the product\'s condition, features, dimensions, and other relevant information. This classic armchair brings a touch of timeless style to any room. It has been well-cared for and comes from a smoke-free home. The leather shows a beautiful, natural patina.',
    author: const Author(
      name: 'Alex Thompson',
      avatarUrl:
          'https://img.freepik.com/free-photo/young-handsome-man-wearing-casual-tshirt-blue-background-happy-face-smiling-with-crossed-arms-looking-camera-positive-person_839833-12963.jpg?semt=ais_hybrid&w=740&q=80',
    ),
    price: 350,
    oldPrice: 420,
    discountPercentage: 15,
    category: 'Interior',
    rating: 4.8,
    isBestDeal: true,
    location: 'New York',
    createdAt: '2 hours ago',
    gallery: [AppAssets.post1, AppAssets.post3, AppAssets.post4],
  ),
  PostItem(
    id: 'mock-2',
    imageUrl: AppAssets.post2,
    title: 'Classic 10-Speed Road Bike',
    description:
        'This bike is in excellent condition and perfect for city commuting. It has a lightweight frame, responsive brakes, and a comfortable saddle. Recently tuned up and ready to ride!',
    author: const Author(
      name: 'Maria Garcia',
      avatarUrl:
          'https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
    ),
    price: 200,
    oldPrice: 240,
    discountPercentage: 20,
    category: 'Technology',
    rating: 4.5,
    location: 'Brooklyn',
    createdAt: '5 hours ago',
    isFavorite: true,
    gallery: [AppAssets.post2, AppAssets.post1, AppAssets.post3],
  ),
  PostItem(
    id: 'mock-3',
    imageUrl: AppAssets.post3,
    title: 'Handmade Ceramic Mug Set',
    description:
        'Set of four beautiful, handcrafted ceramic mugs. Each mug is unique, with a speckled glaze finish. Microwave and dishwasher safe. Perfect for your morning coffee or tea.',
    author: const Author(
      name: 'David Kim',
      avatarUrl:
          'https://cdn.create.vista.com/api/media/small/20030237/stock-photo-cheerful-young-man-over-white',
    ),
    price: 45,
    category: 'Dishes',
    rating: 4.3,
    location: 'San Francisco',
    createdAt: '1 day ago',
    gallery: [AppAssets.post3, AppAssets.post4],
  ),
  PostItem(
    id: 'mock-4',
    imageUrl: AppAssets.post4,
    title: 'Minimalist Oak Desk',
    description:
        'A sleek and modern oak desk, perfect for a home office or study space. The desk has a large surface area and a built-in drawer for storage. It is in great condition with minor wear.',
    author: const Author(
      name: 'Chris Johnson',
      avatarUrl:
          'https://www.shutterstock.com/image-photo/handsome-happy-african-american-bearded-600nw-2460702995.jpg',
    ),
    price: 180,
    category: 'Furniture',
    rating: 4.9,
    isBestDeal: true,
    location: 'Los Angeles',
    createdAt: '2 days ago',
    gallery: [AppAssets.post4, AppAssets.post1],
  ),
];
