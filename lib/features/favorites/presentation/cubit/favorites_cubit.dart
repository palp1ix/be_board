import 'package:be_board/core/core.dart';
import 'package:be_board/core/domain/repositories/posts_repository.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final PostsRepository _postsRepository;

  FavoritesCubit({required PostsRepository postsRepository})
    : _postsRepository = postsRepository,
      super(const FavoritesState(favoritePosts: [], isLoading: true)) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFavorites();
    });
  }

  Future<void> loadFavorites() async {
    if (isClosed) return;

    try {
      final favorites = await _postsRepository.getFavoritePosts();
      if (isClosed) return;
      emit(state.copyWith(favoritePosts: favorites, isLoading: false));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> toggleFavorite(PostItem post) async {
    // Optimistically remove from list
    final updatedFavorites = state.favoritePosts
        .where((p) => p.id != post.id)
        .toList();
    emit(state.copyWith(favoritePosts: updatedFavorites));

    try {
      await _postsRepository.toggleFavorite(post.id);
    } catch (e) {
      // Revert if failed
      await loadFavorites();
    }
  }
}
