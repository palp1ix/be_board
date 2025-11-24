import 'package:be_board/core/core.dart';
import 'package:be_board/features/home/presentation/widgets/home_category_pill.dart';

class HomeCategoryCarousel extends StatelessWidget {
  const HomeCategoryCarousel({
    super.key,
    required this.categories,
    required this.selectedTag,
    required this.onCategoryChanged,
  });

  final List<HomeCategoryData> categories;
  final String selectedTag;
  final ValueChanged<String> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          return HomeCategoryPill(
            category: category,
            isSelected: category.tag == selectedTag,
            onTap: () => onCategoryChanged(category.tag),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemCount: categories.length,
      ),
    );
  }
}
