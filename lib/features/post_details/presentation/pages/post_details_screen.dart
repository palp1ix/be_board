import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/core/core.dart';
import 'package:be_board/core_ui/core_ui.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostItem item;

  const PostDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            isSliver: true,
            leading: AppBackButton(
              size: 45,
              onPressed: () => sl<AppNavigator>().pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_horiz, color: AppColors.textBlack),
                onPressed: () {},
              ),
            ],
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item.imageUrl, // Using the item's image
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black45],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 1.0],
                      ),
                    ),
                  ),
                  // Image dots indicator
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == 0
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${item.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 30,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textBody,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(item.author.avatarUrl),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        item.author.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4, // Corresponds to shadow-lg
          ),
          child: const Text(
            'Send Message',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
