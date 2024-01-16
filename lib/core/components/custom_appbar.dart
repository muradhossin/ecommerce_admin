import 'package:ecommerce_admin/core/extensions/context.dart';
import 'package:ecommerce_admin/core/extensions/style.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? titleColor;
  final Color? iconColor;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? backgroundColor;
  final bool primary;

  const CustomAppbar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.elevation,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.primary = true,

  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle().regular.copyWith(color: titleColor ?? context.theme.cardColor)),
      actions: actions,
      leading: leading,
      iconTheme: IconThemeData(color: iconColor ?? context.theme.cardColor),
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      bottom: bottom,
      elevation: elevation,
      backgroundColor: backgroundColor ?? context.theme.primaryColor,
      primary: primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
