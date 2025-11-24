part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.selectedCategory,
    required this.posts,
    required this.filteredPosts,
    required this.categories,
    required this.isLoading,
  });

  final String selectedCategory;
  final List<String> categories;
  final List<PostItem> posts;
  final List<PostItem> filteredPosts;
  final bool isLoading;

  HomeState copyWith({
    String? selectedCategory,
    List<PostItem>? filteredPosts,
    List<PostItem>? posts,
    List<String>? categories,
    bool? isLoading,
  }) {
    return HomeState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      posts: posts ?? this.posts,
      filteredPosts: filteredPosts ?? this.filteredPosts,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
    selectedCategory,
    posts,
    filteredPosts,
    categories,
    isLoading,
  ];
}
