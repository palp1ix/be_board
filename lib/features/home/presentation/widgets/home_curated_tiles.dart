import 'package:be_board/core/core.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';

class HomeCuratedTiles extends StatelessWidget {
  const HomeCuratedTiles({super.key, required this.items});

  final List<PostItem> items;

  @override
  Widget build(BuildContext context) {
    final subset = items.take(2).toList();

    return Row(
      children: subset
          .map(
            (item) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: subset.indexOf(item) == 0 ? 12 : 0,
                  left: subset.indexOf(item) == 1 ? 12 : 0,
                ),
                child: _MiniProductTile(item: item),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _MiniProductTile extends StatelessWidget {
  const _MiniProductTile({required this.item});

  final PostItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              item.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${item.price.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
