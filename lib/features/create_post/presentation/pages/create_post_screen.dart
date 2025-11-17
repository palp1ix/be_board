import 'package:be_board/core/navigation/app_navigator.dart';
import 'package:be_board/core/res/app_colors.dart';
import 'package:be_board/core/service_locator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:be_board/core/core.dart';
import 'package:be_board/core_ui/core_ui.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            isSliver: true,
            leading: IconButton(
              icon: const Icon(Icons.close, color: AppColors.textBlack),
              onPressed: () => sl<AppNavigator>().pop(),
            ),
            title: 'Create a new post',
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: AppColors.textGreyLight, height: 1.0),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const LinearProgressIndicator(
                      value: 0.25,
                      backgroundColor: AppColors.textGreyLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                      minHeight: 6,
                    ),
                  ),
                ),

                // Add Photos Section
                const _SectionTitle(title: 'Add Photos'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Add up to 10 photos. The first one is your cover.',
                    style: TextStyle(color: AppColors.textBody, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    color: AppColors.textGreyLight,
                    strokeWidth: 2,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    dashPattern: const [8, 4],
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 40,
                            color: AppColors.textGrey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Upload photos',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlack,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tap here to select photos from your library',
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const _Divider(),

                // Selling Section
                const _SectionTitle(title: 'What are you selling?'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const _CustomTextField(hintText: 'Title'),
                      const SizedBox(height: 16),
                      const _CustomTextField(
                        hintText: 'Price',
                        prefix: Text(
                          '\$',
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const _Divider(),

                // Category Section
                const _SectionTitle(title: 'Choose a Category'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                    onTap: () {},
                    child: InputDecorator(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.backgroundLight,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.textGreyLight,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.textGreyLight,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select a category',
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 16,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: AppColors.textGrey),
                        ],
                      ),
                    ),
                  ),
                ),
                const _Divider(),

                // Description Section
                const _SectionTitle(title: 'Describe your item'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _CustomTextField(
                    hintText: 'Tell us more about what you\'re selling...',
                    maxLines: 5,
                  ),
                ),
                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight.withOpacity(0.8),
          border: const Border(
            top: BorderSide(color: AppColors.textGreyLight, width: 1),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Post',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// Helper Widgets for CreatePostScreen
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: AppTextStyles.title.copyWith(fontSize: 24)),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Divider(color: AppColors.textGreyLight, height: 1),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final Widget? prefix;

  const _CustomTextField({
    required this.hintText,
    this.maxLines = 1,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: prefix,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: hintText,
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textGrey),
        filled: true,
        fillColor: AppColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.textGreyLight,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.textGreyLight,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
