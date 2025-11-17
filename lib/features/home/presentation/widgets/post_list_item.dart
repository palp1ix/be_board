import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/core/core.dart';

class PostListItem extends StatelessWidget {
  final PostItem item;

  const PostListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sl<AppNavigator>().push(AppRoutes.postDetails, extra: item);
      },
      child: Column(
        children: [
          Container(
            height: 210, // approx aspect-video for a common phone width
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(item.author.avatarUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item.location} • ${item.timeAgo}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
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
