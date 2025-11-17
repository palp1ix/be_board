import 'package:be_board/features/home/data/mock_posts.dart';
import 'package:be_board/features/home/presentation/widgets/post_list_item.dart';
import 'package:be_board/core/core.dart';
import 'package:be_board/core_ui/core_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(
            isSliver: true,
            title: 'Be Board',
            leading: IconButton(icon: const Icon(Icons.menu, color: AppColors.textBlack), onPressed: () {}),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.textBlack),
                onPressed: () {
                  sl<AppNavigator>().push(AppRoutes.search);
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final currentItem = mockPosts[index];
                return PostListItem(item: currentItem);
              },
              childCount: mockPosts.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sl<AppNavigator>().push(AppRoutes.createPost);
        },
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
