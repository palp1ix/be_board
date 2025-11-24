import 'package:be_board/core/core.dart';
import 'package:be_board/core/domain/repositories/posts_repository.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/features/home/presentation/cubit/home_cubit.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key, required this.item});

  final PostItem item;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  int _selectedImageIndex = 0;
  late bool _isFavorite;

  PostItem get item => widget.item;

  @override
  void initState() {
    super.initState();
    _isFavorite = item.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: Row(
                  children: [
                    AppIconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      backgroundColor: AppColors.white,
                      onPressed: () => sl<AppNavigator>().pop(),
                    ),
                    const Spacer(),
                    AppIconButton(
                      icon: Icon(Icons.file_upload_outlined),
                      backgroundColor: AppColors.white,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 12),
                    AppIconButton(
                      icon: Icon(
                        _isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                      ),
                      backgroundColor: AppColors.white,
                      iconColor: _isFavorite ? AppColors.primary : null,
                      onPressed: () async {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                        try {
                          await sl<PostsRepository>().toggleFavorite(item.id);
                          // Update HomeCubit if available
                          if (mounted) {
                            try {
                              context.read<HomeCubit>().toggleFavorite(item);
                            } catch (_) {
                              // HomeCubit not available in this context
                            }
                          }
                        } catch (e) {
                          // Revert on error
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: Image.network(
                            item.gallery[_selectedImageIndex],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: AppBadge(
                          label: item.category,
                          backgroundColor: AppColors.white.withValues(
                            alpha: 0.9,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFB44C),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.rating.toStringAsFixed(1),
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 4),
                              const Text('•'),
                              const SizedBox(width: 4),
                              Text(
                                '24 reviews',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textGrey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index) {
                    final image = item.gallery[index];
                    final isSelected = _selectedImageIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImageIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(image, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemCount: item.gallery.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textBlack,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '\$${item.price.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        if (item.oldPrice != null) ...[
                          const SizedBox(width: 10),
                          Text(
                            '\$${item.oldPrice!.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppColors.textGrey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                        ],
                        const Spacer(),
                        AppBadge(
                          label: item.isBestDeal ? 'Best price' : 'Limited',
                          backgroundColor: AppColors.textBlack,
                          textColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        AppBadge(
                          label: 'Free shipping',
                          icon: Icons.local_shipping_outlined,
                          backgroundColor: AppColors.white,
                        ),
                        const SizedBox(width: 12),
                        AppBadge(
                          label: 'Easy returns',
                          icon: Icons.loop_rounded,
                          backgroundColor: AppColors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textBody,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              item.author?.avatarUrl != null &&
                                  item.author!.avatarUrl.isNotEmpty
                              ? NetworkImage(item.author!.avatarUrl)
                              : null,
                          child:
                              item.author?.avatarUrl == null ||
                                  item.author!.avatarUrl.isEmpty
                              ? const Icon(Icons.person, size: 20)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.author?.name ?? 'Unknown',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${item.location} • ${item.createdAt}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textGrey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ), // Added spacing after the author info row
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundLight,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textGrey),
                              ),
                              Text(
                                '\$${item.price.toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                              ),
                              child: const Text('Send message'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
