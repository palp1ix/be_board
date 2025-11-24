import 'package:be_board/core/core.dart';
import 'package:be_board/core/domain/entities/category.dart';
import 'package:be_board/core/domain/entities/condition.dart';
import 'package:be_board/core/domain/repositories/categories_repository.dart';
import 'package:be_board/core/domain/repositories/posts_repository.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final CategoriesRepository _categoriesRepository;
  final PostsRepository _postsRepository;

  ExploreCubit(this._categoriesRepository, this._postsRepository)
    : super(
        const ExploreState(
          priceRange: RangeValues(150, 750),
          selectedCondition: null,
          selectedCategories: {},
          categories: [],
          conditions: [],
          isLoading: false,
          searchQuery: '',
          searchResults: [],
          isSearching: false,
        ),
      ) {
    _init();
  }

  Future<void> _init() async {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true));
    try {
      final categories = await _categoriesRepository.getCategories();
      final conditions = await _categoriesRepository.getConditions();
      if (isClosed) return;
      emit(
        state.copyWith(
          categories: categories,
          conditions: conditions,
          selectedCondition: conditions.isNotEmpty
              ? conditions.first.name
              : null,
          isLoading: false,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoading: false));
    }
  }

  void selectCondition(String condition) {
    emit(state.copyWith(selectedCondition: condition));
  }

  void updatePrice(RangeValues range) {
    emit(state.copyWith(priceRange: range));

    // Re-run search if there's an active query
    if (state.searchQuery.isNotEmpty) {
      _performSearch();
    }
  }

  void toggleCategory(String category) {
    final updated = Set<String>.from(state.selectedCategories);
    if (updated.contains(category)) {
      updated.remove(category);
    } else {
      updated.add(category);
    }
    emit(state.copyWith(selectedCategories: updated));

    // Re-run search if there's an active query
    if (state.searchQuery.isNotEmpty) {
      _performSearch();
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));

    if (query.isEmpty) {
      // Clear search results when query is empty
      emit(state.copyWith(searchResults: [], isSearching: false));
    } else {
      _performSearch();
    }
  }

  Future<void> _performSearch() async {
    if (state.searchQuery.isEmpty) return;

    if (isClosed) return;
    emit(state.copyWith(isSearching: true));

    try {
      // Get search results from repository
      var results = await _postsRepository.searchPosts(state.searchQuery);

      // Apply filters to search results
      results = _applyFilters(results);

      if (isClosed) return;
      emit(state.copyWith(searchResults: results, isSearching: false));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(searchResults: [], isSearching: false));
    }
  }

  List<PostItem> _applyFilters(List<PostItem> posts) {
    var filtered = posts;

    // Filter by selected categories
    if (state.selectedCategories.isNotEmpty) {
      filtered = filtered.where((post) {
        return state.selectedCategories.contains(post.category);
      }).toList();
    }

    // Filter by price range
    filtered = filtered.where((post) {
      return post.price >= state.priceRange.start &&
          post.price <= state.priceRange.end;
    }).toList();

    // Filter by condition if selected
    // Note: PostItem doesn't have a condition field currently
    // If you add it later, uncomment this:
    // if (state.selectedCondition != null) {
    //   filtered = filtered.where((post) {
    //     return post.condition == state.selectedCondition;
    //   }).toList();
    // }

    return filtered;
  }
}
