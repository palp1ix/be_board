import 'package:be_board/core/core.dart';
import 'package:be_board/features/create_post/presentation/cubit/create_post_cubit.dart';

class CreatePostDetailsForm extends StatelessWidget {
  const CreatePostDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        final cubit = context.read<CreatePostCubit>();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FormSection(
                title: 'What are you selling?',
                child: Column(
                  children: [
                    _CreatePostTextField(
                      hintText: 'Title',
                      onChanged: cubit.setTitle,
                    ),
                    const SizedBox(height: 12),
                    _CreatePostTextField(
                      hintText: 'Price',
                      onChanged: cubit.setPrice,
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.currency_ruble_rounded,
                          color: AppColors.textGrey,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _FormSection(
                title: 'Choose a category',
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        children: state.categories.map((category) {
                          final isSelected =
                              state.selectedCategory?.id == category.id;
                          return _CategoryChip(
                            label: category.name,
                            selected: isSelected,
                            onTap: () => cubit.setCategory(category.name),
                          );
                        }).toList(),
                      ),
              ),
              const SizedBox(height: 24),
              _FormSection(
                title: 'Description',
                child: _CreatePostTextField(
                  hintText: 'Tell us more about what you\'re selling...',
                  maxLines: 5,
                  onChanged: cubit.setDescription,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _CreatePostTextField extends StatelessWidget {
  const _CreatePostTextField({
    required this.hintText,
    this.maxLines = 1,
    this.prefix,
    this.onChanged,
  });

  final String hintText;
  final int maxLines;
  final Widget? prefix;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.textGreyLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.textGreyLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppChip(label: label, isSelected: selected, onPressed: onTap);
  }
}
