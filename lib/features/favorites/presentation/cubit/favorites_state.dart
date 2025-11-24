part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  const FavoritesState({required this.favoritePosts, required this.isLoading});

  final List<PostItem> favoritePosts;
  final bool isLoading;

  FavoritesState copyWith({List<PostItem>? favoritePosts, bool? isLoading}) {
    return FavoritesState(
      favoritePosts: favoritePosts ?? this.favoritePosts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [favoritePosts, isLoading];
}
