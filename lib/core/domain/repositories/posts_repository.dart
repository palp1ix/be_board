import 'package:be_board/features/home/domain/entities/post_item.dart';

abstract class PostsRepository {
  Future<List<PostItem>> getPosts();
  Future<void> createPost(PostItem post);
  Future<void> toggleFavorite(String postId);
  Future<List<PostItem>> getFavoritePosts();
  Future<List<PostItem>> searchPosts(String query);
}
