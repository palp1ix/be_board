import 'package:be_board/core/core.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatarUrl;
  final double radius;

  const ProfileAvatar({super.key, required this.avatarUrl, this.radius = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.textGreyLight,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: avatarUrl != null
              ? NetworkImage(avatarUrl!)
              : AssetImage(AppAssets.placeholder) as ImageProvider,
        ),
      ),
    );
  }
}
