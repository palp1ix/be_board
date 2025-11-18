import 'package:be_board/features/home/domain/entities/post_item.dart';
import 'package:be_board/features/post_details/presentation/pages/post_details_screen.dart';
import 'package:be_board/core/core.dart';

class PostGridItem extends StatelessWidget {
  final PostItem item;

  const PostGridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PostDetailsScreen(item: item)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('\$${item.price.toStringAsFixed(0)}'),
                  const SizedBox(height: 4),
                  Text(
                    '${item.location} • ${item.createdAt}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
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
