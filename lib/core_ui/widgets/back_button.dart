import 'package:be_board/core/core.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.size = 40,
    this.backgroundColor = AppColors.backgroundLight,
    this.iconColor = AppColors.black,
    required this.onPressed,
  });

  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Icon(Icons.arrow_back, color: iconColor),
      ),
    );
  }
}
