import 'package:be_board/core/core.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onFilterTap});

  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '.beBoard',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textBlack,
                ),
              ),
              const Spacer(),
              AppIconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                backgroundColor: AppColors.white,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 18),
          AppSearchInput(
            hintText: 'Search products...',
            readOnly: true,
            onTap: onFilterTap,
            trailingIcon: const Icon(Icons.tune),
            onTrailingIconPressed: onFilterTap,
          ),
        ],
      ),
    );
  }
}
