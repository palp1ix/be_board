import 'package:be_board/core/core.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onPressed,
    this.leading,
    this.trailing,
    this.padding,
    this.selectedColor,
    this.backgroundColor,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? padding;
  final Color? selectedColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final Color chipBackground = isSelected
        ? (selectedColor ?? AppColors.textBlack)
        : (backgroundColor ?? AppColors.white);
    final Color textColor = isSelected ? AppColors.white : AppColors.textBlack;

    return Material(
      color: chipBackground,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 8)],
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          ),
        ),
      ),
    );
  }
}
