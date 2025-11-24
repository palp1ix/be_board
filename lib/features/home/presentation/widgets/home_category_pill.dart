import 'package:be_board/core/core.dart';

class HomeCategoryData {
  const HomeCategoryData({
    required this.label,
    required this.assetPath,
    required this.tag,
  });

  final String label;
  final String assetPath;
  final String tag;
}

class HomeCategoryPill extends StatelessWidget {
  const HomeCategoryPill({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final HomeCategoryData category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.textGreyLight,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: Image.asset(category.assetPath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.textBlack : AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
