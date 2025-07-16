import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
   AppBarComponent({super.key, this.title, this.actions, this.leading});
  final Widget? title;
  final Widget? leading;
   final List<Widget>? actions;

   @override
  Widget build(BuildContext context) {
    return AppBar(title:title ,actions: actions,leading: leading,);
  }
   @override
   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
