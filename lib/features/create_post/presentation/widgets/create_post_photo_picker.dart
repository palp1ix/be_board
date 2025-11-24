import 'dart:io';
import 'package:be_board/core/core.dart';
import 'package:be_board/features/create_post/presentation/cubit/create_post_cubit.dart';
import 'package:dotted_border/dotted_border.dart';

class CreatePostPhotoPicker extends StatelessWidget {
  const CreatePostPhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(title: 'Photos'),
              const SizedBox(height: 8),
              Text(
                'Add up to 10 photos. The first one becomes the cover.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textBody),
              ),
              if (state.error != null) ...[
                const SizedBox(height: 8),
                Text(
                  state.error!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.red),
                ),
              ],
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  ...List.generate(
                    state.selectedPhotos.length,
                    (index) => _PhotoItem(
                      file: state.selectedPhotos[index],
                      onRemove: () =>
                          context.read<CreatePostCubit>().removePhoto(index),
                      isFirst: index == 0,
                    ),
                  ),
                  if (state.selectedPhotos.length < 10)
                    GestureDetector(
                      onTap: () => context.read<CreatePostCubit>().pickImages(),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(16),
                        dashPattern: const [8, 4],
                        strokeWidth: 1.5,
                        color: AppColors.textGreyLight,
                        child: Center(
                          child: state.isUploading
                              ? const CircularProgressIndicator()
                              : const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: AppColors.textGrey,
                                ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PhotoItem extends StatelessWidget {
  const _PhotoItem({
    required this.file,
    required this.onRemove,
    required this.isFirst,
  });

  final File file;
  final VoidCallback onRemove;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            file,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        if (isFirst)
          Positioned(
            bottom: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Cover',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textBlack,
      ),
    );
  }
}
