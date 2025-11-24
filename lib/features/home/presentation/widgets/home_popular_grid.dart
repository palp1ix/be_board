import 'package:be_board/core/core.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/features/home/presentation/widgets/home_product_card.dart';

class HomePopularGrid extends StatelessWidget {
  const HomePopularGrid({
    super.key,
    required this.posts,
    required this.onItemTap,
    this.onFavoriteTap,
  });

  final List<PostItem> posts;
  final ValueChanged<PostItem> onItemTap;
  final ValueChanged<PostItem>? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 18,
          childAspectRatio: 0.68,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = posts[index];
          return HomeProductCard(
            item: item,
            onTap: () => onItemTap(item),
            onFavoriteTap: onFavoriteTap != null
                ? () => onFavoriteTap!(item)
                : null,
          );
        }, childCount: posts.length),
      ),
    );
  }
}
