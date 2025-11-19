import 'package:be_board/core/core.dart';
import 'package:be_board/features/home/data/mock_posts.dart';
import 'package:be_board/features/home/presentation/cubit/home_cubit.dart';
import 'package:be_board/features/home/presentation/widgets/home_category_carousel.dart';
import 'package:be_board/features/home/presentation/widgets/home_category_pill.dart';
import 'package:be_board/features/home/presentation/widgets/home_curated_tiles.dart';
import 'package:be_board/features/home/presentation/widgets/home_filter_chips.dart';
import 'package:be_board/features/home/presentation/widgets/home_header.dart';
import 'package:be_board/features/home/presentation/widgets/home_popular_grid.dart';
import 'package:be_board/features/home/presentation/widgets/home_promo_card.dart';
import 'package:be_board/features/home/presentation/widgets/home_section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(posts: mockPosts),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  static final List<HomeCategoryData> _categoryData = [
    HomeCategoryData(
      label: 'Interior',
      assetPath: AppAssets.post1,
      tag: 'Interior',
    ),
    HomeCategoryData(
      label: 'Technology',
      assetPath: AppAssets.post2,
      tag: 'Technology',
    ),
    HomeCategoryData(
      label: 'Lighting',
      assetPath: AppAssets.post3,
      tag: 'Lighting',
    ),
    HomeCategoryData(
      label: 'Furniture',
      assetPath: AppAssets.post4,
      tag: 'Furniture',
    ),
    HomeCategoryData(
      label: 'Dishes',
      assetPath: AppAssets.post3,
      tag: 'Dishes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: HomeHeader(
                    onFilterTap: () =>
                        sl<AppNavigator>().push(AppRoutes.explore),
                    onMessengerTap: () =>
                        sl<AppNavigator>().push(AppRoutes.messenger),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HomeCategoryCarousel(
                    categories: _categoryData,
                    selectedTag: state.selectedCategory,
                    onCategoryChanged: context.read<HomeCubit>().selectCategory,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: HomeFilterChips(
                      categories: state.categories,
                      selectedCategory: state.selectedCategory,
                      onCategorySelected: context
                          .read<HomeCubit>()
                          .selectCategory,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        const HomePromoCard(),
                        const SizedBox(height: 24),
                        HomeSectionHeader(
                          title: 'Popular products',
                          onActionTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                HomePopularGrid(
                  posts: state.filteredPosts,
                  onItemTap: (item) => sl<AppNavigator>().push(
                    AppRoutes.postDetails,
                    extra: item,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeSectionHeader(
                          title: 'For your calm space',
                          onActionTap: () {},
                        ),
                        const SizedBox(height: 12),
                        HomeCuratedTiles(items: state.posts),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sl<AppNavigator>().push(AppRoutes.createPost),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
