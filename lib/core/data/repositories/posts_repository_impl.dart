import 'package:be_board/core/data/datasources/posts_remote_data_source.dart';
import 'package:be_board/core/domain/repositories/posts_repository.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource remoteDataSource;

  PostsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PostItem>> getPosts() {
    return remoteDataSource.getPosts();
  }

  @override
  Future<void> createPost(PostItem post) {
    return remoteDataSource.createPost(post);
  }

  @override
  Future<void> toggleFavorite(String postId) {
    return remoteDataSource.toggleFavorite(postId);
  }

  @override
  Future<List<PostItem>> getFavoritePosts() {
    return remoteDataSource.getFavoritePosts();
  }

  @override
  Future<List<PostItem>> searchPosts(String query) {
    return remoteDataSource.searchPosts(query);
  }
}
