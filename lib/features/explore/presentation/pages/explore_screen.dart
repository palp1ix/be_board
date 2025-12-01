import 'package:be_board/core/core.dart';
import 'package:be_board/features/explore/presentation/cubit/explore_cubit.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExploreCubit(sl(), sl()),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatelessWidget {
  const _ExploreView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: BlocBuilder<ExploreCubit, ExploreState>(
          builder: (context, state) {
            final cubit = context.read<ExploreCubit>();

            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textBlack,
                                ),
                          ),
                          const SizedBox(height: 12),
                          AppSearchInput(
                            hintText: 'Search all items...',
                            trailingIcon: const Icon(Icons.filter_alt_outlined),
                            onTrailingIconPressed: () {},
                            onChanged: cubit.updateSearchQuery,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              children: [
                                if (state.conditions.isNotEmpty) ...[
                                  _SectionTitle('Condition'),
                                  Wrap(
                                    spacing: 10,
                                    children: state.conditions.map((condition) {
                                      final isSelected =
                                          state.selectedCondition ==
                                          condition.name;
                                      return ChoiceChip(
                                        label: Text(condition.name),
                                        selected: isSelected,
                                        checkmarkColor: AppColors.white,
                                        color: WidgetStatePropertyAll(
                                          isSelected
                                              ? theme.primaryColor
                                              : AppColors.white,
                                        ),
                                        onSelected: (_) => cubit
                                            .selectCondition(condition.name),
                                        backgroundColor: AppColors.white,
                                        selectedColor: AppColors.textBlack,
                                        labelStyle: TextStyle(
                                          color: isSelected
                                              ? AppColors.white
                                              : AppColors.textBlack,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                                _SectionTitle('Price range'),
                                RangeSlider(
                                  values: state.priceRange,
                                  min: 0,
                                  max: 1000,
                                  activeColor: AppColors.textBlack,
                                  inactiveColor: AppColors.textGreyLight,
                                  onChanged: cubit.updatePrice,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${state.priceRange.start.round()}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                    Text(
                                      '\$${state.priceRange.end.round()}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                if (state.categories.isNotEmpty) ...[
                                  _SectionTitle('Categories'),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: state.categories.map((category) {
                                      final isSelected = state
                                          .selectedCategories
                                          .contains(category.name);
                                      return AppChip(
                                        label: category.name,
                                        isSelected: isSelected,
                                        onPressed: () =>
                                            cubit.toggleCategory(category.name),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                                _SectionTitle('Trending tags'),
                                Wrap(
                                  spacing: 10,
                                  children: const [
                                    AppBadge(
                                      label: '#minimal',
                                      backgroundColor: AppColors.white,
                                    ),
                                    AppBadge(
                                      label: '#sale',
                                      backgroundColor: AppColors.white,
                                    ),
                                    AppBadge(
                                      label: '#vintage',
                                      backgroundColor: AppColors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 90,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.searchQuery.isNotEmpty) {
                        sl<AppNavigator>().push(
                          AppRoutes.searchResults,
                          extra: {
                            'query': state.searchQuery,
                            'results': state.searchResults,
                          },
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        state.searchQuery.isNotEmpty
                            ? state.isSearching
                                  ? 'Searching...'
                                  : 'Show ${state.searchResults.length} items'
                            : 'Apply Filters',
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textBlack,
        ),
      ),
    );
  }
}
