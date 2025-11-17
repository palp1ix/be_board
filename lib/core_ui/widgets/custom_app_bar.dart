import 'dart:math';

import 'package:be_board/core/res/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? flexibleSpace;
  final double? expandedHeight;
  final List<Widget>? actions;
  final bool isSliver;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.flexibleSpace,
    this.expandedHeight,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTitle = title != null
        ? Text(title!,
            style: const TextStyle(
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold,
                fontSize: 18))
        : null;

    if (isSliver) {
      return SliverAppBar(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: flexibleSpace,
        expandedHeight: expandedHeight,
        title: textTitle,
        leading: leading,
        actions: actions,
        pinned: true,
        centerTitle: true,
        bottom: bottom,
      );
    } else {
      return AppBar(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: textTitle,
        leading: leading,
        actions: actions,
        centerTitle: true,
        bottom: bottom,
      );
    }
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
