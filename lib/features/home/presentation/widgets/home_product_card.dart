import 'package:be_board/core/core.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';

class HomeProductCard extends StatelessWidget {
  const HomeProductCard({
    super.key,
    required this.item,
    required this.onTap,
    this.onFavoriteTap,
  });

  final PostItem item;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      child: Image.network(item.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: AppBadge(
                      label: item.isBestDeal
                          ? 'Best price'
                          : item.discountPercentage != null
                          ? '${item.discountPercentage}% off'
                          : 'New arrival',
                      backgroundColor: AppColors.white.withValues(alpha: 0.85),
                      textColor: AppColors.textBlack,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Opacity(
                      opacity: 0.9,
                      child: AppIconButton(
                        icon: Icon(
                          size: 20,
                          item.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        backgroundColor: AppColors.white,
                        iconColor: item.isFavorite
                            ? AppColors.primary
                            : AppColors.textBlack,
                        size: 34,
                        borderRadius: 12,
                        onPressed: onFavoriteTap ?? () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        '\$${item.price.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textBlack,
                            ),
                      ),
                      if (item.oldPrice != null) ...[
                        const SizedBox(width: 6),
                        Text(
                          '\$${item.oldPrice!.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.textGrey,
                              ),
                        ),
                      ],
                      const Spacer(),
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFB44C),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
