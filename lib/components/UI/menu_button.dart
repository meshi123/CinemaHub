import 'package:cinema_hub/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.iconData,
    this.isActive = false,
    this.onTap,
  });

  /// is the window associated with this button currently active?
  final bool isActive;
  final VoidCallback? onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? Colors.pinkAccent : AppColors.colorPrimaryDark,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(iconData),
          ),
        ),
      ),
    );
  }
}
