import 'package:be_board/core/core.dart';

class AppSearchInput extends StatelessWidget {
  const AppSearchInput({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.leading,
    this.margin,
    this.backgroundColor = AppColors.white,
    required this.trailingIcon,
    required this.onTrailingIconPressed,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? leading;
  final EdgeInsets? margin;
  final Color backgroundColor;
  final Widget trailingIcon;
  final VoidCallback onTrailingIconPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: margin,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onChanged: onChanged,
              onTap: onTap,
              decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: theme.inputDecorationTheme.border,
                focusedBorder: theme.inputDecorationTheme.border,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                prefixIcon:
                    leading ??
                    const Icon(Icons.search_rounded, color: AppColors.textGrey),
              ),
            ),
          ),
        ),

        SizedBox(width: 15),

        AppIconButton(
          borderRadius: 15,
          size: 55,
          icon: trailingIcon,
          onPressed: onTrailingIconPressed,
        ),
      ],
    );
  }
}
