import 'package:be_board/core/core.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.white,
    this.iconColor,
    this.size = 50,
    this.borderRadius = 15,
    this.borderColor,
    this.elevation = 0,
  });

  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double? borderRadius;
  final Color? iconColor;
  final double size;
  final Color? borderColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final borderRadiusGeometry = borderRadius != null
        ? BorderRadius.circular(borderRadius!)
        : BorderRadius.circular(size);

    return Material(
      color: backgroundColor,
      elevation: elevation,
      shadowColor: AppColors.black.withValues(alpha: 0.08),
      borderRadius: borderRadiusGeometry,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadiusGeometry,
        child: Container(
          height: size,
          width: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: borderRadiusGeometry,
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : null,
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
