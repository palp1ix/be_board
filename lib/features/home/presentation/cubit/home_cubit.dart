import 'package:be_board/core/core.dart';
import 'package:be_board/core/domain/repositories/categories_repository.dart';
import 'package:be_board/core/domain/repositories/posts_repository.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PostsRepository _postsRepository;
  final CategoriesRepository _categoriesRepository;

  HomeCubit({
    required PostsRepository postsRepository,
    required CategoriesRepository categoriesRepository,
  }) : _postsRepository = postsRepository,
       _categoriesRepository = categoriesRepository,
       super(
         const HomeState(
           selectedCategory: 'All',
           posts: [],
           filteredPosts: [],
           categories: [],
           isLoading: true,
         ),
       ) {
    // Schedule loading after the first frame to ensure BlocBuilder is subscribed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  Future<void> loadData() async {
    if (isClosed) return;

    try {
      final posts = await _postsRepository.getPosts();
      final categories = await _categoriesRepository.getCategories();
      final categoryNames = categories.map((c) => c.name).toList();

      if (isClosed) return;
      emit(
        state.copyWith(
          posts: posts,
          filteredPosts: posts,
          categories: categoryNames,
          isLoading: false,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoading: false));
      // TODO: Add error state handling
      rethrow;
    }
  }

  void selectCategory(String category) {
    final filtered = category == 'All'
        ? state.posts
        : state.posts.where((post) => post.category == category).toList();

    emit(
      state.copyWith(
        selectedCategory: category,
        filteredPosts: filtered.isEmpty ? state.posts : filtered,
      ),
    );
  }

  Future<void> toggleFavorite(PostItem post) async {
    // Optimistic update
    final updatedPosts = state.posts.map((p) {
      if (p.id == post.id) {
        return PostItem(
          id: p.id,
          imageUrl: p.imageUrl,
          title: p.title,
          description: p.description,
          author: p.author,
          price: p.price,
          location: p.location,
          createdAt: p.createdAt,
          category: p.category,
          rating: p.rating,
          oldPrice: p.oldPrice,
          discountPercentage: p.discountPercentage,
          isFavorite: !p.isFavorite,
          isBestDeal: p.isBestDeal,
          gallery: p.gallery,
        );
      }
      return p;
    }).toList();

    final updatedFiltered = state.selectedCategory == 'All'
        ? updatedPosts
        : updatedPosts
              .where((p) => p.category == state.selectedCategory)
              .toList();

    emit(state.copyWith(posts: updatedPosts, filteredPosts: updatedFiltered));

    try {
      await _postsRepository.toggleFavorite(post.id);
    } catch (e) {
      // Revert if failed
      emit(
        state.copyWith(posts: state.posts, filteredPosts: state.filteredPosts),
      );
    }
  }
}
