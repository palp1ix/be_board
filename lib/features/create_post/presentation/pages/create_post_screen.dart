import 'package:be_board/core/core.dart';
import 'package:be_board/features/create_post/presentation/cubit/create_post_cubit.dart';
import 'package:be_board/features/create_post/presentation/widgets/create_post_details_form.dart';
import 'package:be_board/features/create_post/presentation/widgets/create_post_header.dart';
import 'package:be_board/features/create_post/presentation/widgets/create_post_photo_picker.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePostCubit(),
      child: const _CreatePostView(),
    );
  }
}

class _CreatePostView extends StatelessWidget {
  const _CreatePostView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: CreatePostHeader()),
            const SliverToBoxAdapter(child: CreatePostPhotoPicker()),
            SliverToBoxAdapter(
              child: Column(
                children: const [
                  CreatePostDetailsForm(),
                  SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: ElevatedButton(onPressed: () {}, child: const Text('Post item')),
      ),
    );
  }
}
