import 'package:be_board/core/core.dart';
import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/features/home/presentation/widgets/home_product_card.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({
    super.key,
    required this.query,
    required this.results,
  });

  final String query;
  final List<PostItem> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(query.isEmpty ? 'Search Results' : '"$query"'),
      ),
      body: results.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'No items found',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.textGrey),
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final post = results[index];
                return HomeProductCard(
                  item: post,
                  onTap: () {
                    sl<AppNavigator>().push(AppRoutes.postDetails, extra: post);
                  },
                );
              },
            ),
    );
  }
}
