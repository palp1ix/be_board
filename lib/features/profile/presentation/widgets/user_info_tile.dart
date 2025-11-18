import 'package:be_board/core/res/app_colors.dart';
import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const UserInfoTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.textGrey,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textBlack,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.textGrey,
          fontSize: 14,
        ),
      ),
    );
  }
}
