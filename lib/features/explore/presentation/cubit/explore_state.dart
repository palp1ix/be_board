part of 'explore_cubit.dart';

class ExploreState extends Equatable {
  const ExploreState({
    required this.priceRange,
    required this.selectedCondition,
    required this.selectedCategories,
    required this.categories,
    required this.conditions,
    required this.isLoading,
    required this.searchQuery,
    required this.searchResults,
    required this.isSearching,
  });

  final RangeValues priceRange;
  final String? selectedCondition;
  final Set<String> selectedCategories;
  final List<Category> categories;
  final List<Condition> conditions;
  final bool isLoading;
  final String searchQuery;
  final List<PostItem> searchResults;
  final bool isSearching;

  ExploreState copyWith({
    RangeValues? priceRange,
    String? selectedCondition,
    Set<String>? selectedCategories,
    List<Category>? categories,
    List<Condition>? conditions,
    bool? isLoading,
    String? searchQuery,
    List<PostItem>? searchResults,
    bool? isSearching,
  }) {
    return ExploreState(
      priceRange: priceRange ?? this.priceRange,
      selectedCondition: selectedCondition ?? this.selectedCondition,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      categories: categories ?? this.categories,
      conditions: conditions ?? this.conditions,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
    priceRange,
    selectedCondition,
    selectedCategories,
    categories,
    conditions,
    isLoading,
    searchQuery,
    searchResults,
    isSearching,
  ];
}
