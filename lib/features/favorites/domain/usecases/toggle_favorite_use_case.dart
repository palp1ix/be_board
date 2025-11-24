import 'package:be_board/core/domain/repositories/posts_repository.dart';

class ToggleFavoriteUseCase {
  final PostsRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(String postId) async {
    return repository.toggleFavorite(postId);
  }
}
