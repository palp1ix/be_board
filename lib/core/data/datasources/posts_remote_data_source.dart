import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/features/home/domain/entities/author.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostItem>> getPosts();
  Future<void> createPost(PostItem post);
  Future<void> toggleFavorite(String postId);
  Future<List<PostItem>> getFavoritePosts();
  Future<List<PostItem>> searchPosts(String query);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final SupabaseClient supabaseClient;

  PostsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<PostItem>> getPosts() async {
    final userId = supabaseClient.auth.currentUser?.id;

    final response = await supabaseClient
        .from('posts')
        .select(
          '*, profiles!author_id(name, avatar_url), categories!category_id(name), conditions!condition_id(name), favorites!left(user_id)',
        )
        .order('created_at', ascending: false);

    return (response as List).map((e) {
      final profileData = e['profiles'] ?? {};
      final author = Author(
        name: profileData['name'] ?? 'Unknown',
        avatarUrl: profileData['avatar_url'] ?? '',
      );

      // Check if the current user has favorited this post
      final favorites = e['favorites'] as List?;
      final isFavorite =
          userId != null &&
          favorites != null &&
          favorites.any((f) => f['user_id'] == userId);

      return PostItem(
        id: e['id'],
        imageUrl: (e['image_urls'] as List).isNotEmpty
            ? (e['image_urls'] as List).first
            : '',
        title: e['title'],
        description: e['description'],
        author: author,
        price: (e['price'] as num).toDouble(),
        location: e['location'],
        createdAt: e['created_at'],
        category: e['categories']['name'],
        rating: (e['rating'] as num).toDouble(),
        oldPrice: e['old_price'] != null
            ? (e['old_price'] as num).toDouble()
            : null,
        discountPercentage: e['discount_percentage'],
        isFavorite: isFavorite,
        isBestDeal: e['is_best_deal'] ?? false,
        gallery: List<String>.from(e['image_urls'] ?? []),
      );
    }).toList();
  }

  @override
  Future<void> toggleFavorite(String postId) async {
    final userId = supabaseClient.auth.currentUser!.id;

    final existing = await supabaseClient
        .from('favorites')
        .select()
        .eq('user_id', userId)
        .eq('post_id', postId)
        .maybeSingle();

    if (existing != null) {
      await supabaseClient
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('post_id', postId);
    } else {
      await supabaseClient.from('favorites').insert({
        'user_id': userId,
        'post_id': postId,
      });
    }
  }

  @override
  Future<List<PostItem>> getFavoritePosts() async {
    final userId = supabaseClient.auth.currentUser!.id;

    final response = await supabaseClient
        .from('posts')
        .select(
          '*, profiles!author_id(name, avatar_url), categories!category_id(name), conditions!condition_id(name), favorites!inner(user_id)',
        )
        .eq('favorites.user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((e) {
      final profileData = e['profiles'] ?? {};
      final author = Author(
        name: profileData['name'] ?? 'Unknown',
        avatarUrl: profileData['avatar_url'] ?? '',
      );

      return PostItem(
        id: e['id'],
        imageUrl: (e['image_urls'] as List).isNotEmpty
            ? (e['image_urls'] as List).first
            : '',
        title: e['title'],
        description: e['description'],
        author: author,
        price: (e['price'] as num).toDouble(),
        location: e['location'],
        createdAt: e['created_at'],
        category: e['categories']['name'],
        rating: (e['rating'] as num).toDouble(),
        oldPrice: e['old_price'] != null
            ? (e['old_price'] as num).toDouble()
            : null,
        discountPercentage: e['discount_percentage'],
        isFavorite: true, // Always true for favorite posts
        isBestDeal: e['is_best_deal'] ?? false,
        gallery: List<String>.from(e['image_urls'] ?? []),
      );
    }).toList();
  }

  @override
  Future<void> createPost(PostItem post) async {
    // Note: This assumes we handle image upload separately and just pass URLs here,
    // or we need to implement image upload logic. For now, assuming URLs are present.
    // Also need to resolve category_id and condition_id from names if we only have names in PostItem,
    // but ideally PostItem should have IDs or we fetch them.
    // For simplicity in this step, I'll assume we might need to adjust PostItem or lookup IDs.
    // However, the current PostItem only has String category.
    // We might need to fetch category ID by name.

    final categoryResponse = await supabaseClient
        .from('categories')
        .select('id')
        .eq('name', post.category)
        .single();

    final categoryId = categoryResponse['id'];

    // Default condition to 'New' if not specified or handle it.
    // PostItem doesn't have condition field in the entity shown earlier?
    // Wait, let me check PostItem again.

    await supabaseClient.from('posts').insert({
      'title': post.title,
      'description': post.description,
      'price': post.price,
      'location': post.location,
      'category_id': categoryId,
      'image_urls': post.gallery,
      'author_id': supabaseClient.auth.currentUser!.id,
      // 'condition_id': ... // PostItem needs condition field
    });
  }

  @override
  Future<List<PostItem>> searchPosts(String query) async {
    final userId = supabaseClient.auth.currentUser?.id;

    // Search posts by title or description using ilike (case-insensitive)
    final response = await supabaseClient
        .from('posts')
        .select(
          '*, profiles!author_id(name, avatar_url), categories!category_id(name), conditions!condition_id(name), favorites!left(user_id)',
        )
        .or('title.ilike.%$query%,description.ilike.%$query%')
        .order('created_at', ascending: false);

    return (response as List).map((e) {
      final profileData = e['profiles'] ?? {};
      final author = Author(
        name: profileData['name'] ?? 'Unknown',
        avatarUrl: profileData['avatar_url'] ?? '',
      );

      // Check if the current user has favorited this post
      final favorites = e['favorites'] as List?;
      final isFavorite =
          userId != null &&
          favorites != null &&
          favorites.any((f) => f['user_id'] == userId);

      return PostItem(
        id: e['id'],
        imageUrl: (e['image_urls'] as List).isNotEmpty
            ? (e['image_urls'] as List).first
            : '',
        title: e['title'],
        description: e['description'],
        author: author,
        price: (e['price'] as num).toDouble(),
        location: e['location'],
        createdAt: e['created_at'],
        category: e['categories']['name'],
        rating: (e['rating'] as num).toDouble(),
        oldPrice: e['old_price'] != null
            ? (e['old_price'] as num).toDouble()
            : null,
        discountPercentage: e['discount_percentage'],
        isFavorite: isFavorite,
        isBestDeal: e['is_best_deal'] ?? false,
        gallery: List<String>.from(e['image_urls'] ?? []),
      );
    }).toList();
  }
}
