import 'package:be_board/core/core.dart';
import 'package:be_board/features/create_post/presentation/cubit/create_post_cubit.dart';

class CreatePostHeader extends StatelessWidget {
  const CreatePostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppIconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () => sl<AppNavigator>().pop(),
                  ),
                  const Spacer(),
                  AppBadge(
                    label: '${(state.progress * 100).round()}%',
                    backgroundColor: AppColors.white,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Create listing',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: state.progress,
                  minHeight: 6,
                  backgroundColor: AppColors.textGreyLight,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
