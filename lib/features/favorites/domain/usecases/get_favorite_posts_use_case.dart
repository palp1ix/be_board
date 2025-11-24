import 'package:be_board/core/domain/repositories/posts_repository.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';

class GetFavoritePostsUseCase {
  final PostsRepository repository;

  GetFavoritePostsUseCase(this.repository);

  Future<List<PostItem>> call() async {
    return repository.getFavoritePosts();
  }
}
